## The app

We created a shiny-app to let the readers explore interactively the results of our paper. You can access it at this [link](https://agila.shinyapps.io/assessing_risk_car_accidents_milan_rsconnect/) (Warning: Clicking on the link does not open a new window in the browser, you should use right click of the mouse).

If you want to execute this app locally on your computer you need to download the content of this github repository, open the `assessing_risk_car_accidents_milan.Rproj` project and run the app coded in the `app.R` file.

You may need to install one or more R packages listed at the beginning of the `app.R` file. We used a new R package named `leafgl` for fast webgl rendering of the highways on leaflet maps. This package is not on CRAN yet and you can install it as follows (you need the `devtools` package which is on CRAN):

``` r
devtools::install_github("r-spatial/leafgl")
```

You can find more details [here](https://github.com/r-spatial/leafgl) and you can download all the other packages used for this shiny-app from CRAN. 

## A short summary of the app

When you open the shiny-app you will see an empty map of Milan along with a transparent panel positioned on the right named **Controls**. You can use that panel to modify the map choosing which index you want to explore (one of Road Safety Index, the default, and Road Risk Index), its threshold and which type of highways you want to display on the map. 

If you choose one or more type of highways and click the **Update Map!** button, then the corresponding streets will be rendered on the map as green or red: green if the corresponding estimate of the Road Safety Index (or Road Risk index) is bigger (smaller) than the chosen threshold, red otherwise. A legend will appear in the bottomleft part of the screen. 

You can modify the thresholds using the slidebars appearing just under the box used to choose the index to explore. The Road Safety Index threshold ranges from 0 to 1 (since it is a probability) while we decided to bound the total range of the Road Risk Index threshold from 0 to the 5, which represents the 99.5 percentile of the estimated Roadk Risk Index values. 

It should be noted that the map is updated only if the user clicks the **Update Map!** button. This is necessary otherwise the map would have been reloaded everytime the user modifies a threshold value. 
_____

We created this app following the examples reported [here](https://github.com/rstudio/shiny-examples/tree/master/063-superzip-example) and we are extremely grateful to the authors. 

____

### sessionInfo()

``` r
sessionInfo()
#> R version 3.6.2 (2019-12-12)
#> Platform: x86_64-w64-mingw32/x64 (64-bit)
#> Running under: Windows 10 x64 (build 18362)
#> 
#> Matrix products: default
#> 
#> locale:
#> [1] LC_COLLATE=Italian_Italy.1252  LC_CTYPE=Italian_Italy.1252   
#> [3] LC_MONETARY=Italian_Italy.1252 LC_NUMERIC=C                  
#> [5] LC_TIME=Italian_Italy.1252    
#> 
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base     
#> 
#> other attached packages:
#> [1] tidyr_1.0.2        colourvalues_0.3.2 leafgl_0.1.1       leaflet_2.0.3     
#> [5] shiny_1.4.0        sf_0.8-1           dplyr_0.8.4        conflicted_1.0.4  
#> 
#> loaded via a namespace (and not attached):
#>  [1] Rcpp_1.0.3         pillar_1.4.3       compiler_3.6.2     later_1.0.0       
#>  [5] highr_0.8          class_7.3-15       tools_3.6.2        digest_0.6.23     
#>  [9] lifecycle_0.1.0    evaluate_0.14      memoise_1.1.0      tibble_2.1.3      
#> [13] pkgconfig_2.0.3    rlang_0.4.4        DBI_1.1.0          crosstalk_1.0.0   
#> [17] yaml_2.2.1         xfun_0.12          fastmap_1.0.1      e1071_1.7-3       
#> [21] stringr_1.4.0      knitr_1.28         vctrs_0.2.2        htmlwidgets_1.5.1 
#> [25] classInt_0.4-2     grid_3.6.2         tidyselect_1.0.0   glue_1.3.1        
#> [29] R6_2.4.1           rmarkdown_2.1      purrr_0.3.3        magrittr_1.5      
#> [33] promises_1.1.0     htmltools_0.4.0    units_0.6-5        assertthat_0.2.1  
#> [37] mime_0.9           xtable_1.8-4       httpuv_1.5.2       KernSmooth_2.23-16
#> [41] stringi_1.4.5      crayon_1.3.4
```
