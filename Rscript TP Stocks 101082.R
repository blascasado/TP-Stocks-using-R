df= read.csv('partData.csv')
partDemand= read.csv('partDemand.csv')
parts= read.csv('partsPerPadron.csv')
parts82= parts[c("id", "ends.82")]
parts82= parts82[parts82$ends.82 == 1, ]

parts82= merge(parts82, df, by="id")
parts82= merge(parts82, partDemand, by="id")

parts82$promD= rowMeans(parts82[ , c(9:508)])

parts82$Q= sqrt(300*parts82$promD*2*parts82$k/parts82$c1)*sqrt((parts82$c1+parts82$c2)/parts82$c2)
parts82$Sopt= parts82$c1*parts82$Q/(parts82$c1+parts82$c2)
parts82$So= parts82$Q-parts82$Sopt
parts82$ROP= parts82$lt*parts82$promD-(parts82$Q-parts82$So)
parts82= parts82[c("id", "ROP", "Q")]
parts82$ROP= ceiling(parts82$ROP)
parts82$Q= ceiling(parts82$Q)

write.csv(parts82, file = "poli_101082.csv", row.names=FALSE)