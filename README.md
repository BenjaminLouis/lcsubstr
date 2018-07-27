
<!-- README.md is generated from README.Rmd. Please edit that file -->
lcsubstr
========

The goal of lcsubstr is to provide a function that find the longest common substring between elements of a charcater vector

Installation
------------

You can install the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("BenjaminLouis/lcsubstr")
```

Example
-------

``` r
library(lcsubstr)

# Considering these three strings
st1 <- "Here is a first string for the example, how original !"
st2 <- "Here a second string for the example too."
st3 <- "Here is a third  string for the example, as original as the others."

# you find the lingest common substring by running :
res <- find_lcsubstr(string = c(st1, st2, st3))
#> 
#> Longest Common SubString(s) :
#>    string for the example
```
