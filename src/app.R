## app.R ##
library(shiny)
library(shinydashboard)

source("./ui/ui.R")
source("./server/server.R")

shinyApp(ui, server)