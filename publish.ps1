<#
  发布脚本：把当前工作区通过 GitHub Git Data API 推送到远程并触发 Pages 部署。
  适用于 git 到 github.com 直连不通的网络环境（只依赖 api.github.com）。

  用法：
    pwsh -File publish.ps1
    pwsh -File publish.ps1 -Message "更新内容"
#>
param(
    [string]$Message = "Update site",
    [string]$Repo = "zz-zzy/tumbleweed",
    [string]$Branch = "main"
)

$ErrorActionPreference = "Stop"
Set-Location (Split-Path -Parent $MyInvocation.MyCommand.Path)

# 1. 确保已登录 gh
gh auth status *> $null
if ($LASTEXITCODE -ne 0) { throw "gh 未登录，先运行: gh auth login" }

# 2. 收集所有纳入版本控制的文件
git add -A
$files = @(git ls-files)
if ($files.Count -eq 0) { throw "没有可发布的文件" }

# 3. 组装 tree（统一为 LF 换行）
$entries = foreach ($f in $files) {
    $raw = Get-Content -LiteralPath $f -Raw -Encoding UTF8
    $raw = $raw -replace "`r`n", "`n"
    [ordered]@{ path = $f; mode = "100644"; type = "blob"; content = $raw }
}
$treeJson = Join-Path $env:TEMP "tumbleweed-tree.json"
[System.IO.File]::WriteAllText($treeJson, ([ordered]@{ tree = @($entries) } | ConvertTo-Json -Depth 6 -Compress), (New-Object System.Text.UTF8Encoding($false)))

# 4. 读取远端 HEAD
$head = gh api "repos/$Repo/git/refs/heads/$Branch" --jq .object.sha
if (-not $head) { throw "无法读取远端 HEAD" }

# 5. 创建 tree
$tree = gh api --method POST "repos/$Repo/git/trees" --input $treeJson | ConvertFrom-Json

# 6. 创建 commit
$name = git config user.name
$mail = git config user.email
$now = Get-Date -Format o
$commitJson = Join-Path $env:TEMP "tumbleweed-commit.json"
$commitBody = @{
    message = $Message
    tree = $tree.sha
    parents = @($head)
    author = @{ name = $name; email = $mail; date = $now }
} | ConvertTo-Json -Depth 5 -Compress
[System.IO.File]::WriteAllText($commitJson, $commitBody, (New-Object System.Text.UTF8Encoding($false)))
$commit = gh api --method POST "repos/$Repo/git/commits" --input $commitJson | ConvertFrom-Json

# 7. 更新分支（fast-forward）
gh api --method PATCH "repos/$Repo/git/refs/heads/$Branch" -f "sha=$($commit.sha)" | Out-Null

Write-Host "已发布: $($commit.sha)  (共 $($files.Count) 个文件)"
Write-Host "地址: https://zz-zzy.github.io/tumbleweed/"
Write-Host "查看部署: gh run list --repo $Repo"
