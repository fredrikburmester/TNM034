# TNM034-project
This is a project in the course "Advanced Image Processing" at Linköpings University. 

This aim of the project was to create a program to determain if a persons face is part of an image set. We do this using face recognition with eigen faces and PCA.

The **main.mlx** file is used for running the program and testing its accuracy. 

The folder `./inlämning` contains the final result in the course. 

## Run the code
1. To run the code, open the folder 'inlämningar'
2. Load the data.mat file into workspace or let the program build all the nessesary variables and matricies. 
3. Run the function tnm034.m like so:
```
tnm034(imload('path to image'))
```
The function will return a 0 if the face in your image is not part of the data set (DB1), otherwise the function will return the id of the person it thinks the input image contains.

## Additional information
### Underlying therory
For more information regarding the underlying theory and math behind the program, please read the report in the folder `./inlämning`. The report is in Swedish. 

### Contributors
- Linus Hjeltman
- Olivia Enroth
- Fredrik Burmester
