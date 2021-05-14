function [HU]= Hmoments(I)
% Function to calculate Hu moments & store in 1*7 array
M00 = sum(I(:));
%% first order moments
[x,y] = meshgrid(1:size(I,2),1:size(I,1));
M10 = x.*I;
M10 = sum(M10(:));
xBar = M10/M00;
M01 = y.*I;
M01 = sum(M01(:));
yBar = M01/M00;
%% second order
% central moments
mu20 = I.*(x-xBar).^2;
mu20 = sum(mu20(:));
mu02 = I.*(y-yBar).^2;
mu02 = sum(mu02(:));
mu11 = I.*(x-xBar).*(y-yBar);
mu11 = sum(mu11(:));
mu21 = I.*((x-xBar).^2).*(y-yBar);
mu21 = sum(mu21(:));
mu12 = I.*(x-xBar).*((y-yBar).^2);
mu12 =  sum(mu12(:));
mu30 = I.*(x-xBar).^3;
mu30 =  sum(mu30(:));
mu03 = I.*(y-yBar).^3;
mu03 =  sum(mu03(:));
%% Normalised central moments, scale invariants
nu20 = mu20/(M00.^2);
nu02 = mu02/(M00.^2);
nu11 = mu11/(M00.^2);
nu21 = mu21/(M00.^(1+3/2));
nu12 = mu12/(M00.^(1+3/2));
nu30 = mu30/(M00.^(1+3/2));
nu03 = mu03/(M00.^(1+3/2));
%% Hu moments
HU = zeros(1,7);
H1 = nu20+nu02;
H2 = ((nu20-nu02)^2)+4*(nu11^2);
H3 = ((nu30-3*nu12).^2)+((3*nu21-nu03).^2);
H4 = ((nu30+nu12).^2)+((nu21+nu03).^2);
H5 = (nu30-3*nu12).*(nu30+nu12).*[((nu30+nu12).^2)-3.*((nu21+nu03).^2)]+(3*nu21-nu03).*(nu21+nu03).*[3.*((nu30+nu12).^2)-((nu21+nu03).^2)];
H6 = (nu20-nu02).*[((nu30+nu12).^2)-((nu21+nu03).^2)]+4.*nu11.*(nu30+nu12).*(nu21+nu03);
H7 = (3*nu21-nu03).*(nu30+nu12).*[((nu30+nu12).^2)-3.*((nu21+nu03).^2)]-(nu30-3*nu12).*(nu21+nu03).*[3.*((nu30+nu12).^2)-((nu21+nu03).^2)];
%% Use log transform equation to convert to same range
HU(1) = -sign(H1).*(log10(abs(H1)));
HU(2) = -sign(H2).*(log10(abs(H2)));
HU(3) = -sign(H3).*(log10(abs(H3)));
HU(4) = -sign(H4).*(log10(abs(H4)));
HU(5) = -sign(H5).*(log10(abs(H5)));
HU(6) = -sign(H6).*(log10(abs(H6)));
HU(7) = -sign(H7).*(log10(abs(H7)));
end