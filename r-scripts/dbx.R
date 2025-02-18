library(DBI)


config <- list(
  db_name = Sys.getenv("POSTGRES_DB_NAME"),
  db_pass = Sys.getenv("POSTGRES_DB_PASSWORD")
)


db <- dbConnect(RSQLite::SQLite(), "users.db")

users <- tibble::tibble(
  first_name = c("george", "muthoni"),
  last_name = c("mwangi", "maina"),
  gender = c("M", "F"),
  is_married = c(FALSE, TRUE)
)

dbWriteTable(db, name = "users", value = users)
