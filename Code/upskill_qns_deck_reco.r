#Looking at what to recommend to each user : 

#Input from Recosystem_V2.r 
#colnames(test)
#[1] "userid" "qtag" "pulsescore" "prediction" "MAE"   
test_pred_V2 = test  %>% filter(test$userid == "002c7b9d") 

#####3) Understanding the Master Users 
#Country_User_M = unique(master_dt[,c("country","masked_user_id")])
# Total Users in the system 
Users_M = unique(Country_User_M[,c("masked_user_id")])
# ==> Users_M and Country_User_M has the same list of users; Thus It gives evidence that all Users are Unique to 1 country only. 

# Pulling in the Bottom 100 recommendations based on prediction for each user ## Would not work as there are not too many Tags for each users 
#tag_recommend = top_n(test_pred_V2,-100,test_pred_V2$prediction)
#tag_recommend = tag_recommend["qtag"]


#have put in a value of 0.99 assuming that a user with that value will be a good performer
tag_recommend  = test_pred_V2 %>% filter(test_pred_V2$prediction <= '0.99') 
#rm(test_pred_V2)

#Given the Tags Recommended; Pull out the questions for the tags
## Pulling out Deck IDs for the Corresponding TAGS recommended.   

#### Left Join using merge function
df = merge(x=C_Q_TAG_SER,y=tag_recommend,by.x="question_tags.1",by.y="qtag" )
df = df[,c("question_tags.1","question_id","country","prediction","userid")] 

# Rename column names
names(df)[names(df) == "question_tags.1"] <- "qtags"


df2 = merge(x=C_Q_TAG_SER,y=tag_recommend,by.x="question_tags.2",by.y="qtag" )
df2 = df2[,c("question_tags.2","question_id","country","prediction","userid")]

names(df2)[names(df2) == "question_tags.2"] <- "qtags"

#this is the set of questions recommended for a particular User for a set of 6 Tags... 
#???? ### Yet to Do ### ???? Iterations across all users is yet to be done ???? ### Yet to Do ### ????
qns_recommended = data.table(rbind(df,df2))
qns_recommended = data.table(qns_recommended)


## For the TAGS, Need to pick up Questions ANswered Wrongly or Not answered yet 
## Input Required What has the User ANswered and Wrongly Answered  -- DONE 
## for Reduction in Questions that is to be recommended...  -- DONE 

####1)  Questions ANswered by Users D.T = u_q_t_M

# ==> Pass1 : Questions not yet answered 
#u_q_t_M %>% filter( masked_user_id == "002c7b9d" & qns_ans == 0)
# ==> Pass2 : Questions already answered
qns_answered_by_user = u_q_t_M %>% filter( masked_user_id == "002c7b9d" & qns_ans == 1)
qns_answered_by_user = data.table(qns_answered_by_user[,c("masked_user_id","question_id")])
#    masked_user_id question_id no_of_trials points_earned qns_ans

# ==> Rate of Questions answered to not answered 
# ==> Not yet relevant Here


#Final User unanswered list of questions 
USER_Qns_Reco = qns_recommended[!qns_answered_by_user, on="question_id"]   

#Users' Country of residence... 
#Country_User_M %>% filter( Country_User_M$masked_user_id == "002c7b9d")

#Recommendation Based on the Country for a Single User: 
#Change Column Names 
#names(USER_Qns_Reco)[names(USER_Qns_Reco) == "userid"] <- "masked_user_id"

USER_Qns_Reco = merge(USER_Qns_Reco, Country_User_M,by = c("masked_user_id","country")) 


#Pull Out the TAG_STREAM Master table
#For the choosen Question Tags (QTAG), pull out the corresponding Stream Tags That has yet to be viewed 
#Output : User Id ==> (DeckID)
#=> Decks Viewed by user == u_d_a_M
####2)  Streams Viewed by Users D.T = u_d_a_M
#View(u_d_a_M)

# ==> Pass1 : STREAMS not yet Viewed 
#u_d_a_M %>% filter( masked_user_id == "002c7b9d" & completed == 0)
# ==> Pass2 : STREAMS already completed
streams_view_by_user = u_d_a_M %>% filter( masked_user_id == "002c7b9d" & completed == 1)
streams_view_by_user = data.table(streams_view_by_user [,"deck_id"])

## Pulling out Deck IDs for the Corresponding TAGS recommended.   
sel.col <- c("question_tags.1","question_tags.2","question_tags.3","question_tags.4")
out.col <- c("deck_id","country","masked_user_id")

# DeckIds- Streams : for Tags Recommended  
stream_recommended = views_sear_tags_dt[views_sear_tags_dt[, Reduce(`|`, lapply(.SD, `%in%`, tag_recommend[,c("qtag")])),.SDcols = sel.col],..out.col]
stream_recommended = unique(stream_recommended)

#Final User Unviewed list of STREAMS 
## ?? Yet to Do ?? ##
USER_Stream_Reco = stream_recommended[!streams_view_by_user, on="deck_id"]  

# ==> Streams Data : 
#View(views_sear_tags_uniq_dt)
#View(tag_recommend) 

#Users' Country of residence... 
#userid_country_M %>% filter( masked_user_id == "002c7b9d")

#Recommendation Based on the Country for a Single User: 
#USER_Stream_Reco = USER_Stream_Reco %>% filter(country %in% "IN") %>% unique()
USER_Stream_Reco = merge(USER_Stream_Reco , Country_User_M,by = c("country")) 


USER_Qns_Reco = setcolorder(USER_Qns_Reco, c("country", "question_id", "qtags"))
USER_Stream_Reco = setcolorder(USER_Stream_Reco, c("country", "deck_id"))

write.csv(USER_Stream_Reco,"Data/UpSkill_Stream_Recommendation.csv")
write.csv(USER_Qns_Reco,"Data/UpSkill_Question_Recommendation.csv")

#Fields for the Streams : 
#country, masked_user_id , deck_id , predicted
#Fields for the questions : 
#country, masked_user_id , question_id , predicted