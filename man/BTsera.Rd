% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{BTsera}
\alias{BTsera}
\title{BTsera}
\format{
A data frame with 224 rows and 29 variables:
\describe{
\item{pid}{Study identifier}
\item{dayxx_yyy_IgM}{Variable describes presence or absence (pos = detected, neg = not detected, NA = no valid result) of IgM for day xx samples for pathogen yyy where xx is (0 = day 0, 28 = day 28) and yyy is (den = Dengue, chick = Chikungunya, lepto = Leptospirosis, SF = Spotted fever group Rickettsioses, ET = Epidemic Typhus group Ricketssioses)}
\item{dayxx_yyy_IgG}{Variable describes presence or absence (pos = detected, neg = not detected, no valid result) of IgM for day xx samples for pathogen yyy where xx is (0 = day 0, 28 = day 28) and yyy is (den = Dengue, chick = Chikungunya, lepto = Leptospirosis, SF = Spotted fever group Rickettsioses, ET = Epidemic Typhus group Ricketssioses)}
\item{suffix_OD}{Numeric value of optical denisty of ELISA measurement}
\item{suffix_dilution}{Dilution of EIA measurement }

}

Serum was missing for one participant wjo is excluded from these data
}
\usage{
BTsera
}
\description{
Serology results for 225 adults with sepsis in Blantyre, Malawi
}
\keyword{datasets}
