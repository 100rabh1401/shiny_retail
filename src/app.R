## app.R ##
library(shiny)
library(shinydashboard)
library(dplyr)
library(readr)
library(DT)

source("./ui/ui.R")
source("./server/server.R")

shinyApp(ui, server)