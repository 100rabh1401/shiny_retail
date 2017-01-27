ui <- dashboardPage(
        dashboardHeader(title = "RetaileR"),
        dashboardSidebar(
                sidebarMenu(
                        menuItem("Trends", tabName = "trends", icon = icon("line-chart")),
                        menuItem("Customers", tabName = "customers", icon = icon("users")),
                        menuItem("Products", tabName = "products", icon = icon("gift")),
                        menuItem("Stores", tabName = "stores", icon = icon("building")),
                        menuItem("Data", tabName = "data", icon = icon("table"))
                )
        ),
        
        dashboardBody(
                tabItems(
                        # First tab content
                        tabItem(tabName = "trends",
                                fluidRow(
                                        box(plotOutput("plot1", height = 250)),
                                        
                                        box(
                                                title = "Controls",
                                                sliderInput("slider", "Number of observations:", 1, 100, 50)
                                        )
                                )
                        ),
                        tabItem(tabName = "data",
                                h2("Transaction data"),
                                dataTableOutput("raw.data.table")
                                )
                )
        )
        
)
