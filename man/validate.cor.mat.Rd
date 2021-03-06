\name{validate.cor.mat}
\alias{validate.cor.mat}
\title{
Validates the target correlation matrix
}
\description{
This function validates the user-inputted target correlation matrix for the chosen number of Poisson,
binary, ordinal, and continuous (via Fleishman polynomials) random variables. The correlation matrix follows the order of Poisson, binary, ordinal, continuous.
}
\usage{
validate.cor.mat(cor.mat, no.pois = 0, no.bin = 0, no.ord = 0, 
    no.nonn = 0, pois.list = list(), bin.list = list(), 
    ord.list = list(), is.ord.list.cum=FALSE, nonn.list = list())
}
\arguments{
  \item{cor.mat}{
  The desired target correlation matrix.
}
  \item{no.pois}{
  The number of Poisson random variables desired. Defaults to 0.
}
  \item{no.bin}{
  The number of binary random variables desired. Defaults to 0.
}
  \item{no.ord}{
  The number of ordinal random variables desired. Defaults to 0.
}
  \item{no.nonn}{
  The number of continuous random variables desired, created using Fleishman polynomials. Defaults to 0.
}
  \item{pois.list}{
  A list of the lambda values, which must be greater than 0. 
  Length will be equal to no.pois, or an error will be thrown. 
  Defaults to an empty list.
}
  \item{bin.list}{
  A list of vectors containing the probabilities for each 
  variable. Each vector should have 2 entries between 0 and 1
  inclusive, and sum to 1. Length must be equal to no.bin. 
  Defaults to an empty list.
}
  \item{ord.list}{
  A list of vectors containing the probabilities for each 
  variable. If is.ord.list.cum is TRUE, each vector should have
  entries between 0 and 1, in increasing order. Otherwise, each 
  vector should have entries between 0 and 1 inclusive that sum 
  to 1. Length must be equal to no.ord. Defaults to an empty list.
}
  \item{is.ord.list.cum}{
  Flag for whether the ordinal list supplied contains 
  cumulative probabilities. Defaults to FALSE.
}
  \item{nonn.list}{
  A list of vectors containing the first four moments of each 
  variable, in order. If only two parameters are supplied, they 
  will be assumed to be skew and excess kurtosis, with mean = 0
  and variance = 1. If only three parameters are supplied, they
  will be assumed to be variance, skew and excess kurtosis, with
  mean = 0. If less than two parameters or more than four 
  parameters are supplied for any variable, an error will be 
  raised. Variance must be positive, and excess kurtosis must be
  greater than or equal to skew^2-2. Length must be equal to 
  no.nonn. Defaults to an empty list.
}
}
\value{
    TRUE if the correlation matrix is valid, and FALSE if not.
}
\details{
First, the matrix is checked for the correct dimensions, then for symmetry, and then for being positive definite. Then each entry is checked to be in [-1, 1] and the diagonal entries must be 1. If not, an error is thrown.

Second, the parameters are transformed and then checked for validity using \code{\link{check.params}}.

Third, the minimum and maximum correlation matrices are found using \code{\link{lower.upper.cors}}. If all entries are within the bounds, TRUE is returned. Otherwise, a list of which cells are invalid and their required bounds are printed, and FALSE is returned.
}
\examples{
validate.cor.mat(cor.mat = .2 * diag(3) + .8, no.pois = 3, 
    pois.list = list(.25, .5, 1))
validate.cor.mat(cor.mat = .7 * diag(3) + .3, no.ord = 3, 
    ord.list = list(c(.2, .8), c(.1, .2, .3, .4), c(.8, 0, .1, .1)))
validate.cor.mat(cor.mat = .25 * diag(3) + .75, no.pois = 1, 
    no.nonn = 1, no.ord = 1, pois.list = list(.5), 
    ord.list = list(c(.8, 0, .1, .1)), nonn.list=list(c(0, 1, 0, 1)))
validate.cor.mat(cor.mat = .35 * diag(3) + .65, no.pois = 1, 
    no.nonn = 1, no.ord = 1, pois.list = list(.5), 
    ord.list = list(c(.8, 0, .1, .1)), nonn.list=list(c(0, 1, 0, 1)))
}
