function I = cropnumber(im)
%Function to extract blobs from an image
 %%Sum the number of black pixels in each row
chk = sum(im,2);%1 for columns and 2 for rows
%%Check if pixels in row are ink
chk2 = chk > 0;%Non white pixels
%%Find the first ink pixel on rows 
yT = find(chk2,1,'first');%1 for first element,2 for first two elements...etc
%%Find the last ink pixel on rows
yB = find(chk2,1,'last');%1 for last element,2 for last two elements...etc
%%Sum the number of black pixels in each column
chk = sum(im,1);
%%Check if pixels in columns are ink
chk2 = chk > 0;
%%Find the first ink pixel on columns
xL = find(chk2,1,'first');
%%Find the last ink pixel on columns
xR = find(chk2,1,'last');
% Exctract blob
I = imcrop(im,[xL yT (xR-xL) (yB-yT)]);
end

