# Numeral-Classification
Classification of Handwritten Numerals Through the Exploration of a k-Nearest Neighbours Classifier and a Supervised Learning Convolutional Neural Network.

Using a test image of the number 21:

The algorithm first converts the image to binary before using morphological operations to process the image.
![21k3-7mo](README-images/21k3-7mo.jpg)

Then it is possible to identify and separate multiple digits within a number. 

![21separated](README-images/21separated.jpg)

The digits can now be classified

![confidence21-k3-7mo](README-images/confidence21-k3-7mo.jpg)


# How to use:

Run Script Q1.m. This includes the code for question 1:
This script will train the KNN and generate and accuracy graph for each increase of maxNum, based on its k value and 7 HU
moments. It will also make a random prediction of a number when maxNum = 9 and display its confidence graph.

Run Script Q2.m. This includes the code for question 2:
The code as is, will feed a number test image & separate each of its digits,train the KNN and then make a prediction. Still,
it has been designed so once the KNN is trained new images can be classified with use of the command window in 3 simple
steps:

1- Use im = imread('name of your image'); on the comand window

2 - If single digit number, call [ima,numberOfObject] = singleDigit(im); on the comand window.
    If 2 or more digits, or if digits are touching, call [ima,numberOfObject] = Read_separate(im); on the comand window.

3- Finally call result = classKNN(ima,classTrain,kdTreeModel,numberOfObject,k,numbers,confidence); for classification.

An example :
im = imread('Testinddata/21.jpg');
[ima,numberOfObject] = Read_separate(im);
result = classKNN(ima,classTrain,kdTreeModel,numberOfObject,k,numbers,confidence);

Copying and pasting the above on to the command window once KNN is trained will give a prediction of 21.

Script Q3.m includes the code for question 3:
The code as is, will feed a number test image & separate each of its digits,train Alexnet and then make a prediction. Still,
it has been designed so once Alexnet is trained new images can be classified with use of the command window in 3 simple
steps:
1- Use im = imread('name of your image'); on the comand window

2 - If single digit number, call [ima,numberOfObject] = Q3SingleDigit(im); on the comand window.
    If 2 or more digits, or if digits are touching, call [ima,numberOfObject] = Q3Read_separate(im); on the comand window.

3 - Finally call result = Q3Prediction(numberOfObject,charNet,imsTest,ima); for classification.

An example:
im = imread('testinddata/0190.jpg');
[ima,numberOfObject] = Q3Read_separate(im);
result = Q3Prediction(numberOfObject,charNet,imsTest,ima);

Copying and pasting the above on to the command window once alexnet is trained will give a prediction of 190.

**Important notes:
All above functions and others that have been used thorughout the project are included in the file as function scripts.
Other sripts added, such as the converter script, dont answer any questions of the assignments but as it was used,
it was included. Functionality is described in comments.
Finally, some images are rotated wrongly when read from matlab.If the test image is wrongly rotated go to the function 
scripts [ima,numberOfObject] = Read_separate(im); or [ima,numberOfObject] = Q3Read_separate(im);, depending on wich one 
you are using, and change the parameters for imrotate(normaly one of both -90 or 90).
