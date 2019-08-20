## The app

We created a shiny-app to let the readers explore in a more interactive view the results of our paper. You can access it at the following [link](https://agila.shinyapps.io/assessing_risk_car_accidents_milan_rsconnect/) (Warning: Clicking on the link does not open a new window in the browser, you should use right click of the mouse).

If you want to execute this app locally on your computer you just need to download the content of this github repository, open the `assessing_risk_car_accidents_milan.Rproj` project and run the app coded in the `app.R` file.

You may need to install one or more new R packages but they are all listed at the beginning of the `app.R` file. We used a new R package named `leafgl` for fast webgl rendering of the highways on leaflet maps. It's not on CRAN yet but you can install it as follows (you need the `devtools` package which is on CRAN):

``` r
devtools::install_github("r-spatial/leafgl")
```

You can find more details [here](https://github.com/r-spatial/leafgl) and you can download all the other packages used for this shiny-app from CRAN. 

## A short summary of the app

When you open the shiny-app you will see an empty map of Milan along with a transparent panel positioned on the right named **Controls**. You can use that panel to modify the map choosing which index you want to explore (one of Road Safety Index, the default, and Road Risk Index), its threshold and which types of highways you want to display on the map. 

If you choose one or more type of highways and click the **Update Map!** button, then the corresponding streets will be rendered on the map as green or red: green if the corresponding estimate of the Road Safety Index (or Road Risk index) is bigger (smaller) than the choosen threshold, red otherwise. A useful legend will appear in the bottomleft part of the screen. 

You can modify the thresholds using the slidebars appearing just under the box used to choose which index to explore. The Road Safety Index threshold ranges from 0 to 1 (since its a probability) while we decided to cut the total range of the Road Risk Index threshold from 0 to the 5, which represents the 99.5 percentile of the estimated Roadk Risk Index values. 

It should be noted that the map is updated only if the user clicks the **Update Map!** button. This is necessary otherwise the map would have been reloaded everytime the user modifies a threshold value. 
_____

We created this app following the examples reported [here](https://github.com/rstudio/shiny-examples/tree/master/063-superzip-example) and we are extremely grateful to their authors. 

____

### sessionInfo()

``` 
R version 3.6.1 (2019-07-05)
Platform: x86_64-w64-mingw32/x64 (64-bit)
Running under: Windows 10 x64 (build 17134)

Matrix products: default

locale:
LC_COLLATE=Italian_Italy.1252  LC_CTYPE=Italian_Italy.1252    LC_MONETARY=Italian_Italy.1252
LC_NUMERIC=C                   LC_TIME=Italian_Italy.1252    

attached base packages:
stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
tidyr_0.8.3        colourvalues_0.2.2 leafgl_0.1.1       leaflet_2.0.2      shiny_1.3.2       
sf_0.7-7           dplyr_0.8.3        conflicted_1.0.4  

loaded via a namespace (and not attached):
Rcpp_1.0.2         pillar_1.4.2       compiler_3.6.1     later_0.8.0        class_7.3-15      
tools_3.6.1        digest_0.6.20      packrat_0.5.0      memoise_1.1.0      tibble_2.1.3      
pkgconfig_2.0.2    rlang_0.4.0        DBI_1.0.0          rstudioapi_0.10    crosstalk_1.0.0   
e1071_1.7-2        htmlwidgets_1.3    classInt_0.3-3     grid_3.6.1         tidyselect_0.2.5  
glue_1.3.1         R6_2.4.0           purrr_0.3.2        magrittr_1.5       promises_1.0.1    
htmltools_0.3.6    units_0.6-3        assertthat_0.2.1   mime_0.7           xtable_1.8-4      
httpuv_1.5.1       KernSmooth_2.23-15 crayon_1.3.4 
```

