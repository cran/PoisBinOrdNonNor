\name{PoisBinOrdNonNor-package}
\alias{PoisBinOrdNonNor-package}
\alias{PoisBinOrdNonNor}
\docType{package}
\title{
Generation of up to Four Different Types of Variables
}
\description{
Simultaneous generation of a chosen number of count,
binary, ordinal, and continuous (via Fleishman polynomials) random variables, with specified correlations and marginal distributions. Throughout the package, the word 'Poisson' is used to imply count data under the assumption of Poisson distribution; and continuous variables can take any shape allowed by Fleishman polynomials. The correlation matrix and the generated data follow the order of Poisson, binary, ordinal and continuous.
}
\details{
\tabular{ll}{
Package: \tab PoisBinOrdNonNor\cr
Type: \tab Package\cr
Version: \tab 1.5.2\cr
Date: \tab 2020-04-20\cr
License: \tab GPL-2 | GPL-3\cr
}
This package consists of five public functions.  The function \code{\link{check.params}} validates the input parameters to avoid obvious specification errors of the marginal parameters. The function \cr \code{\link{validate.cor.mat}} validates an input target correlation matrix to make sure that it is a legitimate correlation matrix, and then calls \code{\link{lower.upper.cors}} with the rest of the input parameters to generate approximate maximum and minimum feasible bounds, and then checks that each entry is within its bounds. The function \code{\link{find.cor.mat.star}} creates the intermediate correlation matrix.  Finally, given the output from \code{\link{find.cor.mat.star}} along with the other variable specifications, the function \code{\link{genPBONN}} generates the simultaneous random data, following the target correlation matrix and the marginal input parameters.

}
\author{
Hakan Demirtas, Rachel Nordgren, Rawan Allozi, Ran Gao

Maintainer: Ran Gao <rgao8@uic.edu>
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

\note{
The approximation used to find the correlation for Poisson variables is not very accurate once lambda is less than 1, and becomes less accurate as lambda gets closer to 0.

A flag is used to specify if ordinal probabilities are cumulative--default is FALSE.

Binary variables can be listed separately or combined with ordinal variables--the results will be equivalent.  Any variables listed as ordinal are affected by the cumulative flag.
}