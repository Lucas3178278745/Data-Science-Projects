library(ggplot2)
library(plotly)
library(dplyr)
library(tidyverse)

vgsales_df <- read.csv("vgsales.csv", stringsAsFactors = FALSE)

vgsales_sum <- vgsales_df %>%
  group_by(Platform, Year) %>%
  summarize(total_sales = sum(Global_Sales, na.rm = TRUE))

vgsales_sum$Year <- as.numeric(vgsales_sum$Year)

server <- function(input, output) {
  output$game_plot <- renderPlotly({
    filtered_dp <- vgsales_df %>%
      filter(Genre %in% input$genre_selection, na.rm = TRUE) %>%
      filter(Year >= input$year_selection[1] & Year <= input$year_selection[2])

    game_plot <- ggplot(data = filtered_dp) +
      geom_bar(mapping = aes(x = Year, color = Genre)) +
      labs(title = "Annual Game Releases", x = "Year", y = "Number of Release")

    return(game_plot)
  })

  output$platform_plot <- renderPlotly({
    filtered_df <- vgsales_sum %>%
      filter(Platform %in% input$platform_selection) %>%
      filter(Year >= input$year_selection_2[1] & Year <= input$year_selection_2[2])

    platform_sales_plot <- ggplot(data = filtered_df) +
      geom_line(mapping = aes(x = Year, y = total_sales, color = Platform, group = Platform)) +
      labs(title = "Game Sales by Platform", y = "Sales (millions)")

    return(platform_sales_plot)
  })
}