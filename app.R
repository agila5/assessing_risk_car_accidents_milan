# packages
library(conflicted)
library(dplyr)
library(sf)
library(shiny)
library(leaflet)
library(leafgl)
library(colourvalues)
library(tidyr)
conflict_prefer("filter", "dplyr")


# load data
geo_milan <- read_sf("geo_milan.gpkg") %>% st_boundary() %>% st_transform(crs = 4326)
pred2018 <- read_sf("pred2018.gpkg") %>% 
  gather("index", "value", pred_mod1b_response_2018, pred_mod1b_zero_2018) %>% 
  st_transform(crs = 4326)

# highway choices
highway_type_choices <- c(
  "Primary highway" = "Strada Statale o Strada Regionale",
  "Secondary highway" = "Strada Provinciale",
  "Tertiary highway" = "Strada Comunale",
  "Residential highway" = "Strada Residenziale",
  "Unclassified highway" = "Altro"
)

indexes_choices <- c(
  "Road Risk Index" = "pred_mod1b_response_2018",
  "Road Safety Index" = "pred_mod1b_zero_2018"
)

# tiles choices
tiles_choices <- c(
  "Toner Lite" = "Stamen.TonerLite",
  "OpenStreetMap" = "OpenStreetMap"
)

ui <- navbarPage(
  title = "Road Indexes", 
  tabPanel(
    title = "Interactive Map", 
    div(
      class = "outer", 
      
      tags$head(
        includeCSS("styles.css"), 
        includeScript("geomap.js")
      ), 
      
      leafglOutput("map", width = "100%", height = "100%"), 
      
      # Controls panel
      absolutePanel(
        id = "controls", 
        class = "panel panel-default",
        fixed = TRUE,
        draggable = TRUE,
        top = 60,
        left = "auto",
        right = 20,
        bottom = "auto",
        width = 330,
        height = "auto",
        
        h2(tags$b("Controls")), 

        selectInput("index", tags$b("Choose the index"), indexes_choices), 
        uiOutput("index_slider", inline = TRUE), 
        checkboxGroupInput("highway_type", tags$b("Choose the type of highways to display"), highway_type_choices), 
        # radioButtons("tiles", tags$b("Choose background provider"), tiles_choices), 
        p(
          "You can view the code and the data behind this app at the following", 
          a("link", href = "https://github.com/agila5/assessing_risk_car_accidents_milan")
        ),
        
        actionButton("update_map", tags$b("Update Map!"), 
                     style= "margin-left: 80px; font-size:150%")
      )
    )
  )
)

server <- function(input, output, session) {
  output$index_slider <- renderUI({
    if (input$index == "pred_mod1b_response_2018") {
      sliderInput("risk_threshold", tags$b("Choose the risk index threshold"), 
                  min = 0, max = 5, value = 1, step = 0.1)
    } else {
      sliderInput("safety_threshold", tags$b("Choose the safety index threshold"), 
                  min = 0, max = 1, value = 0.9, step = 0.01)
    }
  })
  
  output$map <- renderLeaflet({
    # Create the background for the map. Default provider is Stamen.TonerLite
    leaflet(
      data = geo_milan,
      options = leafletOptions(preferCanvas = TRUE)
    ) %>%
      addProviderTiles(
        provider = "Stamen.TonerLite",
        options = providerTileOptions(
          updateWhenZooming = FALSE,
          updateWhenIdle = FALSE
        )
      ) %>% 
      addPolylines(color = "black", opacity = 1)
  })
  
  
  observe({
    # Take a dependency on input$update_map and input$highway_type 
    input$update_map
    highway_type <- input$highway_type
    
    selected_index <- isolate(input$index)
    risk_threshold <- isolate(input$risk_threshold)
    safety_threshold <- isolate(input$safety_threshold)
    
    filtered_data <- pred2018 %>%
      filter(
        index == selected_index, 
        highway %in% highway_type
      )
    leafletProxy("map", data = geo_milan) %>%
      clearGroup(group = "highways") %>%
      clearControls() %>%
      addPolylines(color = "black", opacity = 1)
  
  if (nrow(filtered_data) > 0L) {
    if(selected_index == "pred_mod1b_zero_2018") {
      validate(need(safety_threshold, "Wait"))
      
      my_cols <- color_values_rgb(
        x = ifelse(filtered_data$value > safety_threshold, "safe", "risky"), 
        palette = "rdylgn",
        include_alpha = FALSE
      )
      
      leafletProxy("map", data = filtered_data) %>%
        addGlPolylines(data = filtered_data, color = my_cols / 255, group = "highways", opacity = 1) %>% 
        addLegend(
          position = "bottomleft",
          colors = c("#A50026", "#006837"), 
          title = "Safety Index Legend",
          labels = c(
            paste0("Riskier roads: ", HTML("&phiv;"), " <= ", safety_threshold), 
            paste0("Safer roads: ", HTML("&phiv;"), " > ", safety_threshold)
          )
        )
    }
    
    if(selected_index == "pred_mod1b_response_2018") {
      validate(need(risk_threshold, "Wait"))
      
      my_cols <- color_values_rgb(
        x = ifelse(filtered_data$value > risk_threshold, "risky", "safe"), 
        palette = "rdylgn",
        include_alpha = FALSE
      )
      
      leafletProxy("map", data = filtered_data) %>%
        addGlPolylines(data = filtered_data, color = my_cols / 255, group = "highways", opacity = 1) %>% 
        addLegend(
          position = "bottomleft",
          colors = c("#A50026", "#006837"),
          title = "Risk Index Legend",
          labels = c(
            paste0("Riskier roads: ", HTML("&theta;"), " > ", risk_threshold),
            paste0("Safer roads: ", HTML("&theta;"), " <= ", risk_threshold)
          )
        )
    }
  }
})
}


# Run the application
shinyApp(ui = ui, server = server)