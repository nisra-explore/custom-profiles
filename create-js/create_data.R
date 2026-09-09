rm(list=ls())
source("create-js/config.R")
options(useFancyQuotes = FALSE)

# Run code for importing data portal and flexible table builder data
source("create-js/data_prep.R")

final_json <- convert_named_vectors(final_json)

replace_na_strings <- function(x) {
  if (is.list(x)) {
    lapply(x, replace_na_strings)
  } else if (is.character(x)) {
    x[x == "NA"] <- NA
    x
  } else {
    x
  }
}

data <- jsonlite::fromJSON("data.json", simplifyVector = FALSE)

final_json <- replace_na_strings(final_json)

write_json(final_json, "data.json", pretty = TRUE, auto_unbox = TRUE, na = "null")

