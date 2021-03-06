NULL


#' Siegel-Tukey Test For Equality In Variability.
#' 
#' Non-parametric Siegel-Tukey test for equality in variability. The null 
#' hypothesis is that the variability of x is equal between two groups. A 
#' rejection of the null hypothesis indicates that variability differs 
#' between the two groups. SiegelTukeyRank returns the ranks,
#' calculated after Siegel Tukey logic.
#' @param x: FLVector of data values
#' @param y: FLVector of data values
#'
#' @return A list with class "htest".
#' @seealso \code{\link[DescTools]{SiegelTukeyTest}} for R reference implementation.
#' @examples
#' x <- as.FLVector(rnorm(50))
#' y <- as.FLVector(rnorm(30))
#' SiegelTukeyTest(x, y)
#' @export
setGeneric("SiegelTukeyTest",function(x,y,alternative="two.sided",conf.level=0.95,...)
                standardGeneric("SiegelTukeyTest"))
setMethod("SiegelTukeyTest",signature(x="ANY"),
	function(x,y,...){
		return(DescTools::SiegelTukeyTest(x,y,...))
		})
setMethod("SiegelTukeyTest",signature(c(x="FLVector")),
    function(x,
             y,
            alternative="two.sided",
            conf.level=0.95,...){
    	if(is.null(x)||is.null(y)) stop("Cannot proceed for empty vectors")
      if(!alternative=="two.sided") stop("Only two sided alternative is supported")
    	vunionSelect <- constructUnionSQL(pFrom=c(a=constructSelect(x),b=constructSelect(y)),
                                              pSelect=list(a=c(groupID=1,num_val="a.vectorValueColumn",datasetid=1),
                                                           b=c(groupID=2,num_val="b.vectorValueColumn",datasetid=1)))
    	pview<-genRandVarName()
    	viewname<-createView(pview,vunionSelect)
    	pFuncName<-"FLSTTest"
    	vres<-	  sqlStoredProc(connection,
								              pFuncName,
						                  InputTable=viewname,
								              ValueColName="num_val",
              								GroupColName="groupID",
							               	WhereClause=NULL,
              								GroupBy="datasetid",
			               					TableOutput=1,
						              		outputParameter=c(OutTable="resTable"))
    	query<-paste0("Select * from ",vres[1,1])
    	res<-sqlQuery(connection,query)
      dropView(viewname)
      vcall<-paste(all.vars(sys.call())[1:2],collapse=" and ")
      vresList<-list(statistic=c("ST"=res[1,2]),
                     p.value=c("p-value"=res[1,3]),
                     data.name=vcall,
                     alternative="true ratio of scales is not equal to 1",
                     method="Siegel-Tukey-test for equal variability")
      class(vresList)<-"htest"
     	return(vresList)
   	}
)
