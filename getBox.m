function [top,bottom,left,right] = getBox(im)

%% find left and right edge
chkSum = sum(im,1); % sum of number of ink pixels for each row
chkFlag = chkSum > 0; % flag to show if any pixels in a given row are ink

left = find(chkFlag,1,'first');
right = find(chkFlag,1,'last');


%% find top and bottom edge
chkSum = sum(im,2); % sum of number of ink pixels for each row
chkFlag = chkSum > 0; % flag to show if any pixels in a given row are ink

top = find(chkFlag,1,'first');
bottom = find(chkFlag,1,'last');

