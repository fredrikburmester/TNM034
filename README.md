# TNM034-project
Face detection project in the course "Advanced Image Processing" at Linköpings University. 

This aim of the project was to create a program to determain if a persons face is part of an image set. We do this using face recognition with eigen faces and PCA.

The programming language MATLAB was used to complete this project.

The **main.mlx** file is used for running the program and testing its accuracy. 

The folder `./inlämning` contains the final result in the course. 

## Run the code
1. Clone this repository and open the files in MATLAB.
2. Load the data.mat file from `./inlämning` into workspace (or let the program build all the nessesary variables and matricies, but the folder `./DB1` needs to be on path). 
3. Run the function TNM034.m like so:
```
TNM034(imload('path to image')) 
```
The function will return a 0 if the face in your image is not part of the data set (DB1), otherwise the function will return the id of the person it thinks the input image contains.

## Additional information
## Accuracy and tests
This program is not very accurate on images where the face is a small part of the image. This program works for portraits. 

The program is supposed to work on images that are rotated +/-5 degrees, brightened +/-30% or scaled +/-10%, or all of them combined. 

The accuracy was 91.47% when testing DB1 on it self with all the variations above.

### Underlying therory
For more information regarding the underlying theory and math behind the program, please read the report in the folder `./inlämning`. The report is in Swedish. 

### Contributors
- Linus Hjeltman
- Olivia Enroth
- Fredrik Burmester
