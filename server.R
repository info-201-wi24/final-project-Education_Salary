library(ggplot2)
library(plotly)
library(dplyr)


server <- function(input, output){
  df <- read.csv("https://raw.githubusercontent.com/info-201-wi24/final-project-Education_Salary/main/joined_df.csv")
  
  
  # TODO Make outputs based on the UI inputs here
  output$viz_output_a <- renderPlotly({
    continent_1 <- df %>% filter(continent_name == input$continent1)
    
    output_a <- ggplot(continent_1) + 
      geom_col(aes(x = country_name,
                   y = Unemployment_Rate, 
                   fill = country_name)) +
      theme(axis.text.x = element_text(angle = 270, vjust = 0.5, hjust=1)) +
      labs(x = "Country", y = "Unemployment Rate")
    ggplotly(output_a)
    
  })
  
  output$viz_output_b <- renderPlotly({
    continent_2 <- df %>% filter(continent_name == input$continent2)
    
    output_b <- ggplot(continent_2) + 
      geom_point(aes (x = Completion_Rate_Upper_Secondary_Female + Completion_Rate_Upper_Secondary_Male,
                      y = average_salary,
                      color = country_name)) +
      geom_smooth(aes(x =  Completion_Rate_Upper_Secondary_Female + Completion_Rate_Upper_Secondary_Male,
                      y = average_salary)) +
      labs(x = "Completion rate of upper secondary education", y = "Average Salary")
    ggplotly(output_b)
  })
  

  
  output$viz_output_c <- renderPlotly({
    # range <- seq(input$slider2[1], input$slider2[2])
    income_gap_df <- df %>% mutate(Income_gap_integer = round(Income_gap)) %>% 
      filter(Income_gap_integer > input$slider2[1] & Income_gap_integer < input$slider2[2]) %>% 
      filter(continent_name == input$continent3)
    
    output_c <- ggplot(income_gap_df) +
      geom_col(aes(x = country_name,
                   y = - (1-Unemployment_Rate),
                   fill = country_name)) + 
      theme(axis.text.x = element_text(angle = 270, vjust = 0.5, hjust=1)) +
      labs(x = "Country", y = "Employment Rate")
    ggplotly(output_c)
  })
}