context("Class checks for constructor functions")

arraydat <- matrix(seq(101, 108), ncol=4,
                   dimnames = list(
                     c("ENST00000294241", "ENST00000355076"),
                     c("array1", "array2", "array3", "array4")
                   ))
arraypdat <- as(data.frame(
  slope53 = rnorm(4),
  row.names = c("array1", "array2", "array3", "array4")),
  "AnnotatedDataFrame")
exprdat <- Biobase::ExpressionSet(assayData=arraydat, phenoData=arraypdat)

ExpList <- list(exprdat)
names(ExpList) <- c("Affy")
myExperimentList <- ExperimentList(ExpList)

test_that("the appropriate class is returned", {
  expect_true(is(myExperimentList, "ExperimentList"))
})
