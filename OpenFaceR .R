library(openfacer)
library(dplyr)
library(magrittr)
library(tidyverse)
library(pracma)

#1. import all csv files contained in a folder into object "faces," a list of tibbles where each tibble represents openface output from one vdieo files 
read_face_csvs(output_dir = "/Users/manvisethi/FIT/testnews/") %>%
filter_faces(success == 1) %>%
  mutate_faces(happiness= ifelse(AU12_c + AU06_c == 2,1,0)) %>% 
  select_faces(happiness) %>% 
  tidy_face(events_sum="epm",median=TRUE)
