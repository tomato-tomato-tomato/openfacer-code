#install the latest version of OpenFaceR 
install.packages("remotes")
remotes::install_github("davidecannatanuig/openFaceR")

#load packages 
library(openfacer)
library(tidyverse)
library(pracma)

#1. Read in output from OpenFace (i.e., individual csv files): allows us to import all csv files contained in a given folder into object of class "faces", similar to a list. "Faces" is a list of tibles - each tibble represents output from one video. 

output <- read_face_csvs(output_dir = "/Users/manvisethi/FIT/cleancsvs/") 
#output <- output[1]

#2. Filter out unsuccessful frames. Could potentially use this step to clean up CSV files also! eg. filter_face(timestamp < 180) Results can be stored in new filtered faces objects or can use pipes to complete subsequent steps. 
#filtered_output <- filter_faces(output, success == 1)


#Calculate emotions based on the appropriate action units. Adds a new column at the end of data frame 

emotion_output <- output %>%
  openfacer::mutate_faces(happiness = if_else(AU12_c + AU06_c == 2, 1, 0),
                          sadness = if_else(AU01_c + AU04_c + AU15_c == 3, 1, 0),
                          fear = if_else(AU01_c + AU02_c + AU04_c + AU05_c + AU07_c + AU20_c + AU26_c == 7, 1, 0),
                          anger = if_else(AU04_c + AU05_c + AU07_c + AU23_c == 4, 1, 0))


#3. Selects just the happiness variable from output2 and puts into a new file called output3 

select_happiness <- select_faces(emotion_output,happiness) 
select_sadness <- select_faces(emotion_output,sadness) 
select_fear <- select_faces(emotion_output,fear) 
select_anger <- select_faces(emotion_output,anger) 


