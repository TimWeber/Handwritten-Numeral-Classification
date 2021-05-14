% plot 2D feature vectors for given number of images
function plotFeatures(R,W,C,maxNum,testOnly)

if nargin == 4
    % do not reserve any for testing if testOnly not specified
    testOnly = false(size(R));
end

hold on
% extract and plot points for class 0
r = R(C==0 & ~testOnly);
w = W(C==0 & ~testOnly);
plot(r,w,'b<');
% repeat for class 1
r = R(C==1 & ~testOnly);
w = W(C==1 & ~testOnly);
plot(r,w,'r+');
% repeat for other classes as necessary

r = R(C==2 & ~testOnly);
w = W(C==2 & ~testOnly);
plot(r,w,'g*');

r = R(C==3 & ~testOnly);
w = W(C==3 & ~testOnly);
    plot(r,w,'m.');

r = R(C==4 & ~testOnly);
w = W(C==4 & ~testOnly);
plot(r,w,'rh');
r = R(C==5 & ~testOnly);
w = W(C==5 & ~testOnly);
plot(r,w,'cp');
r = R(C==6 & ~testOnly);
w = W(C==6 & ~testOnly);
plot(r,w,'ys');
r = R(C==7 & ~testOnly);
w = W(C==7 & ~testOnly);
plot(r,w,'kd');
r = R(C==8 & ~testOnly);
w = W(C==8 & ~testOnly);
plot(r,w,'c^');
r = R(C==9 & ~testOnly);
w = W(C==9 & ~testOnly);
plot(r,w,'bv');
xlabel('HU Moment 1');
ylabel('HU Moment 2')