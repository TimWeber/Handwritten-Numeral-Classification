% plot 1D feature vectors for given number of images
function plotFeatures(R,C,maxNum,testOnly)

if nargin == 4
    % do not reserve any for testing if testOnly not specified
    testOnly = false(size(R));
end

hold on
% extract and plot points for class 0
r = R(C==0 & ~testOnly);
plot(r,'b<');
% repeat for class 1
r = R(C==1 & ~testOnly);
plot(r,'r+');
% repeat for other classes as necessary

r = R(C==2 & ~testOnly);
plot(r,'g*');

r = R(C==3 & ~testOnly);
    plot(r,'m.');

r = R(C==4 & ~testOnly);
plot(r,'rh');
r = R(C==5 & ~testOnly);
plot(r,'cp');
r = R(C==6 & ~testOnly);
plot(r,'ys');
r = R(C==7 & ~testOnly);
plot(r,'kd');
r = R(C==8 & ~testOnly);
plot(r,'c^');
r = R(C==9 & ~testOnly);
plot(r,'bv');
xlabel('HU Moment 1');