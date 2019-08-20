## The app

We created a shiny-app to let the readers explore in a more interactive view the results of our paper. You can access it at the following [link](https://agila.shinyapps.io/assessing_risk_car_accidents_milan_rsconnect/) (Warning: Clicking on the link does not open a new window in the browser, you should use right click of the mouse).

If you want to execute this app locally on your computer you just need to download the content of this github repository, open the `assessing_risk_car_accidents_milan.Rproj` project and run the app coded in the `app.R` file.

You may need to install one or more new R packages but they are all listed at the beginning of the `app.R` file. We used a new R package named `leafgl` for fast webgl rendering of the highways on leaflet maps. It's not on CRAN yet but you can install it as follows:

``` r
devtools::install_github("r-spatial/leafgl")
```

You can find more details [here](https://github.com/r-spatial/leafgl). You will find all the other packages on CRAN. 

## A short summary of the app

When you open the shiny-app you will see an empty map of Milan along with a transparent panel positioned on the right and named **Controls**. You can use that panel to modify the map choosing which index you want to explore (one of Road Safety Index, the default, and Road Risk Index), its threshold anf which types of highways<sup>1</sup> you want to display on the map. 

If you choose one or more type of highway and click the **Update Map!** button, then the corresponding streets will be rendered on the map as green or red: green if the corresponding estimate of the Road Safety Index (or Road Risk index) is bigger (smaller) than the choosen threshold, red otherwise. A useful legend will appear in the bottomleft part of the screen.

_____

<sup>1</sup>: You can read more details on the highway types we choose in the Section 3 of the associated paper. 
