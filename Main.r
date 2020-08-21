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
  
  
  
  
  
  