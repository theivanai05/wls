## Main File 

## Installing all of the Libraries required : 

  #install.packages("tidyverse")
  #install.packages("data.table")
  #install.packages("dplyr")
  #install.packages("recosystem")
  # -- Not Required #install.packages("Hmisc")


  library(tidyverse)
  library(data.table)
  library(dplyr)
  library(recosystem)
  # -- Not Required #library(R.utils)
  # -- Not Required #library(Hmisc)
  
## Setting Working Directory 
  # Current 
  #setwd("~/wls")
  
  
  ## New Data Directory - mac
     # "~/wls/Data"
  ## Code Directory 
     # "~/wls/Code"
  
# Reading in the Master files from TeamStreamz
  # Date File Location 
  #setwd("~/Documents/NUS_EBAC/Data") # data location of Mac
  setwd("C:/Users/theiv/Documents/2019_ISS_MTech_EBAC/Capstone Project/FYP_TeamsStreamz/Data") # location in Lenovo
  
  
  # Pulling in Data from Trade Source  -- Run if you need a fresh COPY 
  
    #assess_dt = data.table(read_csv("user_assessments.gz"))
    #master_dt= data.table(read_csv("user_master.gz"))
    #views_dt= data.table(read_csv("views_model.gz"))
    
# Pulling in Data from Pulse Score 
    #pulsescore_Master = data.table(read.csv("master.csv",header=TRUE, sep= ",")) # India Data Set - Pulse Score Alone 
  
  #setwd("C:/Users/theiv/Documents/2019_ISS_MTech_EBAC/Capstone Project/FYP_TeamsStreamz/Data/PS") # location for Combined PS
  #pulsescore_Master_All = read.csv("pulse_score.csv",header=TRUE, sep= ",") # All Country Data Set - Pulse Score Alone 
  
  #save.image("Base_DS_after_Filereads.RData")
  load("Base_DS_after_Filereads.RData")
  
## Running the Serialization Code for Attaching Tags into Views Data
  # Coming back into current WD 
  #setwd("~/wls")
  setwd("C:/Users/theiv/Documents/2019_ISS_MTech_EBAC/Capstone Project/FYP_TeamsStreamz/wls")
  
  # Sourcing the Underlying Functions 
  source("Code/underlyingfunctions.R")
  
  # Sourcing the Tagged Deck/ Views data set with Serialized Tags 
  source("Code/asses_view_seareaz.R")
  
  # Sourcing and running the 
  source("Code/users_questions_marks_assessment_viewed.R")
   #u_q_t_M # Users, questions , Trial result master
   #u_d_a_m # Users, decks , actions master 
  
  # Running the Tag Recommender 
  source("Code/CS_WLS_Recosystem_V2.R")
  
  # Churning out the question and streams to be recommended 
  source("Code/upskill_qns_deck_reco.R")
  
  # Demo Users FOR GUI 
  Demo_Users = c("97d0a65c","b1459d23","c80bffb2","c930cc66","f10f490e","f810564e")
  
  # setting WD back to Project Data Location 
  #setwd("~/wls/Data")
  setwd("C:/Users/theiv/Documents/2019_ISS_MTech_EBAC/Capstone Project/FYP_TeamsStreamz/Data")
  
  ## Checking if the Users exists 
  USER_Qns_Reco %>% filter(masked_user_id %in% Demo_Users)
  USER_Stream_Reco %>% filter(masked_user_id %in% Demo_Users)
  test_pred_V2 %>% filter(masked_user_id  %in% Demo_Users)
  
  saveRDS(USER_Stream_Reco,file = "UpSkill_Stream_Recommendation.RDS")
  saveRDS(USER_Qns_Reco,file = "UpSkill_Question_Recommendation.RDS")
  
  # Saving working directory to Local Directory 
    # setwd("~/Documents/NUS_EBAC")   -- To Uncomment when saving the Rdata Source
    # save.image("Data/WLS_22082020_V2.RData")
    # load("Data/WLS_22082020_V2.RData")
  
  
  