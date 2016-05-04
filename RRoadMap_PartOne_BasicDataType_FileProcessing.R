# 4/13/2016
# This script will demonstrate the following topics:
# 1. Basic Data Types of R
# 2. File Processing and data retrieving


# ***** PART ONE: Basic Data Types *****
# There are five basic data types that we will use to put into containers
# such as vector, list and DataFrames
# character, numeric, integer, complex and logical

# *** 1.1 Usage of Vector ***
# Vector will have to contain elements of same class
# 1.1.1 Creation of Vectors
x<-c(0.5,0.6)
# <1> what if not same class, will use least denominator
x1<-c(1.7,"a")  # character
class(x1)
x2<-c(TRUE,2)   # numeric
class(x2)
x3<-c("a",TRUE) # character
class(x3)
# <2> We can also use explicit coercion
x4<-6.7
x4<-as.logical(x4)
x5<-"Haha"
x5<-as.numeric(x5) # This will give us NA, so *** In R, character is of lower level? ***
x6<-7.8
x6<-as.character(x6)

# *** 1.2 Usage of List ***
# Difference between vector and list is that 
# <1> list will allow different types of elements
# <2> List is indexed by [[]] while vector is indexed by []
y <-list(1,2.3,"a",TRUE,3+4i)  # call y and you will see how it is stored


# *** 1.3 Matrices as an extension of Vector ***
# 1.3.1 Creation of Matrix
# 1.3.1.1 use the matrix function
m<-matrix(nrow=2,ncol=3) # this will default to NAs
m<-matrix(1:6,nrow=2,ncol=3)
# 1.3.1.2 use dim function on a vector
m<-1:10
dim(m)<-c(2,5)
# 1.3.1.3 Col and Row binding
v1<-1:9
v2<-12:20
cbind(v1,v2)
rbind(v1,v2)
# 1.3.2 Get Matrix attribites
dim(m)
attributes(m)


# *** 1.4 Factor as Integer vector with labels ***
# Intger with labels, treated specially by modeling functions like lm() and glm()
# 1.4.1 Creation of factors
f<-factor(c("San Francisco","Palo Alto","San Jose"))
# 1.4.2 Retieving Properties
attr(f,"levels")
table(f)
unclass(f)   # Unclass will show that under the hood, it is stored as integers


# *** 1.5 VERY IMPORTANT:DataFrame as special type of list ***
# 1.5.1 Creation
# read.table() and read.csv() Pay attention to the back slash
wine_data=read.table("E:/RWorkingDirectory/SampleFiles/winequality-red.csv",header=TRUE,sep=";`")
# 1.5.2 Retrieving
# Retrieve a row
wine_data[1,]
# Retrieve a column
wine_data[,2]
# 1.5.3 *** READING LARGE DATASET *** Example
# <1> : Do a raw RAM calculation
# <2> : set comment.char = "" if there is no comment line
# <3> : Set column classes will accelerate the reading process significantly
# So there is a quick and dirty way to do this
# Step 1: Read first 100 lines 
# step 2: determine the column class type based on the first 200 rows
# step 3: read the full data set specifying the colClasses
wine_ini<-read.table("E:/RWorkingDirectory/SampleFiles/winequality-red.csv",header=TRUE,nrows=300,sep=";")
wine_classes<-sapply(wine_ini,class)
full_winedata<-read.table("E:/RWorkingDirectory/SampleFiles/winequality-red.csv",header=TRUE,colClasses=wine_classes,sep=";")
# *** Notice that you might have scan error in this case, should you change the colClass by
# yourself or just change nrows=500? It might not be convenient to change manually since 
# it might be hard to tell which column is wrong ***
# you might just do the following
wine_classes[wine_classes=="integer"]<-"numeric"


# *** 1.6 Names *** 
# 1.6.1 Assign names to a vector
x<-1:3
names(x)<-c("Los Angeles","San Francisco","Palo Alto")
# 1.6.2 Assign names to a matrix
m<-matrix(1:6,nrow=2,ncol=3)
dimnames(m)<-list(c("a","b"),c("c","d","e")) # first argument is rowname, second argument is column name


# ***** PART TWO: Subsetting *****
# 2.1 Three Principals for Subsetting
# <1>. [] for subsetting vector. 
x<-1:6
x[1:3]

# <2>. [[]] is used to extract from list or dataframe
full_winedata[1,]   # will give you the first row
full_winedata[[1]]  # will give you the first column
# Judging from above command, we can tell that dataframe can be regarded as a list, 
# each element is a column			  	

# <3>. $ to extract elements of list or dataframes by name
# So by the same logic, we should call the column name using this $
full_winedata$quality

# 2.2 Subsetting a Matrix
m<-matrix(1:6,2,3)
# We can subset use the following two identical ways
m[1,2]
m[[2,1]] 
m[1,drop=FALSE]


# 2.3 Subsetting a list
# 2.3.1 List of single element
l<-list("San Francisco",187,"Kobe",NaN,TRUE)
# The following two will have the same result
l[[1]]
l[1]
#1.3.2 List of multiple element
l1<-list(a=list(10,12,14),b=c(3.14,2.81))
# This is similar to subsetting a matrix
l1[[c(1,3)]]  # will give you 14
l1[[1]][[3]]  # will also give you 14
l1[[c(2,1)]]  # will give you 3.14


# 2.4 Vectorized Operations: we use vectorized operations to avoid loop
# You should already be very familiar with this.
# for example, removing NaN 
x<-c(1.2,NaN,4.5,NaN)
bad<-is.na(x)
x<-x[!bad] 






