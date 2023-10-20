data(swiss)
sclass <- kmeans(swiss[2:6], 3) 
table(sclass$cluster, swiss[,1])    


pairs(swiss[2:6], col=sclass$cluster)

col_pat <- c("#00AFBB", "#E7B800", "#FC4E07")  
pairs(swiss[4:6], col=col_pat[sclass$cluster], pch=19)


### trying 2 cluster
sclass_2 <- kmeans(swiss[2:6], 2) 

col_pat <- c("#00AFBB", "#FC4E07")  
pairs(swiss[4:6], col=col_pat[sclass_2$cluster], pch=19)
### we can see clear cluster in "Catholic" vs "Infant Mortality"