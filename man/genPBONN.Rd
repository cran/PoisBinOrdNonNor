\name{genPBONN}
\alias{genPBONN}
\title{
Engine (generation) function for the PoisBinOrdNonNor package
}
\description{
This function generates a chosen number of Poisson, binary, ordinal, and continuous (via Fleishman
polynomials) random variables, with specified correlations and marginal properties.

The correlation matrix and the generated data follow the order of Poisson, binary, ordinal and continuous.
}
\usage{
genPBONN(n, cmat.star, no.pois = 0, no.bin = 0, no.ord = 0, 
    no.nonn = 0, pois.list = list(), bin.list = list(), 
    ord.list = list(), is.ord.list.cum = FALSE, nonn.list = list())
}
\arguments{
  \item{n}{
  The number of rows in the generated data matrix.
}
  \item{cmat.star}{
  The intermediate correlation matrix.
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
  A list of the lambda values, which must be greater than 0. Length will be equal to no.pois, or an error will be thrown. Defaults to an empty list.
}
  \item{bin.list}{
  A list of vectors containing the probabilities for each variable. Each vector should have 2 entries between 0 and 1 inclusive, and sum to 1. Length must be equal to no.bin. Defaults to an empty list.
}
  \item{ord.list}{
  A list of vectors containing the probabilities for each variable. Each vector should have entries between 0 and 1 inclusive, and sum to 1. Length must be equal to no.ord. Defaults to an empty list.
}
\item{is.ord.list.cum}{
  Flag for whether the ordinal list supplied contains cumulative probabilities. Defaults to FALSE.
}
  \item{nonn.list}{
  A list of vectors containing the first four moments of each variable, in order. If only two parameters are supplied, they will be assumed to be skew and excess kurtosis, with mean = 0 and variance = 1. If only three parameters are supplied, they will be assumed to be variance, skew and excess kurtosis, with mean = 0. If less than two parameters or more than four parameters are supplied for any variable, an error will be raised. Variance must be positive, and excess kurtosis must be greater than or equal to skew^2-2. Length must be equal to no.nonn. Defaults to an empty list.
}
}
\value{
A n by (no.pois+no.bin+no.ord+no.nonn) matrix. Each column corresponds to a variable, and each row is one random sample.
}
\details{
After transformation and checking of parameters, a n by (no.pois+no.bin+no.ord+no.nonn) matrix of standard normal random data is generated, using cmat.star as the correlation matrix.

Then for each variable, the appropriate transformation is applied to each column of the data generated.
}
\references{
Amatya, A. & Demirtas, H. (2015) Simultaneous generation of multivariate mixed
data with Poisson and normal marginals. \emph{Journal of Statistical Computation and Simulation} \bold{85:15}, 3129--3139.

Demirtas, H. (2014). Joint generation of binary and nonnormal continuous data.
\emph{Journal of Biometrics and Biostatistics} \bold{5:3:1000199}, 1--9.

Demirtas, H. & Hedeker, D. (2011) A practical way for computing approximate
lower and upper correlation bounds. \emph{American Statistician} \bold{65:2}, 104--109.

Demirtas, H. & Hedeker, D. (2016). Computing the point-biserial correlation under
any underlying continuous distribution. \emph{Communications in Statistics --
Simulation and Computation}, \bold{45:8}, 2744--2751. 

Demirtas, H., Hedeker, D. & Mermelstein, R. J. (2012) Simulation of massive public
health data by power polynomials. \emph{Statistics in Medicine} \bold{31:27}, 3337--3346.
}
\examples{
\dontrun{
cmat.star <- find.cor.mat.star(cor.mat = .8 * diag(8) + .2, no.pois = 2, no.ord = 4, 
    no.nonn = 2, pois.list = list(1, 2), ord.list = list(c(.2, .8), c(.5, .5),
    c(.1, .2, .3, .4), c(.8, 0, .1, .1)), nonn.list = list(c(-1, 1, 0, 1), c(0, 3, 0, 2)))
mydata <- genPBONN(1000, no.pois = 2, no.ord = 4, no.nonn = 2, 
    cmat.star = cmat.star, pois.list = list(1, 2), 
    ord.list = list(c(.2, .8), c(.5, .5),c(.1, .2, .3, .4),
    c(.8, 0, .1, .1)), nonn.list = list(c(-1, 1, 0, 1), c(0, 3, 0, 2)))

apply(mydata, 2, mean)
apply(mydata, 2, var)
library(moments)
apply(mydata, 2, skewness)
apply(mydata, 2, kurtosis) - 3
lapply(apply(mydata[, 1:6], 2, table), prop.table)
cor(mydata)
}
}