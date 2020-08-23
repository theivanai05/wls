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
  setwd("~/wls")
  
  
  ## New Data Directory 
     # "~/wls/Data"
  ## Code Directory 
     # "~/wls/Code"
  
# Reading in the Master files from TeamStreamz
  # Date File Location 
  setwd("~/Documents/NUS_EBAC/Data")
  
  # Pulling in Data from Trade Source 
  
  assess_dt = data.table(read_csv("user_assessments.gz"))
  master_dt= data.table(read_csv("user_master.gz"))
  views_dt= data.table(read_csv("views_model.gz"))
  
# Pulling in Data from Pulse Score 
  pulsescore_Master = data.table(read.csv("master.csv",header=TRUE, sep= ","))
  
## Running the Serialization Code for Attaching Tags into Views Data
  # Coming back into current WD 
  setwd("~/wls")
  
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
  setwd("~/wls/Data")
  
  ## Checking if the Users exists 
  USER_Qns_Reco %>% filter(masked_user_id %in% Demo_Users)
  USER_Stream_Reco %>% filter(masked_user_id %in% Demo_Users)
  test_pred_V2 %>% filter(userid %in% Demo_Users)
  
  saveRDS(USER_Stream_Reco,file = "UpSkill_Stream_Recommendation.RDS")
  saveRDS(USER_Qns_Reco,file = "UpSkill_Question_Recommendation.RDS")
  
  # Saving working directory to Local Directory 
    # setwd("~/Documents/NUS_EBAC")   -- To Uncomment when saving the Rdata Source
    # save.image("Data/WLS_22082020_V2.RData")
    # load("Data/WLS_22082020_V2.RData")
  
  
  