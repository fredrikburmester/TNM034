# TNM034-project
This is a project in the course "Advanced Image Processing" at Linköpings University. 

This aim of he project was to create a program to determain if a persons face is part of an image set. We do this using face recognition with eigen faces and PCA.

The **main.mlx** file is used for running the program and testing its accuracy. 

The folder 'inlämning' contains the final result in the course. 

## Run the code
1. To run the code, open the folder 'inlämningar' and load the data.mat file into your workspace.
2. run the function tnm034.m like so:
```
tnm034(imload('your image'))
```
and the function will return a 0 if the face in your image is not part of the data set (DB1), otherwise the function will return the id of the person it thinks the input image contains.
