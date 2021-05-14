%Group 4, Q2- Feature extraction & KNN classification
%last modified 20/1/2021
%% Initialization
clc 
clear 
close all
%% Arrays for graph information
accuracy =  zeros(1,10);
confidence = zeros(1,10);
numbers = [0 1 2 3 4 5 6 7 8 9];
%% Read image and separate numbers
im = imread('Testinddata/41.jpg');
[ima,numberOfObject] = Read_separate(im);
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%KNN%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% k value
k = 3;
% maximum numeral to recognise
maxNum = 9;
%% Read MNIST digit DATASET
% A = readmatrix('train.csv');%big dataset(60000)
% A = readmatrix('train.csv');%small dataset(10000)
%% Read MNIST like character dataset
% A = readmatrix('A_Z Handwritten Data.csv');
%%
% fraction of images used for testing
testFrac = 0.01;
% get list of image file names
names = dir('imageData\0\*.png');
% total number of images for each class
NClass = length(names);%change names for A for MNIST
% number of training and testing images
NTest = round(NClass*testFrac);
NTrain = NClass - NTest;
% initialise vectors that will contain metrics 
[H1,H2,H3,H4,H5,H6,H7]=deal( nan(NClass*(maxNum+1),1));
% initialise vector to contain true class for each image
C = H1;
% indicate which images are for test only
testOnly = false(size(H1));
%% Construct Hu database
ind = 0;
for num = 0:maxNum % for each class
    % get path for images in current class (numeral)
    pathToIms = fullfile('imageData',num2str(num));
    % get list of image filenames for current class
    imFilenames = dir(fullfile(pathToIms,'*.png'));
    for imNo = 1:NClass % for each image of current class
        ind = ind + 1;
        % read next image
        im = imread(fullfile(pathToIms,imFilenames(imNo).name));
        H = Hmoments(im);
        % calculate Hu moments
        H1(ind) = H(1);
        H2(ind) = H(2);
        H3(ind) = H(3);
        H4(ind) = H(4);
        H5(ind) = H(5);
        H6(ind) = H(6);
        H7(ind) = H(7);
        % store corresponding class
        C(ind) = num;
        if imNo > NTrain
            testOnly(ind) = true;
        end
    end
end
%% MNIST DATASET
% AB = A(:,2:785);
% for imNo = 1:length(AB) % for each image of current class
%         ind = ind + 1;
%         % read next image
%         im = reshape(AB(imNo,:),28,28);
%         im = imrotate(im,-90);
%         im = flip(im ,2);
%         im = imbinarize(im);
%         im = imresize(im,[235 235]);
%         H = Hmoments(im);
%         % calculate ratio feature
%         H1(ind) = H(1);
%         H2(ind) = H(2);
%         H3(ind) = H(3);
%         H4(ind) = H(4);
%         H5(ind) = H(5);
%         H6(ind) = H(6);
%         H7(ind) = H(7);
%         % store corresponding class
%         C(ind) = A(imNo,1);
% %%%%%%%%%%Switch case for character recognition
% %%%%%%%%%%Coment out if using MNIST for digits
% %           switch C(ind)
% %               case 0
% %                   C(ind) = 'A';
% %               case 1
% %                   C(ind) = 'B';
% %               case 2
% %                   C(ind) = 'C';
% %               case 3
% %                   C(ind) = 'D';
% %               case 4
% %                   C(ind) = 'E';
% %               case 5
% %                   C(ind) = 'F';
% %               case 6
% %                   C(ind) = 'G';
% %               case 7
% %                   C(ind) = 'H';
% %               case 8
% %                   C(ind) = 'I';
% %               case 9
% %                   C(ind) = 'J';
% %               case 10
% %                   C(ind) = 'K';
% %               case 11
% %                   C(ind) = 'L';
% %               case 12
% %                   C(ind) = 'M';
% %               case 13
% %                   C(ind) = 'N';
% %               case 14
% %                   C(ind) = 'O';
% %               case 15
% %                   C(ind) = 'P';
% %               case 16
% %                   C(ind) = 'Q';
% %               case 17
% %                   C(ind) = 'R';
% %               case 18
% %                   C(ind) = 'S';
% %               case 19
% %                   C(ind) = 'T';
% %               case 20
% %                   C(ind) = 'U';
% %               case 21
% %                   C(ind) = 'V';
% %               case 22
% %                   C(ind) = 'W';
% %               case 23
% %                   C(ind) = 'X';
% %               case 24
% %                   C(ind) = 'Y';
% %               case 25
% %                   C(ind) = 'Z';
% %           end
% %%%%%%%%%%%%
%         if imNo > NTrain
%             testOnly(ind) = true;
%         end
% end
%% Construct KNN model
% construct a single matrix containing all metrics for training
allMetricsTrain = [H1(C<=maxNum & ~testOnly) H2(C<=maxNum & ~testOnly) H3(C<=maxNum & ~testOnly) H4(C<=maxNum & ~testOnly) H5(C<=maxNum & ~testOnly) H6(C<=maxNum & ~testOnly) H7(C<=maxNum & ~testOnly)];
% construct a single matrix containing all metrics for testing
allMetricsTest = [H1(C<=maxNum & testOnly) H2(C<=maxNum & testOnly) H3(C<=maxNum & testOnly) H4(C<=maxNum & testOnly) H5(C<=maxNum & testOnly) H6(C<=maxNum & testOnly) H7(C<=maxNum & testOnly)];
% vector showing correct class for each image in test dataset
classTest = C(C<=maxNum & testOnly);
classTrain = C(C<=maxNum & ~testOnly);
% use built in function to build Kd-tree
kdTreeModel = KDTreeSearcher(allMetricsTrain);
%% Perform classification for each number & create confidence graph
result = classKNN(ima,classTrain,kdTreeModel,numberOfObject,k,numbers,confidence);

