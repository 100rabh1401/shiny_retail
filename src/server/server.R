raw.data<- read_csv("./data/transactions.csv",n_max = 1000)



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


server <- function(input, output) {
        set.seed(122)
        histdata <- rnorm(500)
        
        output$plot1 <- renderPlot({
                data <- histdata[seq_len(input$slider)]
                hist(data)
        })
        
        
        output$raw.data.table = DT::renderDataTable(
                table.data,
                server = TRUE,
                options = list(
                        filter = 'top'
                )
        )
        
}