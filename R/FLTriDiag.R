#' @include FLMatrix.R
NULL

#' TriDiagonal or Upper Hessenberg matrix of a FLMatrix.
#'
#' \code{FLTriDiag} computes the TriDiagonal or Upper Hessenberg matrix of FLMatrix object.
#'
#' @param object is of class FLMatrix
#' @param ... any additional arguments
#' @section Constraints:
#' Input can only be a square matrix (n x n) with maximum dimension limitations
#' of (700 x 700).
#' @return \code{FLTriDiag} returns a FLMatrix object representing the upper Hessenberg or TriDiagonal matrix.
#' @examples
#' flmatrix <- FLMatrix(getTestTableName("tblMatrixMulti"), 5,"MATRIX_ID",
#'                      "ROW_ID","COL_ID","CELL_VAL",dims= c(5,5))
#' resultFLMatrix <- FLTriDiag(flmatrix)
#' @export
FLTriDiag <- function (object, ...){
	UseMethod("FLTriDiag", object)
}

#' @export
FLTriDiag.FLMatrix<-function(object,...)
{

	# connection<-getFLConnection(object)
 #    ## flag1Check(connection)

	# sqlstr<-paste0(viewSelectMatrix(object,"a",withName="z"),
 #                   outputSelectMatrix("FLTridiagUdt",viewName="z",
 #                   	localName="a",includeMID=TRUE,vconnection=connection)
 #                   )
	
	# tblfunqueryobj <- new("FLTableFunctionQuery",
 #                        connectionName = attr(connection,"name"),
 #                        variables=list(
 #                            rowIdColumn="OutputRowNum",
 #                            colIdColumn="OutputColNum",
 #                            valueColumn="OutputVal"),
 #                        whereconditions="",
 #                        order = "",
 #                        SQLquery=sqlstr)

 #  	flm <- newFLMatrix(
 #            select= tblfunqueryobj,
 #            dims=dim(object),
 #            Dimnames=dimnames(object))

    flm <- constructMatrixUDTSQL(pObject=object,
                                 pFuncName="FLTridiagUdt",
                                 pdims=getDimsSlot(object),
                                 pdimnames=dimnames(object)
                                 )

  	return(ensureQuerySize(pResult=flm,
            pInput=list(object),
            pOperator="FLTriDiag",
            pStoreResult=TRUE))
}
