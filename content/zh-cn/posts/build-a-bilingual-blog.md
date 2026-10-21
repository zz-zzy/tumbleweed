---
title: "从零搭一个中英双语技术博客"
date: 2026-10-21T10:00:00+08:00
draft: false
slug: "build-a-bilingual-blog"
translationKey: "build-a-bilingual-blog"
summary: "Hugo + PaperMod + GitHub Pages 的最小可用配置：双语目录、系列分类、站内搜索、评论与自动部署。"
description: "记录这个站点的搭建方式：Hugo Extended、PaperMod、双语内容目录、utterances 评论和 GitHub Actions 部署。"
tags: ["Hugo", "建站"]
categories: ["工程"]
series: ["建站笔记"]
ShowToc: true
TocOpen: false
cover:
  image: "img/covers/default.svg"
  alt: "Tumbleweed"
  caption: ""
---

> **TL;DR** —— 站点用 Hugo Extended + PaperMod 构建，中文在根路径、英文在 `/en/`，评论挂在 GitHub Issues 上，推送即部署。

## 为什么是这套组合

静态博客的长期成本主要在维护，而不在搭建。Hugo 的构建速度快、依赖少；PaperMod 提供了深色模式、目录、站内搜索、归档和 SEO 元信息，几乎不需要写主题代码。

## 目录结构

```text
tumbleweed/
├── content/
│   ├── zh-cn/          # 中文内容 → 站点根路径
│   └── en/             # 英文内容 → /en/
├── layouts/_partials/  # comments.html / extend_head.html
├── assets/css/extended # 自定义样式
├── themes/PaperMod
└── hugo.toml
```

## 三个关键配置

| 需求 | 配置位置 |
|---|---|
| 双语切换 | `[languages.zh-cn]` 与 `[languages.en]` 的 `contentDir` |
| 系列聚合 | `[taxonomies] series = "series"` |
| 站内搜索 | `[outputs] home = ["HTML", "RSS", "JSON"]` |

## 本地预览与发布

```bash
hugo server -D
```

推送到 GitHub 后，Actions 会自动构建并发布到 Pages。新增文章时复制 `archetypes/default.md` 的模板即可。

## 下一步

- 把 `baseURL` 换成自己的域名
- 在仓库设置里把 Pages 的 Source 选为 GitHub Actions
- 给 utterances 安装 GitHub App，评论区即可用
