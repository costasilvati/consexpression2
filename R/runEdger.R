#' Execute edgeR expression Analisys
#'
#' @param countMatrix either a matrix of raw (read) counts.
#' @param numberReplics number of replicate (technical or biologcal) integer
#' @param desingExperiment replicate and treatment by samples
#' @param edgerOutPath path to write edgeR report in csv file format
#'
#' @return edgeR report in data Frame
#' @export
#'
#' @examples
runEdger <- function (countMatrix, numberReplics, desingExperiment, edgerOutPath){
    group <- c(desingExperiment)
    y.dge <- edgeR::DGEList(counts = countMatrix, group = group)
    if (numberReplics < 1){
        print('Replicates not found by edgeR. EdgeR should be executed manual form.')
    }else if(numberReplics == 1){
        bcv <- 0.2
        y.et <- edgeR::exactTest(y.dge, dispersion = bcv^2)
        y.tp <- edgeR::topTags(y.et, n = 100000)
        utils::write.table(y.tp$table, edgerOutPath, sep = "\t", quote = FALSE)
    }else{
        y.dge <- edgeR::calcNormFactors(y.dge)
        y.dge <- edgeR::estimateDisp(y.dge)
        y.dge <- edgeR::estimateCommonDisp(y.dge)
        y.et <- edgeR::exactTest(y.dge)
        y.tp <- edgeR::topTags(y.et, n = 100000)
        y.pvalues <- y.et$table$PValue
        utils::write.table(y.tp$table, edgerOutPath, sep = "\t", quote = FALSE)
    }
    return(y.tp$table)
}
