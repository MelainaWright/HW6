"Landsat Shiny App"

library(shiny)
library(rgdal)
library(raster)

Landsat7 <- stack("Landsat7.tif")
bw <- gray.colors(246)

ui <- fluidPage(
  headerPanel('Santa Barbara County Landsat Data'),
  
  sidebarPanel(selectInput('col', 'Landsat Layer', names(Landsat7))),
  
  mainPanel(plotOutput('plot1'))
)

server <- function(input, output) {
  output$plot1 <- renderPlot({
    plot(Landsat7, input$col, col = bw, main="Santa Barbara County Spectral Radiance (watts/(m^2 * sr * um))", xlab="Albers False Easting Coordinate (m)", ylab = "Albers False Northing Coordinate (m)")
  })
}

shinyApp(ui = ui, server = server)
