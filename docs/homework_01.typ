#set document(title: "编程基础作业")
#set text(font: ("Times New Roman", "SimSun"), size: 12pt)
#set heading(numbering: "1.")

#align(center)[
  #text(size: 16pt, weight: "bold")[第 1 章 编程基础 · 作业笔记]

  学号：046241  姓名：〔此处填姓名〕
]

= 操作步骤

本次作业完成了从 R 包模板创建到自动测试通过的完整流程：

+ *用模板创建仓库*：打开 https://github.com/rpkgs/rpkg.template ，点击
  `Use this template` → `Create a new repository`，生成自己的仓库。
+ *克隆到本地*：`git clone`，得到包含 `R/`、`tests/`、`DESCRIPTION`、
  `.github/workflows/` 的标准 R 包结构。
+ *添加函数*：将老师指定的 RHtests 包中的 `Component.R`
  （https://github.com/rpkgs/RHtests/blob/master/R/Component.R ）
  下载到 `R/` 目录。该文件包含 4 个函数：`RemoveSeasonal`（去季节循环）、
  `LS_OneBreak`（单断点分段回归）、`LS_MultiBreaks`（多断点分段回归）
  和内部工具函数 `lm_solve`。
+ *编写测试*：在 `tests/testthat/` 下新建 `test-Component.R`，
  用 testthat 框架对 `RemoveSeasonal` 和 `LS_OneBreak` 编写了测试用例。
  例如验证去季节后的均值和距平：

  ```r
  test_that("RemoveSeasonal removes seasonal cycle", {
    y <- c(1, 2, 3, 4)
    t <- c(101, 101, 102, 102)
    r <- RemoveSeasonal(y, t)
    expect_equal(r$mu, c(1.5, 3.5))
    expect_equal(r$anomaly, c(-0.5, 0.5, -0.5, 0.5))
  })
  ```
+ *推送并自动测试*：`git add .` → `git commit` → `git push`。
  推送约 2–3 分钟后，GitHub Actions 中的 R-CMD-check 工作流自动运行，
  在 Windows 和 Ubuntu 两个平台上完成包检查与单元测试，结果为绿勾（通过）。

= 遇到的问题

+ *`R/` 文件夹只能放函数*：一开始在 `R/` 里放的是 `X = 1` 这样的赋值语句，
  不符合规范。R 包的 `R/` 目录只应包含函数定义，脚本应放在 `scripts/`。
+ *NAMESPACE 与文档依赖 roxygen2*：`NAMESPACE` 和 `man/` 下的 Rd 文档
  由 roxygen2 自动生成，本机未安装 R 环境时无法重新生成。
  因此函数暂未 `@export`，但 testthat 测试在包内部环境运行，不受影响。
+ *仓库命名失误*：创建仓库时不小心把仓库名写成了 `-`，虽然不影响功能，
  但不规范。今后应注意命名，包名需是合法的 R 标识符。
+ *Typst 安装受阻*：winget 与 GitHub 直连下载均失败，
  最后改用 pip 安装 Python 版 typst（自带编译器）解决。
+ *codecov 上传失败*：test-coverage 工作流需要配置 `CODECOV_TOKEN`，
  缺失时 codecov-action 报错导致工作流失败。
  将 `fail_ci_if_error` 设为 `false` 后工作流恢复正常。
+ *pkgdown 部署失败*：新仓库 workflow 默认只有只读权限，
  无法推送 `gh-pages` 分支。在 `pkgdown.yaml` 顶部显式声明
  `permissions: contents: write` 后解决。

= 心得体会

+ 理解了 R 包的最小结构：`R/`（只放函数）+ `DESCRIPTION`（元数据），
  以及 `tests/`、`man/`、`NAMESPACE` 各自的作用。
+ GitHub Actions 实现了"推送即测试"，能在多平台自动验证代码，
  这是管理代码质量的有效手段。
+ 体会到老师说的"你可以不会写代码，但是你必须会管理代码"：
  函数与脚本分离、版本控制、自动测试，比单个脚本更可靠、更便于分享。
+ Typst 的章节自动编号、代码块和公式排版比 Word 高效，
  适合写技术笔记。

= 附：仓库地址

https://github.com/likunhao123/-
