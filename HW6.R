#understanding albers projection for axis titles
# http://www.biogeog.ucsb.edu/projects/gap/metadata/shade-meta.html

# http://resources.esri.com/help/9.3/arcgisengine/dotnet/89b720a5-7339-44b0-8b58-0f5bf2843393.htm

#Landsat units:
# https://landsat.usgs.gov/how-radiance-calculated


# run this first to connect to shinyapps.io account
library(rsconnect)
rsconnect::setAccountInfo(name='mwright',
                          token='FE72305423A4AAC8C3B189029D5E6F73',
                          secret='iogeSSoDkvNOu8TgzmIQ0+LaoeceaCEH+Sd+eYpi')

#then run this after done shiny app:
rsconnect::deployApp("C:/Users/melai/Documents/BrenSpring2017/ESM262/HW6/ShinyAppHW6")















#########################################################
#draft apps (ignore)

library(shiny)
library(rgdal)
library(raster)
library(leaflet)
Landsat7 <- stack("Landsat7.tif")
bw <- gray.colors(256)


ui <- fluidPage(
  headerPanel('Santa Barbara County Landsat Data'),
  sidebarPanel(
    selectInput('col', 'Landsat Layer', names(Landsat7))),
  mainPanel(
    leafletOutput('plot1')
  )
)

#leafletProxy("plot1")

server <- function(input, output, session) {
  
  output$plot1 <- renderLeaflet({
    leaflet() %>% 
      addTiles() %>%
      addRasterImage(input$col, colors = bw, opacity = 0.8) %>%
      addLegend(pal = bw, values = values(input$col),
                title = "Spectral Radiance")
  })
  
}

shinyApp(ui = ui, server = server)







#############################################################################

library(raster)


Landsat7 <- stack("Landsat7.tif")
# Landsat7 <- raster(Landsat7)
r <- raster("nc/oisst-sst.nc")
pal <- colorNumeric(c("#0C2C84", "#41B6C4", "#FFFFCC"), values(r),
                    na.color = "transparent")

leaflet() %>% addTiles() %>%
  addRasterImage(r, colors = pal, opacity = 0.8) %>%
  addLegend(pal = pal, values = values(r),
            title = "Surface temp")


library(leaflet)

m <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addMarkers(lng=174.768, lat=-36.852, popup="The birthplace of R")
m  # Print the map


bw <- gray.colors(246)


#shortest viable app:
library(shiny)
library(rgdal)
library(raster)
ui <- fluidPage(
  headerPanel('Santa Barbara County Landsat Data'),
  sidebarPanel(
    selectInput('col', 'Landsat Layer', names(landsat))),
  mainPanel(
    plotOutput('plot1')
  )
)


server <- function(input, output) {
  
  selectedData <- reactive({
    landsat[, c(input$col, input$col, input$col)]
  })
  
  output$plot1 <- renderPlot({
    plotRGB(selectedData())
  })
  
}

shinyApp(ui = ui, server = server)

plotRGB(landsat)
plotRGB(landsat, r=3, g=2, b=1)



bw <- gray.colors(246)
plot(RGB_band1_HARV, col=bw)




###############################
#working on a LiDAR image

landsat <- stack("Landsat7.tif")
#type landssat into console, have 5 layers
plot(landsat[[2]], col=bw)

plotRGB(landsat)
plotRGB(landsat, r=3, g=2, b=1) #make it prettier so the ocean is actually blue


#take out blue , red and infrared
#red assigned to infrared and blue is assigned to green
plotRGB(landsat, r=4, g=3, b=2) #vegetation is red, water is blue, dirt is green/gray

#NDVI = plants reflect green and a whole lot of infrared which we can't see; idetfies vegetation and the brighter the infrared, the healthier they are

#can pull out the individual bands
red <- landsat[[3]]
NIR <- landsat[[4]]
plot(red, col=bw)
plot(NIR, col=bw) #vegetation is reflecting more infrared light than red light

NDVI <- (NIR - red)/(NIR+red)
plot(NDVI, col=bw)
plot(NDVI) #default color scheme is appropriate for NDVI (values > 0 are green and less than zero are red); green means is vegetation



#################################################################
"Landsat Shiny App"

library(shiny)
Landsat7 <- stack("Landsat7.tif")
ui <- fluidPage(
  headerPanel('Santa Barbara County Landsat Data'),
  sidebarPanel(
    selectInput('col', 'Landsat Layer', names(Landsat7), multiple=TRUE)),
  mainPanel(
    plotOutput('plot1')
  )
)

library(rgdal)
library(raster)
server <- function(input, output) {
  
  selectedData <- reactive({
    landsat[,input$col]
  })
  
  output$plot1 <- renderPlot({
    plotRGB(selectedData())
  })
  
}

shinyApp(ui = ui, server = server)



############################################################


"Landsat Shiny App"

library(shiny)
library(rgdal)
library(raster)
Landsat7 <- stack("Landsat7.tif")
ui <- fluidPage(
  headerPanel('Santa Barbara County Landsat Data'),
  sidebarPanel(
    selectInput('col', 'Landsat Layer', names(Landsat7))),
  mainPanel(
    plotOutput('plot1')
  )
)

server <- function(input, output) {
  output$plot1 <- renderPlot({
    plot(input$col, col=gray.colors(246))
  })
  
}


###########################################################


