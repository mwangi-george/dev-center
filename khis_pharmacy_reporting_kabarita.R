
library(janitor)
library(tidyverse)
library(httr)
library(readxl)

# Define your credentials
username <- "kabarita"
password <- "Kenya@2024"


# Define the API URL
api_url <- "https://pharmacyreporting.uonbi.ac.ke/api/analytics.csv?dimension=pe%3ALAST_6_MONTHS&dimension=dx%3AUpS2bTVcClZ.ACTUAL_REPORTS%3Bg3RQRuh8ikd.ACTUAL_REPORTS%3BUpS2bTVcClZ.EXPECTED_REPORTS%3Bg3RQRuh8ikd.EXPECTED_REPORTS%3BUpS2bTVcClZ.ACTUAL_REPORTS_ON_TIME%3Bg3RQRuh8ikd.ACTUAL_REPORTS_ON_TIME&dimension=ou%3ALEVEL-DDrLl1pFCQk&showHierarchy=true&hierarchyMeta=true&includeMetadataDetails=true&includeNumDen=true&skipRounding=false&completedOnly=false&outputIdScheme=NAME"

# Make API request with SSL verification disabled
response <- GET(api_url, authenticate(user = username, password = password))

response %>% status_code()

result <- response %>% 
  content() %>% 
  rawToChar(x = .) %>% 
  read.csv(text = .) %>% 
  select(1:4) %>% 
  clean_names() %>% 
  mutate(period = my(period)) %>% 
  separate(organisation_unit, into = c("organization", "code"), sep = "\\s*\\(\\s*|\\s*\\)")
  
# Output file name
output_file <- "KHIS_Data2.xlsx"
openxlsx::write.xlsx(result, output_file)

