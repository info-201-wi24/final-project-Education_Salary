library(plotly)
library(bslib)
library(dplyr)
library(markdown)

df <- read.csv("https://raw.githubusercontent.com/info-201-wi24/final-project-Education_Salary/main/joined_df.csv")

#my_theme <- bs_theme(bg = "#0b3d91", #background color
#                     fg = "white", #foreground color
#                     primary = "black", # primary color
#) 
my_theme <- bs_theme()
my_theme <- bs_theme_update(my_theme, bootswatch = "minty") 

## OVERVIEW TAB INFO

overview_tab <- tabPanel("Overview",
   h1("INFO 201 Final Project BE4", align = "left"),
   h6("Aijing Yang, Xiaobo Li, Jeffery Chen, Roxy Xu", align = "left"), 
   img(src = "education_employment.jpg", hight = "300px", width = "500px", align = "center"),
   p("In our project, we explore the correlation between regional employment condition and education level. 
      The data are collected globally, we will analyze the general educatoins in each region and see
      if there is a pattern between that and the employment rate and monthly salary.
      We found our two datasets on kaggle, here are the links of global educations and salaray respectively:"),
   a("https://www.kaggle.com/datasets/nelgiriyewithana/world-educational-data", href = "url"),
   p(),
   a("https://www.kaggle.com/datasets/zedataweaver/global-salary-data", href = "url"),
   p(),
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
  select_widget1 <-selectInput(inputId = "continent1",
              label = "Select a Continent", 
              choices = df$continent_name, 
              selected = "Asia", 
              multiple = FALSE)
)

viz_1_main_panel <- mainPanel(
  h2("The Unemployment Rates of Countries"),
  plotlyOutput(outputId = "viz_output_a"),
  p("Analysis")
)

viz_1_tab <- tabPanel("Viz 1: Unemployment Rate",
  sidebarLayout(
    viz_1_sidebar,
    viz_1_main_panel
  )
)

## VIZ 2 TAB INFO

viz_2_sidebar <- sidebarPanel(
  h2("Choose the Continent you want to see"),
  #TODO: Put inputs for modifying graph here
  select_widget2 <- selectInput(inputId = "continent2",
              label = "Select a Continent", 
              choices = df$continent_name, 
              selected = "Asia", 
              multiple = FALSE)
)

viz_2_main_panel <- mainPanel(
  h2("Correlation between Rate of Completing Upper Secondary Education and Average Salary"),
  plotlyOutput(outputId = "viz_output_b")
)

viz_2_tab <- tabPanel("Viz 2: Education Rate vs. Salary",
  sidebarLayout(
    viz_2_sidebar,
    viz_2_main_panel
  )
)

## VIZ 3 TAB INFO

viz_3_sidebar <- sidebarPanel(
  h2("Choose the range of income gap and the Continent you want to see"),
  #TODO: Put inputs for modifying graph here
  slider_widget1 <- sliderInput(inputId= "slider2", 
              label = "Income-gap Range", 
              min = 0, 
              max = max(df$Income_gap), 
              value = c(40, 60)),
  select_widget3 <- selectInput(inputId = "continent3",
              label = "Select a Continent", 
              choices = df$continent_name, 
              selected = "Asia", 
              multiple = FALSE)
)

viz_3_main_panel <- mainPanel(
  h2("Pattern Between Income-Gap and Employment Rate"),
  plotlyOutput(outputId = "viz_output_c")
)

viz_3_tab <- tabPanel("Viz 3: Income Gap and Employment Rate",
  sidebarLayout(
    viz_3_sidebar,
    viz_3_main_panel
  )
)

## CONCLUSIONS TAB INFO

conclusion_tab <- tabPanel("Conclusion",
 h1("Conclusion"),
 p("some conclusions")
)


ui <- navbarPage("Relationship Between Education-level and Employments",
  theme = my_theme,
  overview_tab,
  viz_1_tab,
  viz_2_tab,
  viz_3_tab,
  conclusion_tab
)