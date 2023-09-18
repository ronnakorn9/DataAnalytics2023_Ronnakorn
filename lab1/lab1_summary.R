summary(EPI) 	# stats
fivenum(EPI,na.rm=TRUE)
help(stem)
stem(EPI)		 # stem and leaf plot
# plot histrogram
help(hist)
hist(EPI)
hist(EPI, seq(30., 95., 1.0), prob=TRUE)
# add line plot
help(lines)
lines(density(EPI,na.rm=TRUE,bw=1.)) # or try bw=“SJ”
# add "rug" the frequency bar on x-axis
help(rug)
rug(EPI) 

