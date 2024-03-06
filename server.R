library(ggplot2)
library(plotly)
library(dplyr)


server <- function(input, output){
  df <- read.csv("https://raw.githubusercontent.com/info-201-wi24/final-project-Education_Salary/main/joined_df.csv")
  
  
  # TODO Make outputs based on the UI inputs here
  output$viz_output_a <- renderPlotly({
    continent <- df %>% filter(continent_name == input$continent)
    
    output_a <- ggplot(continent) + 
      geom_col(aes(x = country_name,
                   y = Unemployment_Rate, 
                   fill = country_name)) +
      theme(axis.text.x = element_text(angle = 270, vjust = 0.5, hjust=1)) +
      labs(x = "Country", y = "Unemployment Rate")
    ggplotly(output_a)
    
  })
  
  output$viz_output_b <- renderPlotly({
    continent <- df %>% filter(continent_name == input$continent)
    
    output_b <- ggplot(continent) + 
      geom_point(aes (x = Completion_Rate_Upper_Secondary_Female + Completion_Rate_Upper_Secondary_Male,
                      y = average_salary,
                      color = country_name)) +
      geom_smooth(aes(x =  Completion_Rate_Upper_Secondary_Female + Completion_Rate_Upper_Secondary_Male,
                      y = average_salary)) +
      labs(x = "Completion rate of upper secondary education", y = "Average Salary")
  })
  
}