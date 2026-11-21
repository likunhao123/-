test_that("RemoveSeasonal removes seasonal cycle", {
  y <- c(1, 2, 3, 4)
  t <- c(101, 101, 102, 102) # 两个"月日"，各两个观测
  r <- RemoveSeasonal(y, t)
  expect_equal(r$mu, c(1.5, 3.5))
  expect_equal(r$anomaly, c(-0.5, 0.5, -0.5, 0.5))
})

test_that("LS_OneBreak fits same slope and different intercepts", {
  X <- 1:10
  Y <- c(1 + 2 * X[1:5], 5 + 2 * X[6:10]) # 断点在第 5 位
  fit <- LS_OneBreak(Y, X, Ic = 5)
  expect_equal(unname(fit$coef), c(1, 2, 4))
  expect_equal(fit$SSE, 0)
})
