
<!-- README.md is generated from README.Rmd. Please edit that file -->

# blantyreSepsis

<!-- badges: start -->
<!-- badges: end -->

The BlantyreSepsis R package contains data and code to replicate the
analysis of the manuscript:

<br />

*A longitudinal observational study of the aetiology and long-term
outcomes of sepsis in Malawi reveals a key role of HIV and disseminated
tuberculosis*

<br />

Joseph M Lewis<sup>1,2,3</sup>, , Madalitso Mphasa<sup>1</sup>, Lucy
Keyala<sup>1</sup>, Rachel Banda<sup>1</sup>, Emma
Smith<sup>1</sup>,<sup>2</sup>, Jackie Duggan<sup>4</sup>, Tim
Brooks<sup>4</sup>, Matthew Catton<sup>4</sup>, Jane
Mallewa<sup>5</sup>, Grace Katha<sup>5</sup>, Stephen B
Gordon<sup>1,2</sup>, Brian Faragher<sup>2</sup>, Melita A
Gordon<sup>1,3</sup>, Jamie Rylance<sup>1,2</sup>, Nicholas A
Feasey<sup>1,2</sup>

1.  Malawi Liverpool Wellcome Clinical Research Programme, Blantyre,
    Malawi
2.  Department of Clinical Sciences, Liverpool School of Tropical
    Medicine, Liverpool, UK
3.  Department of Clinical Infection, Microbiology and Immunology,
    University of Liverpool, Liverpool, UK
4.  Rare and Imported Pathogens Laboratory, Public Health England, UK
5.  College of Medicine, University of Malawi, Malawi

## Installing and accessing data

Install the package from GitHub:

``` r
install.packages("devtools")
devtools::install_github("https://github.com/joelewis101/blantyreSepsis")
```

Or check out the source code at
[GitHub](https://github.com/joelewis101/blantyreSepsis)

Six datasets are included in the package; for details and variable
definitions access the associated help file (e.g via `?BTparticipants`).
They are lazy loaded so will be available on loading the package.

-   `BTparticipants` - Baseline characteristics and investigation
    results for included participants
-   `BTtreatments` - Antimicrobial therapy and intravenous fluid therapy
    received by included participants
-   `BTaetiology` - Results of malaria testing, aerobic blood culture,
    cerebrospinalfluid culture, tuberculosis diagnostic tests
-   `BTsera` - Results of serologic tests for arboviruses,
    Rickettsioses, Leptospirosis
-   `BTarraycard` - Results of multiplex PCR test for high consequence
    pathogens
-   `BTbc` - Results of aerobic blood culture

This analysis is available as a package vignette; this can be built when
downloading the package by typing:

``` r
devtools::install_github("https://github.com/joelewis101/blantyreSepsis", build_vignettes = TRUE )
```

The vignette will be then be available by typing `vignette("analysis")`
and the code is accessed by typing `edit(vigentte("analysis"))`. Be
warned: building the vignette takes some time as it will run through the
full missing data imputation and model fitting!

Alternatively the source code for the vignette is `analysis.Rmd` in the
`vignettes/` folder of this repo or the
[pkgdown](https://joelewis101.github.io/blantyreSepsis/) site for this
package has a rendered version, as well as variable definitions for the
datasets.
