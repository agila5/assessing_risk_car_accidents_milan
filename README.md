## The app

We created a shiny-app to let the readers explore in a more interactive view the results of our paper. You can access it at the following [link](https://agila.shinyapps.io/assessing_risk_car_accidents_milan_rsconnect/) (Warning: Clicking on the link does not open a new window in the browser, you should use right click of the mouse).

If you want to execute this app locally on your computer you just need to download the content of this github repository, open the `assessing_risk_car_accidents_milan.Rproj` project and run the app coded in the `app.R` file.

You may need to install one or more new R packages but they are all listed at the beginning of the `app.R` file. We used a new R package named `leafgl` for fast webgl rendering of the highways on leaflet maps. It's not on CRAN yet but you can install it as follows (you need the `devtools` package which is on CRAN):

``` r
devtools::install_github("r-spatial/leafgl")
```

You can find more details [here](https://github.com/r-spatial/leafgl) and you can download all the other packages from CRAN. 

## A short summary of the app

When you open the shiny-app you will see an empty map of Milan along with a transparent panel positioned on the right named **Controls**. You can use that panel to modify the map choosing which index you want to explore (one of Road Safety Index, the default, and Road Risk Index), its threshold and which types of highways you want to display on the map. 

If you choose one or more type of highways and click the **Update Map!** button, then the corresponding streets will be rendered on the map as green or red: green if the corresponding estimate of the Road Safety Index (or Road Risk index) is bigger (smaller) than the choosen threshold, red otherwise. A useful legend will appear in the bottomleft part of the screen. 

You can modify the thresholds using the slidebars appearing just under the box used to choose which index to explore. The Road Safety Index threshold ranges from 0 to 1 (since its a probability) while we decided to cut the total range of the Road Risk Index threshold from 0 to the 5, i.e. the 99.5 percentile of the estimated Roadk Risk Index values. 

It should be noted that the map is updated only if you click the **Update Map!** button. We choose to do this otherwise it would have been updated everytime a user would modify a threshold value. 
_____

We created this app following the examples reported [here](https://github.com/rstudio/shiny-examples/tree/master/063-superzip-example) and we are extremely grateful to their authors. 