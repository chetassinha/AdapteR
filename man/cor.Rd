% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/FLCorrel.R
\name{cor}
\alias{cor}
\title{Correlation.}
\usage{
cor(x, y = NULL, use = "everything", method = "pearson", ...)
}
\arguments{
\item{x}{FLMatrix, FLVector or FLTable object or any R object}

\item{y}{FLMatrix, FLVector or FLTable object or any R object}

\item{...}{any additional arguments}
}
\value{
\code{cor} returns FLMatrix object representing correlation of x and y.
}
\description{
\code{cor} computes correlation of in-database Objects
}
\section{Constraints}{

The number of non-null pairs must be greater than or equal to 2.
If number of non-null pairs is less than 2, FLCorrel returns a NULL.
Only methods c("pearson","spearman","shuffle") are supported.
}

\examples{
deeptable <- FLTable( 
"tblUSArrests", "ObsID","VarID","Num_Val")
widetable <- FLTable("tblAbaloneWide","ObsID")
cor(deeptable,deeptable)
cor(widetable,widetable)
}
