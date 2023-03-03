#install the latest version of OpenFaceR 
install.packages("remotes")
remotes::install_github("davidecannatanuig/openFaceR")

#load packages 
library(openfacer)
library(tidyverse)
library(pracma)
library(purrr)
library(dplyr)

#Read in output from openface (i.e., individual csv files): allows us to import all csv files contained in a given folder into object of class "faces", similar to a list. "Faces" is a list of tibbles - each tibble represents output from one video. 
output <- read_face_csvs(output_dir = "/Users/manvisethi/FIT/cleancsvs/synced/") 

#Calculate emotions based on the appropriate action units. This will add a new column at the end of each tibble. 
emotion_output <- output %>%
  openfacer::mutate_faces(happiness = if_else(AU12_c + AU06_c == 2, 1, 0),
                          sadness = if_else(AU01_c + AU04_c + AU15_c == 3, 1, 0),
                          fear = if_else(AU01_c + AU02_c + AU04_c + AU05_c + AU07_c + AU20_c + AU26_c == 7, 1, 0),
                          anger = if_else(AU04_c + AU05_c + AU07_c + AU23_c == 4, 1, 0))

#Selects a specific emotion variable from emotion_output and creates a new tibble with timestamp, frame, success status, and emotion observation. 
select_happiness <- select_faces(emotion_output,happiness) 
select_sadness <- select_faces(emotion_output,sadness) 
select_fear <- select_faces(emotion_output,fear) 
select_anger <- select_faces(emotion_output,anger) 

#Create summaries for each emotion 
#anger
anger_counts <- select_anger %>% 
  map_dbl(~ sum(.x$anger == 1)) %>% 
  tibble(name = names(select_anger), count = .)
# print the resulting data frame
anger_counts

#fear
fear_counts <- select_fear %>% 
  map_dbl(~ sum(.x$fear == 1)) %>% 
  tibble(name = names(select_fear), count = .)
# print the resulting data frame
fear_counts

#sadness
sadness_counts <- select_sadness %>% 
  map_dbl(~ sum(.x$sadness == 1)) %>% 
  tibble(name = names(select_sadness), count = .)
# print the resulting data frame
sadness_counts

#happiness
happiness_counts <- select_happiness %>% 
  map_dbl(~ sum(.x$happiness == 1)) %>% 
  tibble(name = names(select_happiness), count = .)
# print the resulting data frame
happiness_counts
