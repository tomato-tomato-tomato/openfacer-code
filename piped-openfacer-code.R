library(openfacer)
library(dplyr)
library(magrittr)
library(tidyverse)
library(pracma)

read_face_csvs(output_dir = "/test_videos/") %>%
  filter_faces(success == 1) %>%
  mutate_faces(happiness= ifelse(AU12_c + AU06_c == 2,1,0)) %>% 
  select_faces(happiness) %>% 
  tidy_face(events_sum="epm",median=TRUE)
