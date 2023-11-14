### MetaPCA is no longer in cran repo, need to manually download the 'tar' from archive
### https://cran.r-project.org/src/contrib/Archive/MetaPCA/
### install.packages("./MetaPCA_0.1.4.tar.gz", repos=NULL)

# install.packages("MetaPCA")
library(MetaPCA)
library(iterators)

#Spellman, 1998 Yeast cell cycle data set
#Consider each synchronization method as a separate data
data(Spellman) 
pc <- list(alpha=prcomp(t(Spellman$alpha))$x, cdc15=prcomp(t(Spellman$cdc15))$x,
			cdc28=prcomp(t(Spellman$cdc28))$x, elu=prcomp(t(Spellman$elu))$x)
#There are currently 4 meta-pca methods. Run either one of following four.
metaPC <- MetaPCA(Spellman, method="Eigen", doPreprocess=FALSE)
metaPC <- MetaPCA(Spellman, method="Angle", doPreprocess=FALSE) # miss this one

### there's error with Bioconductor that keep causing an error
# Error: With R version 3.5 or greater, install Bioconductor packages using BiocManager; see https://bioconductor.org/install
# my "BiocManager::valid()" returns true
# but the error is still there
metaPC <- MetaPCA(Spellman, method="RobustAngle", doPreprocess=FALSE)
metaPC <- MetaPCA(Spellman, method="SparseAngle", doPreprocess=FALSE)


#Comparing between usual pca and meta-pca
#The first lows are four data sets based on usual PCA, and 
#the second rows are by MetaPCA
#We're looking for a cyclic pattern.
par(mfrow=c(2,4), cex=1, mar=c(0.2,0.2,0.2,0.2))
for(i in 1:4) {
		plot(pc[[i]][,1], pc[[i]][,2], type="n", xlab="", ylab="", xaxt="n", yaxt="n")
		text(pc[[i]][,1], pc[[i]][,2], 1:nrow(pc[[i]]), cex=1.5)
		lines(pc[[i]][,1], pc[[i]][,2])
}
for(i in 1:4) {
		plot(metaPC$x[[i]]$coord[,1], metaPC$x[[i]]$coord[,2], type="n", xlab="", ylab="", xaxt="n", yaxt="n")
		text(metaPC$x[[i]]$coord[,1], metaPC$x[[i]]$coord[,2], 1:nrow(metaPC$x[[i]]$coord), cex=1.5)
		lines(metaPC$x[[i]]$coord[,1], metaPC$x[[i]]$coord[,2])
}
### note: column 3,4 are just a long chain
### column 1 has a chain with messy end, not sure if there's a loop
### column 2 is super messy can't see anything
