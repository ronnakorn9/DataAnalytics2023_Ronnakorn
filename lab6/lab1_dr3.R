### Packages in this lab, both EDR and edrGraphicalTools, are removed from CRAN repo
# see also https://cran.r-project.org/web/packages/edrGraphicalTools/index.html

# install.packages("EDR")
install.packages("./EDR_0.6-7.tar.gz", repos=NULL)
### there's installation issues



# library(EDR)
# install.packages("edrGraphicalTools")
###library(edrGraphicalTools)
demo(edr_ex1)
demo(edr_ex2)
demo(edr_ex3)
demo(edr_ex4)
