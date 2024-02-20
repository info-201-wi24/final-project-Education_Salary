library(dplyr)
salary_df <- read.csv("salary_data.csv")
education_df <- read.csv("Global_Education.csv")

#join 
joined_df <- left_join(salary_df,education_df, by = "country_name")

#clean
joined_df <- distinct(joined_df)
#select useful columns
joined_df <- joined_df %>% select(country_name, continent_name, wage_span, median_salary, 
                                  average_salary, lowest_salary, highest_salary, OOSR_Upper_Secondary_Age_Female,
                                  OOSR_Upper_Secondary_Age_Male, Gross_Tertiary_Education_Enrollment, Unemployment_Rate)
# delete NA
joined_df <- na.omit(joined_df)
            
#create a new categorical variable
#average monthly salary of 178 countries's average salary
avg_salaray <- joined_df %>% select(average_salary) %>% summarize(avg_salaray = mean(average_salary)) %>% pull(avg_salaray)
joined_df <- joined_df %>% mutate(IS_above_average = average_salary > avg_salaray)
#create a new numberical variable
joined_df <- joined_df %>%  mutate(Income_gap = highest_salary-lowest_salary)
#create the summarization
summary_df <- joined_df %>% group_by(continent_name) %>% summarize(num_countries = n(),
                                                                   avg_avg_salary = mean(average_salary),
                                                                   avg_med_salary = mean(median_salary),
                                                                   avg_high_salary = mean(highest_salary),
                                                                   avg_low_salary = mean(lowest_salary))
