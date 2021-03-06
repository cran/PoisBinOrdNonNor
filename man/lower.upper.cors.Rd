\name{lower.upper.cors}
\alias{lower.upper.cors}
\title{
Computes lower and upper correlation bounds
}
\description{
This function calculates the approximate upper and lower correlation bounds for all variable pairs.
}
\usage{
lower.upper.cors(no.pois = 0, no.bin = 0, no.ord = 0, no.nonn = 0,
    pois.list = list(), bin.list = list(), ord.list = list(), 
    is.ord.list.cum=FALSE, nonn.list = list())
}
\arguments{
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
  A list of the lambda values, which must be greater than 0. Length will be equal to no.pois, or an error will be thrown. Defaults to an empty list.
}
  \item{bin.list}{
  A list of vectors containing the probabilities for each variable. Each vector should have 2 entries between 0 and 1 inclusive, and sum to 1. Length must be equal to no.bin. Defaults to an empty list.
}
  \item{ord.list}{
  A list of vectors containing the probabilities for each variable. If is.ord.list.cum is TRUE, each vector should have entries between 0 and 1, in increasing order. Otherwise, each vector should have entries between 0 and 1 inclusive that sum to 1. Length must be equal to no.ord. Defaults to an empty list.
}
  \item{is.ord.list.cum}{
  Flag for whether the ordinal list supplied contains cumulative probabilities. Defaults to FALSE.
}
  \item{nonn.list}{
  A list of vectors containing the first four moments of each variable, in order. If only two parameters are supplied, they will be assumed to be skew and excess kurtosis, with mean=0 and variance=1. If only three parameters are supplied, they will be assumed to be variance, skew and excess kurtosis, with mean=0. If less than two parameters or more than four parameters are supplied for any variable, an error will be raised. Variance must be positive, and excess kurtosis must be greater than or equal to skew^2-2. Length must be equal to no.nonn. Defaults to an empty list.
}
}
\note{
If (no.pois+no.bin+no.ord+no.nonn) is equal to 1, 1 is returned. (If less than 1, an error is thrown at the beginning of the function.)

The correlation matrix follows the order of Poisson, binary, ordinal, continuous.
}
\value{
  \item{min}{
    A (no.pois+no.bin+no.ord+no.nonn) by (no.pois+no.bin+no.ord+no.nonn) square matrix showing the calculated  lower correlation bound for each pair of variables.
  }
  \item{max}{
    A (no.pois+no.bin+no.ord+no.nonn) by (no.pois+no.bin+no.ord+no.nonn) square matrix showing the calculated upper correlation bound for each pair of variables.  
  }
}
\details{
First, the parameters are transformed as necessary and then checked for validity using \code{\link{check.params}}. Then, for each pair of variables, we generate approximate upper and lower correlation bounds, using Demirtas and Hedeker's method, which involves generating a large sample of data and sorting it to find approximate bounds.
}
\references{
Demirtas, H. & Hedeker, D. (2011) A practical way for computing approximate
lower and upper correlation bounds. \emph{American Statistician} \bold{65:2}, 104--109.
}
\examples{
lower.upper.cors(no.nonn = 2, nonn.list = list(c(0, 1, 0, 1), c(0, 1, 0, 2)))
lower.upper.cors(no.pois = 2, pois.list = list(.5, 1))
lower.upper.cors(no.ord = 3,  ord.list = list(c(.2, .8), c(.1, .2, .3, .4), 
    c(.8, 0, .1, .1)))
lower.upper.cors(no.pois = 1, no.nonn = 1, no.ord = 1, pois.list = list(.5), 
    ord.list = list(c(.8, 0, .1, .1)), nonn.list = list(c(0, 1, 0, 1)))
}
