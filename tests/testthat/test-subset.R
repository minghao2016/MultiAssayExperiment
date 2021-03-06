context("Subset tests")

example("MultiAssayExperiment")

colList <- colnames(myMultiAssayExperiment)
colList[[2L]] <- character(0L)

rowList <- rownames(myMultiAssayExperiment)
rowList[[3L]] <- character(0L)

rowSubsettor <- lapply(rownames(myMultiAssayExperiment)[1:2], function(a) {
  sample(a, 1)
})
subsettor2 <- rownames(myMultiAssayExperiment)

test_that("subsettor length is of the same as MultiAssayExperiment", {
  expect_false(length(rowSubsettor) == length(myMultiAssayExperiment))
  expect_error(myMultiAssayExperiment[rowSubsettor, ])
  expect_equal(myMultiAssayExperiment[subsettor2, ], myMultiAssayExperiment)
})

test_that("drop argument works", {
  expect_equal(length(myMultiAssayExperiment[, colList, drop = TRUE]), 3L)
  expect_equal(length(myMultiAssayExperiment[, colList, drop = FALSE]), 4L)
  expect_equal(length(myMultiAssayExperiment[rowList, drop = TRUE]), 3L)
  expect_equal(length(myMultiAssayExperiment[rowList, drop = FALSE]), 4L)
  expect_equal(length(myMultiAssayExperiment[FALSE, drop = TRUE]), 0L)
  expect_equal(length(myMultiAssayExperiment[FALSE, drop = FALSE]), 4L)
  expect_equal(length(myMultiAssayExperiment[, FALSE, drop = TRUE]), 0L)
  expect_equal(length(myMultiAssayExperiment[, FALSE, drop = FALSE]), 4L)
})

test_that("subsetByColumns works with lists", {
    affySub <- list(Affy = 1:2)
    affySimple <- List(affySub)
    expect_equal(length(myMultiAssayExperiment[, affySub, ]), length(affySub))
    expect_equal(length(myMultiAssayExperiment[, affySimple, ]),
                 length(affySimple))
})

test_that("subsetBypData works as intended", {
    trues <- sum(myMultiAssayExperiment$sex == "M")
    expect_equal(nrow(pData(subsetBypData(myMultiAssayExperiment,
                                          myMultiAssayExperiment$sex == "M"))),
                 trues)
    expect_equal(nrow(pData(
        myMultiAssayExperiment[, myMultiAssayExperiment$sex == "M"])), trues)
})

test_that("MultiAssayExperiment subsetting works with NULL rownames", {
    nrows <- 200; ncols <- 6
    counts <- matrix(runif(nrows * ncols, 1, 1e4), nrows)
    rowRanges <- GRanges(rep(c("chr1", "chr2"), c(50, 150)),
                         IRanges(floor(runif(200, 1e5, 1e6)), width=100),
                         strand=sample(c("+", "-"), 200, TRUE),
                         feature_id=sprintf("ID%03d", 1:200))
    colData <- DataFrame(Treatment=rep(c("ChIP", "Input"), 3),
                         row.names=LETTERS[1:6])
    rse <- SummarizedExperiment(assays=SimpleList(counts=counts),
                                rowRanges=rowRanges, colData=colData)
    maeRSE <- MultiAssayExperiment(list(rag = rse))
    expect_true(is.character(rownames(maeRSE)[[1L]]))
    expect_true(length(rownames(maeRSE)[[1L]]) == 0L)
})
