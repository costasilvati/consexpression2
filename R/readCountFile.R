#' Read table count File and creates a matrix from the given content file.
#'
#' @param tableCountPath the name of the file which the data are to be read from. Each row of the table appears as one line of the file. If it does not contain an absolute path, the file name is relative to the current working directory, getwd(). This can be a compressed file (see file). Alternatively, file can be a readable text-mode connection (which will be opened for reading if necessary, and if so closed (and hence destroyed) at the end of the function call).
#' @param split the field separator character. Values on each line of the file are separated by this character. If sep = "" (the default for read.table) the separator is ‘\t’, newlines or carriage returns.
#'
#' @return content of file in matrix R format
#' @export
#'
#' @examples readCountFile("tablecount.csv", "\t")
readCountFile <- function(tableCountPath="tablecount.csv", split="\t"){
    tableCount <- read.csv(tableCountPath, sep=split, row.names=1, header=TRUE,
                           stringsAsFactors=FALSE)
    return(as.matrix(tableCount))
}
