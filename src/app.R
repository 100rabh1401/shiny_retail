## app.R ##
library(shiny)
library(shinydashboard)
library(dplyr)
library(readr)
library(lubridate)
library(DT)
library(microbenchmark)
library(ggplot2)

source("./support.R")
source("./ui/ui.R")
source("./server/server.R")

shinyApp(ui, server)