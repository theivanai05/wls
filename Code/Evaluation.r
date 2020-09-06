## Recommender Lab Evaluations : 



scheme <- evaluationScheme(temp[1:100], method="cross", k=4, given=3) 
#, given=3, goodRating=5)
evaluationScheme(data, method="split", train=0.8, k=10, given=3)
scheme

results <- evaluate(scheme, method="POPULAR", type = "topNList", n=c(1,3,5,10,15,20))