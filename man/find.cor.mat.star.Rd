\name{find.cor.mat.star}
\alias{find.cor.mat.star}
\title{
Finds intermediate correlation matrix
}
\description{
This function calculates an intermediate correlation matrix for a chosen number of Poisson, binary,
ordinal, and continuous (via Fleishman polynomials) random variables, with specified target
correlations and marginal properties.


The correlation matrix follows the order of Poisson, binary, ordinal, continuous.
}
\usage{
find.cor.mat.star(cor.mat, no.pois = 0, no.bin = 0, no.ord = 0, 
    no.nonn = 0, pois.list = list(), bin.list = list(), ord.list = list(), 
    is.ord.list.cum = FALSE, nonn.list = list())
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
  A list of vectors containing the first four moments of each variable, in order. If only two parameters are supplied, they will be assumed to be skew and excess kurtosis, with mean = 0 and variance = 1. If only three parameters are supplied, they will be assumed to be variance, skew and excess kurtosis, with mean = 0. If less than two parameters or more than four parameters are supplied for any variable, an error will be raised. Variance must be positive, and excess kurtosis must be greater than or equal to skew^2-2. Length must be equal to no.nonn. Defaults to an empty list.
}
}
\value{
A (no.pois+no.bin+no.ord+no.nonn) by (no.pois+no.bin+no.ord+no.nonn) square matrix, containing the intermediate correlation values.
}
\details{
First, the target correlation matrix and input parameters are checked using \code{\link{validate.cor.mat}}.

Second, the input lists are transformed and combined.

Third, each entry is tranformed in order.
\itemize{
\item Poisson-Poisson entries follow Amatya and Demirtas (2016).
\item Ordinal/Binary-Ordinal/Binary entries are transformed using a call to \emph{ordcont} in \pkg{GenOrd} package.
\item Continuous-Continuous entries use the correlation matrix for the underlying Fleishman polynomials.
\item All mixed entries use the approximation from Demirtas and Hedeker 2016: corr(X, Z) = cor(X, Y) * 
cor(Y, Z) where Y is a standard normal variable. In other words, the association between X and Z is assumed to be fully explained by the association between X and Y and the association between Y and Z.
}

Fourth, the resulting matrix is checked for validity. If it is not a valid correlation matrix, a warning message is printed and the nearest valid matrix is returned instead. (\emph{nearPD} from \pkg{Matrix)}
}
\references{
Amatya, A. & Demirtas, H. (2016) Simultaneous generation of multivariate mixed
data with Poisson and normal marginals. Forthcoming in \emph{Journal of Statistical
Computation and Simulation}.

Demirtas, H. & Hedeker, D. (2011) A practical way for computing approximate
lower and upper correlation bounds. \emph{American Statistician} \bold{65:2}, 104--109.

Demirtas, H., Hedeker, D. & Mermelstein, R. J. (2012) Simulation of massive public
health data by power polynomials. \emph{Statistics in Medicine} \bold{31:27}, 3337--3346.

Demirtas, H. (2014). Joint generation of binary and nonnormal continuous data.
\emph{Journal of Biometrics and Biostatistics} \bold{5:3:1000199}, 1--9.

Demirtas, H. & Hedeker, D. (2016). Computing the point-biserial correlation under
any underlying continuous distribution. Forthcoming in \emph{Communications in Statistics--
Simulation and Computation}.
}
\examples{
validate.cor.mat(cor.mat = .3 * diag(3) + .7, no.pois = 3, 
    pois.list = list(.25, .5, 1))
find.cor.mat.star(cor.mat = .3 * diag(3) + .7, no.pois = 3, 
    pois.list = list(.25, .5, 1))

validate.cor.mat(cor.mat = .8 * diag(3) + .2, no.ord = 3, 
    ord.list = list(c(.2, .8), c(.1, .2, .3, .4), c(.8, 0, .1, .1)))
find.cor.mat.star(cor.mat = .8 * diag(3) + .2, no.ord = 3, 
    ord.list = list(c(.2, .8), c(.1, .2, .3, .4), c(.8, 0, .1, .1)))

validate.cor.mat(cor.mat = .5 * diag(3) + .5, no.pois = 1, no.nonn = 1,
    no.ord = 1, pois.list = list(.5), ord.list = list(c(.8, 0, .1, .1)),
    nonn.list = list(c(0, 1, 0, 1)))
find.cor.mat.star(cor.mat = .5 * diag(3) + .5, no.pois = 1, no.nonn = 1,
    no.ord = 1, pois.list = list(.5), ord.list = list(c(.8, 0, .1, .1)),
    nonn.list = list(c(0, 1, 0, 1)))
}
