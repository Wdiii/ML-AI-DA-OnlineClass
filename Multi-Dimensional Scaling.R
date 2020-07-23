library(stats)

#Obtain data and convert to matrix format
data(eurodist)
eurodist <- as.matrix(eurodist)

#Use cmdscale to convert the matrix into a classical multidimensional scale
#k:number of dimensions
#eig:logical input indicating whether eigen values should be returned
mds <- cmdscale(eurodist, k = 2, eig = FALSE)

#Flip the y axis to represent the relative positioning of the points 
x <- mds[,1]
y <- mds[,2]
#y <- 0-mds[,2]

#Plot the reduced coordinates to get the spatial map 
#pch:type of plot
#xlim:set The limits of the x
plot(x, y, pch = 19, xlim = range(x) + c(0, 600))
#pos:this value controls the distance ('offset') of the text label 
#from the specified coordinate in fractions of a character width
text(x, y, pos = 4, labels = colnames(eurodist))
