function [RGB_Image] = convertBin2RGB(BinImage)
%Function to convert binary image to RGB
[fil, col] = size(BinImage);
RGB_Image = zeros(fil,col, 3);%create empty image
[posX , posY] = find(BinImage==1);
numIter = size(posX,1)*size(posX,2);
for ii = 1 : numIter
      RGB_Image(posX(ii),posY(ii), 1:3) = 255;% add binary layers to empty image
end
end