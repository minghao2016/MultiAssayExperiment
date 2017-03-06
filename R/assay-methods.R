#' @describeIn ExperimentList Get the assay data for the default ANY class
setMethod("assay", c("ANY", "missing"), function(x, i, ...) {
    if (is(x, "ExpressionSet"))
        return(Biobase::exprs(x))
    return(x)
})

#' @describeIn ExperimentList Get the assay data from each element in the
#' \link{ExperimentList}
#' @param i assay: unused argument
#' @aliases assay,ExperimentList,missing-method
setMethod("assay", c("ExperimentList", "missing"), function(x, i, ...) {
    lapply(x, FUN = function(y) assay(y, ...))
})

#' @describeIn MultiAssayExperiment Get the assay data for a
#' \link{MultiAssayExperiment} as a \code{list}
#' @aliases assay,MultiAssayExperiment,missing-method
setMethod("assay", c("MultiAssayExperiment", "missing"), function(x, i, ...) {
    assay(experiments(x), ...)
})
