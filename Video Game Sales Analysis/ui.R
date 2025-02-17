library(plotly)
library(markdown)
library(bslib)
library(tidyverse)

vgsales_df <- read.csv("vgsales.csv", stringsAsFactors = FALSE)

vgsales_sum <- vgsales_df %>%
  group_by(Platform, Year) %>%
  summarize(total_sales = sum(Global_Sales, na.rm = TRUE))

vgsales_sum$Year <- as.numeric(vgsales_sum$Year)

my_theme <- bs_theme(bootswatch = "lux")

intro_tab <- tabPanel(
  "The Introduction",
  fluidPage(
    includeMarkdown("introduction_page.md")
  )
)

sidebar_panel_widget <- sidebarPanel(
  selectInput(
    inputId = "genre_selection",
    label = "Game Genres",
    choices = vgsales_df$Genre,
    selected = "Misc",
    multiple = TRUE
  ),
  sliderInput(
    inputId = "year_selection",
    label = "year slider",
    max = 2016,
    min = 1980,
    sep = "",
    value = c(1980, 1990)
  )
)

first_page_plot <- mainPanel(
  plotlyOutput(outputId = "game_plot"),
  fluidPage(
    includeMarkdown("chart_1_description.md")
  )
)

game_tab <- tabPanel(
  "Game Genre",
  sidebarLayout(
    sidebar_panel_widget,
    first_page_plot,
  )
)

sidebar_panel_widget_2 <- sidebarPanel(
  selectInput(
    inputId = "platform_selection",
    label = "Platform",
    choices = vgsales_sum$Platform,
    multiple = TRUE,
    selected = "Wii"
  ), sliderInput(inputId = "year_selection_2", label = h3("Slider(year)"), min = min(vgsales_sum$Year, na.rm = TRUE), max = max(vgsales_sum$Year, na.rm = TRUE), sep = "", value = c(2010, 2020))
)

main_panel_plot <- mainPanel(
  plotlyOutput(outputId = "platform_plot"),
  fluidPage(
    includeMarkdown("chart_2_description.md")
  )
)

platform_tab <- tabPanel(
  "Game Platform",
  sidebarLayout(
    sidebar_panel_widget_2,
    main_panel_plot,
  )
)

summary_tab <- tabPanel(
  "Summary",
  fluidPage(
    includeMarkdown("Summary.md")
  )
)

ui <- navbarPage(
  theme = my_theme,
  "Video Game Analysis",
  intro_tab,
  game_tab,
  platform_tab,
  summary_tab
)