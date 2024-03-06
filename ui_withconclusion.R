library(plotly)
library(bslib)
library(dplyr)
library(markdown)
install.packages("shiny")
library(shiny)

df <- read.csv("https://raw.githubusercontent.com/info-201-wi24/final-project-Education_Salary/main/joined_df.csv")

## OVERVIEW TAB INFO

library(shiny)

# Other library calls and data preparation code

overview_tab <- tabPanel("Overview",
                         h1("INFO 201 Final Project BE4", align = "center"),
                         h2("Aijing Yang, Xiaobo Li, Jeffery Chen, Roxy Xu", align = "center"), 
                         p("In our project, we explore the correlation between regional employment condition and education level. 
      The data are collected globally, we will analyze the general educations in each region and see
      if there is a pattern between that and the employment rate and monthly salary.
      We found our two datasets on Kaggle, here are the links to the global educations and salary datasets respectively:"),
                         a(href = "https://www.kaggle.com/datasets/nelgiriyewithana/world-educational-data", "World Educational Data"),
                         p(),
                         a(href = "https://www.kaggle.com/datasets/zedataweaver/global-salary-data", "Global Salary Data"),
                         p("In order to perform analysis more explicitly, we combine the two datasets and select several features
      that are particularly relative to our major question."),
   p("Description of combined dataset:", style = "color: #333 ; font-size: 20px;"),
   p("country_name: country names are in type of strings"),
   p("continent_name: continen names are in type of strings"),
   p("wage_span: span of wage in type of strings"),
   p("median_salary: median salaries of all county are in type of double"),
   p("avrage_salary: average salaries of all county are in type of double"),
   p("lowest_salary: lowest salaries of all county are in type of double"),
   p("highest_salary: highest salaries of all county are in type of double"),
   p("OOSR_Upper_Secondary_Age_Female: Out-of school rate for lower secondary age females are in type of integer"),
   p("OOSR_Upper_Secondary_Age_male: Out-of school rate for lower secondary age males are in type of integer"),
   p("Completion_Rate_Upper_Secondary_Male: Completion Rate for upper secondary eduction among males are in type of integer"),
   p("Completion_Rate_Upper_Secondary_Feale: Completion Rate for upper secondary eduction among females are in type of integer"),
   p("Gross_Tertiary_Education_Enrollment: Gross enrollment in tertiay education are in type of integer"),
   p("Unemployment_Rate:Unemployment rates in the respective countries/areas are in type of double"),
   p("IS_above_average: The average salary in that country is above tha global average salary are in type of boolean"),
   p("income_gap: gaps between highest salaries and lowest salaries are in type of double "),
      
    p("Possible ethical questions and limitations: 
      The accuracy of the data, particularly self-reported education levels and salaries, can vary. 
      Biases may arise if certain groups are more likely to misreport or if there are discrepancies in how data 
      is collected. The dataset may contain sensitive personal information that could compromise the privacy of individuals. 
      Care must be taken to anonymize or aggregate data to protect individuals' identities.")
)

## VIZ 1 TAB INFO

viz_1_sidebar <- sidebarPanel(
  h2("Choose the Continent you want to see"),
  #TODO: Put inputs for modifying graph here
  selectInput(inputId = "continent",
              label = "Select a Continent", 
              choices = df$continent_name, 
              selected = "Asia", 
              multiple = FALSE)
)

viz_1_main_panel <- mainPanel(
  h2("Relationship between country and unemployment rate"),
  plotlyOutput(outputId = "viz_output_a")
)

viz_1_tab <- tabPanel("Viz 1: unemployment rate",
  sidebarLayout(
    viz_1_sidebar,
    viz_1_main_panel
  )
)

## VIZ 2 TAB INFO

viz_2_sidebar <- sidebarPanel(
  h2("Choose the Continent you want to see"),
  #TODO: Put inputs for modifying graph here
  selectInput(inputId = "continent",
              label = "Select a Continent", 
              choices = df$continent_name, 
              selected = "Asia", 
              multiple = FALSE)
)

viz_2_main_panel <- mainPanel(
  h2("Correlation between Rate of Completing Upper Secondary Education and Average Salary"),
  plotlyOutput(outputId = "viz_output_b")
)

viz_2_tab <- tabPanel("Viz 2: education rate vs. salary",
  sidebarLayout(
    viz_2_sidebar,
    viz_2_main_panel
  )
)

## VIZ 3 TAB INFO

viz_3_sidebar <- sidebarPanel(
  h2("Options for graph"),
  #TODO: Put inputs for modifying graph here
)

viz_3_main_panel <- mainPanel(
  h2("Vizualization 3 Title"),
  # plotlyOutput(outputId = "your_viz_1_output_id")
)

viz_3_tab <- tabPanel("Viz 3 tab title",
  sidebarLayout(
    viz_3_sidebar,
    viz_3_main_panel
  )
)

## CONCLUSIONS TAB INFO

conclusion_tab <- tabPanel("Conclusion Tab Title",
 h1("Conclusion",align = "center"),
 p("Through our careful study, we started an investigation to discover correlations between education levels and work 
   circumstances throughout the world. Our findings highlight trends that are essential to explaining economic and educational 
   inequality."),
 p(),
 p("Our tool navigates each continent's economic environment, from visualizing unemployment statistics and education rates versus
 earnings. Higher education levels tends to correlate with better work conditions, indicating a global trend in which education 
 serves as a catalyst for economic opportunity and stability."),
 p(),
 p("While our application offers a comprehensive view of these relationships, we can't overlook the changing global economy and the 
   evolving nature of education. As such, this project should be seen as a snapshot which allowing further studies to be built."),
 p(),
 p("In conclusion, our project showed the crucial ties between education and employment, promoting a forward-thinking education 
   policy and economic planning to be made. By investing in education, we invest in the future stability and prosperity of our 
   global society.")
 
)



ui <- navbarPage("Example Project Title",
  overview_tab,
  viz_1_tab,
  viz_2_tab,
  viz_3_tab,
  conclusion_tab
)