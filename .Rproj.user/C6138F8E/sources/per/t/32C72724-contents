library(rvest)
library(tidyverse)
library(httr)

#Scraping draft info from 2011 to 2021
scrape_draft <- function(year) {
  message("Scraping draft: ", year)
  Sys.sleep(3)
  url <- paste0("https://www.basketball-reference.com/draft/NBA_", year, ".html")
  
  headers <- add_headers(`User-Agent` = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36")
  
  response <- GET(url, headers)
  
  page <- read_html(httr::content(response, "text", encoding = "UTF-8"))
  
  table <- page |>
    html_element("#stats") |>
    html_table(header = FALSE)
  
  colnames(table) <- make.unique(as.character(table[2, ]))
  
  table |>
    slice(-(1:2)) |>
    mutate(draft_year = year)
}

#Conversion to clean data
draft_raw <- map_df(2011:2021, scrape_draft)

draft_clean <- draft_raw |>
  filter(!Pk %in% c("Pk", "")) |>
  select(pick = Pk, player = Player, draft_year) |>
  filter(!is.na(player) & player != "") |>
  mutate(pick = as.integer(pick), draft_year = as.integer(draft_year)) |>
  distinct(player, .keep_all = TRUE)

#Now scraping advanced stats from 2014 to 2026
scrape_advanced <- function(season_end_year) {
  message("Scraping advanced stats: ", season_end_year)
  Sys.sleep(3)
  url <- paste0("https://www.basketball-reference.com/leagues/NBA_", season_end_year, "_advanced.html")
  
  headers <- add_headers(`User-Agent` = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36")
  
  response <- GET(url, headers)
  
  page <- read_html(httr::content(response, "text", encoding = "UTF-8"))
  
  table <- page |>
    html_element("#advanced") |>
    html_table(header = FALSE)
  
  colnames(table) <- make.unique(as.character(table[1, ]))
  
  table |>
    slice(-1) |>
    mutate(season = season_end_year)
}

#Conversion to clean data
advanced_raw <- map_df(2011:2026, scrape_advanced)

advanced_clean <- advanced_raw |>
  filter(!duplicated(paste(Player, season))) |>
  select(player = Player, season, BPM) |>
  filter(!is.na(BPM) & BPM != "") |>
  filter(season >= 2014) |>
  mutate(BPM = as.numeric(BPM),
         season = as.integer(season))
