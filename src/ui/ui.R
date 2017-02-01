ui <- dashboardPage(skin = "purple",
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
                                                    valueBoxOutput("valueBoxMonthlyRevenueGrowth"),
                                                    valueBoxOutput("valueBoxMonthlyCustomersGrowth"),
                                                    valueBoxOutput("valueBoxMonthlySalesGrowth")
                                            ),
                                            fluidRow(
                                                    plotOutput("trendplotRevenue")
                                            )
                                    ),
                                    tabItem(tabName = "data",
                                            h2("Transaction data"),
                                            dataTableOutput("raw.data.table")
                                    )
                            )
                    )
                    
)
