IDDEAD<-c(25, 29, 63, 80, 86, 88, 97)
IDLIVE<-c(1, 2, 3, 5, 6, 8, 9)
NN<-7

BSI1_DEAD<-c(10.0342,   10.7511,   10.1901,   11.4718,    9.3788,   12.4222,    9.9593)
BSI1_LIVE<-c(9.6522,   12.2812,   12.6265,   12.0375,   12.1202,   11.3540,   11.6501)
BSI01_DEAD<-c(10.504,   11.469,   10.783 ,  11.986,   10.583,   13.482,   10.577)
BSI01_LIVE<-c(10.170,   13.281,   13.048,   12.905,   13.285,   11.984,   12.693)
BSI00_DEAD<-c(15.702,   16.350,   18.905,   18.381,   19.758,   20.053,   18.134)
BSI00_LIVE<-c(18.467,   22.138,   21.534,   22.719,   24.288,   21.343,   23.058)
BSIA_DEAD<-c(20.534,   22.167,   20.787,   23.399,   19.641,   25.571,   20.302)
BSIA_LIVE<-c(19.589,   25.425,   25.658,   24.707,   24.887,   22.935,   24.025)
BSIT_DEAD<-c(21.512,   22.849,   24.069,   24.819,   24.465,   27.402,   23.272)
BSIT_LIVE<-c(23.195,   28.860,   28.400,   28.952,   30.327,   26.993,   28.969)

setEPS()
postscript("DATA1-STD-box.eps")
ddf = data.frame(NUMS = c(BSI1_DEAD,BSI1_LIVE), GRP = c(rep("DEAD", NN), rep("ALIVE", NN)))
boxplot(NUMS ~ GRP, data = ddf, lwd = 2, ylab = 'STD index in DATA1')
stripchart(NUMS ~ GRP, vertical = TRUE, data = ddf, 
    method = "jitter", add = TRUE, pch = 20, col = 'blue')
dev.off()


setEPS()
postscript("DATA01-STD-box.eps")
ddf = data.frame(NUMS = c(BSI01_DEAD,BSI01_LIVE), GRP = c(rep("DEAD", NN), rep("ALIVE", NN)))
boxplot(NUMS ~ GRP, data = ddf, lwd = 2, ylab = 'STD index in DATA01')
stripchart(NUMS ~ GRP, vertical = TRUE, data = ddf, 
    method = "jitter", add = TRUE, pch = 20, col = 'blue')
dev.off()


setEPS()
postscript("DATA00-STD-box.eps")
ddf = data.frame(NUMS = c(BSI00_DEAD,BSI00_LIVE), GRP = c(rep("DEAD", NN), rep("ALIVE", NN)))
boxplot(NUMS ~ GRP, data = ddf, lwd = 2, ylab = 'STD index in DATA00')
stripchart(NUMS ~ GRP, vertical = TRUE, data = ddf, 
    method = "jitter", add = TRUE, pch = 20, col = 'blue')
dev.off()


setEPS()
postscript("DATAT-STD-box.eps")
ddf = data.frame(NUMS = c(BSIT_DEAD,BSIT_LIVE), GRP = c(rep("DEAD", NN), rep("ALIVE", NN)))
boxplot(NUMS ~ GRP, data = ddf, lwd = 2, ylab = 'STD index in DATAT')
stripchart(NUMS ~ GRP, vertical = TRUE, data = ddf, 
    method = "jitter", add = TRUE, pch = 20, col = 'blue')
dev.off()


setEPS()
postscript("DATAT-AVD-box.eps")
ddf = data.frame(NUMS = c(BSIA_DEAD,BSIA_LIVE), GRP = c(rep("DEAD", NN), rep("ALIVE", NN)))
boxplot(NUMS ~ GRP, data = ddf, lwd = 2, ylab = 'AVD index in DATAT')
stripchart(NUMS ~ GRP, vertical = TRUE, data = ddf, 
    method = "jitter", add = TRUE, pch = 20, col = 'blue')
dev.off()
