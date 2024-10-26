library(dplyr)

select_column <- function(dataset, col_name) {
    dataset |> 
      select({{col_name}}) 
}

filter_column <- function(dataset, col_name){
  dataset |> 
    filter({{col_name}} > 30)
}

create_column <- function(dataset, col_name){
  dataset |> 
    mutate(age_plus_five = {{col_name}} + 5) 
}

sample_df <- tibble(
  first_name = c("George", "Mark", "Jane"),
  last_name = c("John", "Kevin", "Joy"),
  age = c(20, 39, 40)
)

sample_df |> 
  select_column(age) |> 
  filter_column(age) |> 
  create_column(age)

