# Tumbleweed

中英双语技术博客，基于 Hugo Extended + PaperMod，托管在 GitHub Pages。

- 中文：`https://zz-zzy.github.io/tumbleweed/`
- 英文：`https://zz-zzy.github.io/tumbleweed/en/`

## 本地预览

本机 Hugo 安装在 WinGet 目录（已加入 PATH，重开终端后可直接用 `hugo`）：

```powershell
hugo server -D
```

站点会在 `http://localhost:1313/tumbleweed/` 下打开。

## 写新文章

```powershell
hugo new content zh-cn/posts/my-post.md
hugo new content en/posts/my-post.md
```

两篇用**相同的文件名和 `translationKey`**，页面右上角就会出现语言切换。写完把 `draft: true` 改成 `false`。

## 发布

1. 在 GitHub 新建**公开**仓库 `tumbleweed`（`gh repo create tumbleweed --public --source . --remote origin --push`）。
2. 仓库 Settings → Pages → Source 选择 **GitHub Actions**。
3. 之后每次 `git push origin main` 会自动构建发布。

> 如果仓库名或账号不同：改 `hugo.toml` 的 `baseURL`、`params.utterances.repo` 和本文件里的链接。

## 评论（utterances）

评论存在仓库的 Issues 里：

1. 安装 GitHub App：<https://github.com/apps/utterances>
2. 授权给 `zz-zzy/tumbleweed`。
3. 打开任意文章即可评论，首次评论会自动建 issue。

## 统计（可选）

在 `hugo.toml` 的 `[services.googleAnalytics]` 填入 GA4 ID，例如 `ID = "G-XXXXXXXXXX"`。

## 改样式

- 主题参数：`hugo.toml` 的 `[params]`
- 自定义 CSS：`assets/css/extended/custom.css`
- 评论脚本：`layouts/_partials/comments.html`
- 主题是 vendored 的（`themes/PaperMod`），升级时重新下载解压覆盖即可。
