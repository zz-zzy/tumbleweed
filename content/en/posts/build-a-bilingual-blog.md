---
title: "Building a bilingual technical blog"
date: 2026-10-21T10:00:00+08:00
draft: false
slug: "build-a-bilingual-blog"
translationKey: "build-a-bilingual-blog"
summary: "A minimal Hugo + PaperMod setup with bilingual content, series, search, comments and automated deployment."
description: "How this site is built: Hugo Extended, PaperMod, per-language content directories, utterances comments and GitHub Actions."
tags: ["Hugo", "Blogging"]
categories: ["Engineering"]
series: ["Blog Setup"]
ShowToc: true
TocOpen: false
cover:
  image: "img/covers/default.svg"
  alt: "Tumbleweed"
  caption: ""
---

> **TL;DR** — Hugo Extended + PaperMod, Chinese at the root and English under `/en/`, comments on GitHub Issues, deploy on push.

## Stack

Static sites are cheap to run and easy to maintain. Hugo builds fast; PaperMod brings dark mode, table of contents, search, archives and sane SEO defaults.

## Layout

```text
content/zh-cn/   -> /
content/en/      -> /en/
```

## Configuration highlights

| Need | Where |
|---|---|
| Language switching | `[languages.*]` with `contentDir` |
| Series grouping | `[taxonomies] series = "series"` |
| Client-side search | `[outputs] home = ["HTML", "RSS", "JSON"]` |

## Local preview

```bash
hugo server -D
```

Pushing to `main` triggers the GitHub Actions workflow, which builds and publishes to GitHub Pages.
