function [ima,numberOfObject] = Q3SingleDigit(im)
%% Code to reduce noise & light
%  and convert to binary
im =rgb2gray(im);
im = imresize(im,[235 235]);
im = imbinarize(im);
im =~im;
im = imclearborder(im);
im = bwareaopen(im,60);
[labeledImage, numberOfObject] = bwlabel(im);
ima{1,1} =  convertBin2RGB(im);
ima{1,1} =  imresize(ima{1,1},[227 227]);
% outputs the image as cell array in Alexnet format
% and the number of blobs detected for Q3
end

