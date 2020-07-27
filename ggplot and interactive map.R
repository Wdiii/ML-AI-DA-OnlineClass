#Lab practice 1

library (datasets)
data(iris)
View(iris) 

unique(iris$Species)

#install.packages(c("GGally", "ggplot2"))

library(GGally)
ggpairs(iris, mapping=ggplot2::aes(colour = Species))

#Lab practice 2

#install.packages("shiny")
#install.packages("leaflet")

library(shiny)
library(leaflet)

r_colors <- rgb(t(col2rgb(colors()) / 255))

names(r_colors) <- colors()

ui <- fluidPage(
  leafletOutput("mymap"),
  p(),
  actionButton("recalc", "New points"),
  p(),
  textOutput("coordinates")
)

server <- function(input, output, session) {
  points <- eventReactive(input$recalc, {
    points = cbind(rnorm(40) * 2 + 13, rnorm(40) + 48)
    output$coordinates <- renderText({
      points
    })
    return(points)
  }, ignoreNULL = FALSE)
  observeEvent(input$Map_shape_click, { # update the location selectInput on map clicks
    output$coordinates <- renderText({
      "You have selected this"
    })
  })
  output$mymap <- renderLeaflet({
    leaflet() %>%
      addProviderTiles(providers$Stamen.TonerLite,
                       options = providerTileOptions(noWrap = TRUE)
      ) %>%
      addMarkers(data = points())
  })
}
shinyApp(ui, server)
