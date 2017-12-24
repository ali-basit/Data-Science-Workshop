
library(shinydashboard)
library(leaflet)

ui <- dashboardPage(
  dashboardHeader(title = "311 Requests"),
  dashboardSidebar(),
  dashboardBody(
    # Boxes need to be put in a row (or column)
    fluidRow(
      box(leafletOutput("mymap")),
      
      box(
        actionButton("recalc", "New points")
      )
    )
  )
)

server <- function(input, output) {
  points <- eventReactive(input$recalc, {
    cbind(rnorm(40) * 2 + 13, rnorm(40) + 48)
  }, ignoreNULL = FALSE)
  
  output$mymap <- renderLeaflet({
    leaflet() %>%
      addProviderTiles(providers$Stamen.TonerLite,
                       options = providerTileOptions(noWrap = TRUE)
      ) %>%
      addMarkers(data = points())
  })
}

shinyApp(ui, server)