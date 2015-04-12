\name{check.params}
\alias{check.params}
\title{
Validates the adjusted marginal parameter lists
}
\description{
This function validates the lists of marginal parameters for the chosen number of Poisson, ordinal (and binary), and continuous (via Fleishman polynomials) random variables. The list for ordinal/binary variables must be cumulative.
}
\usage{
check.params(no.pois = 0, no.ordbin = 0, no.nonn = 0, pois.list = list(), 
    ordbin.list = list(), nonn.list = list())
}
\arguments{
  \item{no.pois}{
  The number of Poisson random variables desired. Defaults to 0.
}
  \item{no.ordbin}{
  The number of ordinal and binary random variables desired. Defaults to 0.
}
  \item{no.nonn}{
  The number of continuous random variables desired, created using Fleishman polynomials. Defaults to 0.
}
  \item{pois.list}{
  A list of the lambda values, which must be greater than 0. Length will be equal to no.pois, or an error will be thrown. Defaults to an empty list.
}
  \item{ordbin.list}{
  A list of vectors containing the cumulative probabilities for each variable. Each vector should have entries between 0 and 1 inclusive, in increasing order. Length must be equal to no.ordbin. Defaults to an empty list.
}
  \item{nonn.list}{
  A list of vectors containing the first four moments of each variable, in order. If only two parameters are supplied, they will be assumed to be skew and excess kurtosis, with mean=0 and variance=1. If only three parameters are supplied, they will be assumed to be variance, skew and excess kurtosis, with mean=0. If less than two parameters or more than four parameters are supplied for any variable, an error will be raised. Variance must be positive, and excess kurtosis must be greater than or equal to skew^2 - 2. Length must be equal to no.nonn. Defaults to an empty list.
}
}
\value{
  TRUE if all items meet necessary criteria. If not, program will have stopped with a specific error message.
}
\details{
Each list of transformed parameters is sent to the appropriate helper function. Requirements for each are mentioned in the description above.
}
\examples{
\dontrun{
#This pois.list will produce an error since the first entry is 0.
check.params(no.pois = 2, pois.list = list(0, 1))

#This ordbin.list will produce an error since it is not cumulative.
check.params(no.ordbin = 2, ordbin.list = list(.25, c(.25, 0, .75)))

#This ordbin.list will produce an error since the last entry is > 1.
check.params(no.ordbin = 2, ordbin.list = list(.25, c(.25, .5, 1.25)))

#This ordbin.list will produce an error since the first entry < 0.
check.params(no.ordbin = 2, ordbin.list = list(.25, c(-.25, .5, .75)))

#This nonn.list will produce an error since 0 < 2^2 - 2
check.params(no.nonn = 2, nonn.list = list(c(2,0), c(.5, 1, 2, 0)))

#This nonn.list will produce an error since the variance = 0.
check.params(no.nonn = 2, nonn.list = list(c(0,0), c(.5, 0, 0, 0)))
}

check.params(no.pois = 1, pois.list = list(1), no.ordbin = 2, 
    ordbin.list = list(.25, c(.25, .25, .75)), no.nonn = 1, 
    nonn.list = list(c(0, 1, 0, 3)))
}