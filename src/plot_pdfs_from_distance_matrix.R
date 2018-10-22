plot_pdfs_from_distance_matrix<-function(mat,index1,lim=c(0.05,0.18),alpha=0.5,filename="/home/jonhall/Desktop/pdf_dist.eps",filetype="eps"){
# function for plotting distances of within and between source distributions
# mat is a distance matrix
# index1 points out within source samples in matrix mat for the first group (only two groups allowed)

require(ggplot2)
nr<-nrow(mat)
ntot<-(nr-1)*nr/2
index.tot<-seq(1,nr)
index2<-setdiff(index.tot,index1)

df<-data.frame(rep(0,ntot))
colnames(df)<-"sample_i"
df$sample_j<-rep(0,ntot)
df$Type<-"between"
df$Value<-rep(0,ntot)
k<-1
nr1<-nr-1
for(i in 1:nr1){
  i1<-i+1
  for(j in i1:nr){
    if((i %in% index1 && j %in% index1) || (i %in% index2 && j %in% index2)){
      df[k,1]<-i
      df[k,2]<-j
      df[k,3]<-"within"
      df[k,4]<-mat[i,j]
    }
    else{
      df[k,1]<-i
      df[k,2]<-j
      df[k,4]<-mat[i,j]
    }
    k<-k+1
  }
}

df2<-df[,3:4]
if(is.null(filename)==FALSE){
  if(filetype=="eps"){
    postscript(filename)
  }
  else{
    pdf(filename)
  }
}
ggplot(df2,aes(x=Value, fill=Type)) + geom_density(alpha=alpha) +scale_x_continuous(limits = lim)
if(is.null(filename)==FALSE){
  dev.off()
}
  return(df)

}
