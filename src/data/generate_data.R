library(readr)
library(dplyr)
# Script to generate our customer, 
# products, sales and stores datasets


## Customers
locations <- c("NYC", 
              "Los Angeles",
              "Chicago",
              "Houston",
              "Philadelfia",
              "Phoenix",
              "San Antonio",
              "San Diego",
              "Dallas",
              "San Jose",
              "Austin",
              "Jacksonville",
              "San Francisco",
              "Indianapolis",
              "Columbus",
              "Fort Worth",
              "Charlotte",
              "Detroit",
              "El Paso",
              "Seattle")

sex_options <- c("M",
         "F")

age_range <- seq(18,60,1)

customers <- data.frame(
        id = seq(1,1000,1),
        age = sample(age_range, 1000, replace = TRUE),
        sex = sample(sex_options, 1000, replace = TRUE),
        location = sample(locations, 1000, replace = TRUE),
        stringsAsFactors = FALSE
)



## Products

available_products <- data.frame(
        name = c("Brown rice",
                 "Whole-grain pasta",
                 "Tomato sauce",
                 "Mustard",
                 "Olive oil",
                 "Turkey breasts",
                 "Salmon",
                 "Canned tuna",
                 "Broccoli",
                 "Carrot",
                 "Spinach",
                 "Lettuce",
                 "Eggs",
                 "Swiss cheese",
                 "Skim milk",
                 "Whole milk",
                 "Banana",
                 "Apple",
                 "Orange",
                 "Mango",
                 "Sweet potato",
                 "Wine",
                 "Sparkling water",
                 "Soda",
                 "Beer"
        ),
        category = c("Pasta and Rice",
                     "Pasta and Rice",
                     "Oils and Sauces",
                     "Oils and Sauces",
                     "Oils and Sauces",
                     "Meat and Seafood",
                     "Meat and Seafood",
                     "Meat and Seafood",
                     "Vegetables",
                     "Vegetables",
                     "Vegetables",
                     "Vegetables",
                     "Dairy, Cheese, and Eggs",
                     "Dairy, Cheese, and Eggs",
                     "Dairy, Cheese, and Eggs",
                     "Dairy, Cheese, and Eggs",
                     "Fruits",
                     "Fruits",
                     "Fruits",
                     "Fruits",
                     "Vegetables",
                     "Drinks",
                     "Drinks",
                     "Drinks",
                     "Drinks"),
        stringsAsFactors = FALSE
)


category_price_range <- data.frame(
        category = c("Pasta and Rice",
                "Oils and Sauces",
                "Meat and Seafood",
                "Vegetables",
                "Dairy, Cheese, and Eggs",
                "Fruits",
                "Drinks"),
        mean_price = c(27,11,55,22,11,16,5),
        stringsAsFactors = FALSE
)


## Stores
stores <- data.frame(
        id = LETTERS[1:10],
        area = round(
                rnorm(10, mean = 130, sd = 20), 0),
        stringsAsFactors = FALSE
)


## Sales
transaction_count <- 100000


products_bought <- data.frame(
        product_name = sample(available_products$name, transaction_count, replace = TRUE),
        stringsAsFactors = FALSE
) %>%
        left_join(
                available_products, 
                c("product_name" = "name")
        ) %>%
        left_join(
                category_price_range, 
                c("category" = "category")
        ) %>%
        rowwise() %>%
        mutate(
                price = round(
                                rnorm(1, mean = mean_price, sd = mean_price/5),
                        0)
        ) %>%
        select(-mean_price)






## Dates
generate_dates<- function(N, st="2017-01-01", et="2017-12-31") {
        st <- as.POSIXct(as.Date(st), format = "%Y-%m-%d")
        et <- as.POSIXct(as.Date(et), format = "%Y-%m-%d")
        dt <- as.numeric(difftime(et,st,unit="sec"))
        ev <- sort(runif(N, 0, dt))
        rt <- st + ev
        rt <- as.Date(rt,format = "%Y-%m-%d")
}

dates <- data.frame(
        datetime = generate_dates(transaction_count)
)


transactions <- data.frame(
        id = seq(1,transaction_count,1),
        client_id = sample(customers$id, transaction_count, replace = TRUE),
        store_id = sample(stores$id, transaction_count, replace = TRUE)
) %>% 
        bind_cols(products_bought) %>%
        bind_cols(dates) %>%
        left_join(customers,
                  by = c("client_id" = "id"))


### Write data to csv
write_csv(transactions, "./src/data/transactions.csv")
write_rds(transactions, "./src/data/transactions.rds")