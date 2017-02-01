raw.data<- read_rds("./data/transactions.rds")


## Table data
table.data <- raw.data %>%
        select(-id) %>%
        rename(
                Store = store_id,
                Client = client_id,
                Category = category,
                Price = price,
                Purchase_Date = datetime,
                Age = age,
                Sex = sex,
                Client_Location = location,
                Product = product_name
        )


## Value boxes - Trends

### Monthly Revenue growth
currentRevenue <- raw.data %>%
        filter(month(datetime) == max(month(datetime))) %>%
        select(price) %>%
        sum()

pastRevenue <- raw.data %>%
        filter(month(datetime) == min(month(datetime))) %>%
        select(price) %>%
        sum()

nMonths <- raw.data %>% 
        mutate(month = month(datetime)) %>%
        select(month) %>% 
        unique() %>%
        length()

currentUniqueUsers <- raw.data %>%
        select(client_id) %>% 
        unique() %>%
        length()

pastUniqueUsers <- raw.data %>%
        filter(month(datetime) == min(month(datetime))) %>%
        select(client_id) %>% 
        unique() %>%
        length()

currentMonthlySales <- raw.data %>%
        filter(month(datetime) == max(month(datetime))) %>%
        select(client_id, datetime) %>% 
        unique() %>%
        length()

pastMonthlySales <- raw.data %>%
        filter(month(datetime) == min(month(datetime))) %>%
        select(client_id, datetime) %>% 
        unique() %>%
        length()



monthlyRevenueGrowth <- calculate_period_growth(currentRevenue, pastRevenue, nMonths)
monthlyUsersGrowth <- calculate_period_growth(currentUniqueUsers, pastUniqueUsers, nMonths)
monthlySalesGrowth <- calculate_period_growth(currentMonthlySales, pastMonthlySales, nMonths)


## Plots - Trends

### Revenue Plot

trendplotRevenue.data <- raw.data %>%
        select(price, datetime) %>%
        mutate(month = month(datetime, label = TRUE)) %>%
        group_by(month) %>%
        summarise(revenue = sum(price)) %>%
        ungroup()

trendplotRevenue <- ggplot(trendplotRevenue.data) +
        aes(month, revenue, group = 1) +
        geom_line() +
        geom_smooth()


## Shiny Server
server <- function(input, output) {
        ### DataTable
        output$raw.data.table <- DT::renderDataTable(
                table.data,
                server = TRUE,
                options = list(
                        autoWidth = TRUE,
                        columnDefs = list(list(className = 'dt-center', targets = 0:9))
                )
        )
        
        ### Trends
        output$valueBoxMonthlyRevenueGrowth <- renderValueBox({
                valueBox(
                        value = monthlyRevenueGrowth,
                        subtitle = "Monthly Revenue Growth",
                        icon = icon("credit-card"),
                        color = "green"
                )
        })
        
        output$valueBoxMonthlyCustomersGrowth <- renderValueBox({
                valueBox(
                        value = monthlyUsersGrowth,
                        subtitle = "Monthly Unique Customers Growth",
                        icon = icon("users"),
                        color = "orange"
                )
        })
        
        output$valueBoxMonthlySalesGrowth <- renderValueBox({
                valueBox(
                        value = monthlySalesGrowth,
                        subtitle = "Monthly Number of Sales Growth",
                        icon = icon("shopping-basket"),
                        color = "red"
                )
        })
        
        
        output$trendplotRevenue <- renderPlot({
                trendplotRevenue
        })
}