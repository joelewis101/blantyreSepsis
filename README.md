
<!-- README.md is generated from README.Rmd. Please edit that file -->

# blantyreSepsis

<!-- badges: start -->

<!-- badges: end -->

The BlantyreSepsis R package contains contains data code to replicate
the analysis of the manuscript:

<br />

*Aetiology and determinants of outcome in sepsis in an urban African
centre: an observational cohort study*

<br />

Joseph M Lewis<sup>1,2,3</sup>, , Madlitso Mphasa<sup>1</sup>, Lucy
Keyala<sup>1</sup>, Rachel Banda^1, Emma Smith<sup>1</sup>,<sup>2</sup>,
Jackie Duggan<sup>4</sup>, Tim Brooks<sup>4</sup>, Matthew
Catton<sup>4</sup>, Jane Mallewa<sup>5</sup>, Grace Katha<sup>5</sup>,
Brian Faragher<sup>2</sup>, Melita Gordon<sup>1,3</sup>, Jamie
Rylance<sup>1,2</sup>, Nicholas A Feasey<sup>1,2</sup>

1.  Malawi Liverpool Wellcome Clinical Research Programme, Blantyre,
    Malawi
2.  Department of Clinical Sciences, Liverpool School of Tropical
    Medicine, Liverpool, UK
3.  Department of Clinical Infection, Microbiology and Immunology,
    University of Liverpool, Liverpool, UK
4.  Rare and Imported Pathogens Laboratory, Public Health England, UK
5.  Malawi College of Medicine, University of Malawi

## Installing and accessing data

Install the package from GitHub:

``` r
install.packages("devtools")
devtools::install_github("joelewis101/blantreSepsis")
```

Or check out the source code at
[GitHub](https://github.com/joelewis101/blantyreSepsis)

Six datasets are included in the package; for details and variable
definitions access the associated help file (e.g via `?BTparticipants`)

  - `BTparticipants` - Baseline characteristics and investigation
    results for included participants
  - `BTtreatments` - Antimicrobial therapy and intravenous fluid therapy
    received by included participants
  - `BTaetiology` - Results of malaria testing, aerobic blood culture,
    cerebrospinalfluid culture, tuberculosis diagnostic tests
  - `BTsera` - Results of serologic tests for arboviruses,
    Rickettsioses, Leptospirosis
  - `BTarraycard` - Results of multiplex PCR test for high consequence
    pathogens
  - `BTbc` - Results of aerobic blood culture

This analysis is available as a package vignette by typing
`vignette("analysis")` and the code is accessed either via the
associated .Rmd file or by typing `edit(vigentte("analysis"))`.

The [pkgdown](https://joelewis101.github.io/blantyreSepsis/) site for
this package has a rendered version of the analysis script as well as
variable definitions for the datasets.
