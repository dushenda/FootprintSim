% clear;clc
z = table2array(m8);
gap = [3,4.5,8];
x = 1:size(z,2);y=1:size(z,1);
x = x*gap(3);y=y*gap(3);
[X,Y] = meshgrid(x,y);
% surf(X,Y,z);
% xlabel('x');ylabel('y');
% ÖØÐÄ·¨
totalE = sum(z);
cal_x = sum(X.*z)/totalE;
cal_y = sum(Y.*z)/totalE;
[fitresult, zfit, fiterr, zerr, resnorm, rr] = fmgaussfit(X,Y,z);

%%
po81 = [cal_x,cal_y];
po82 = [fitresult(5),fitresult(6)];
po83 = [3,4]*8;
dis8 = pdist([po81;po82],'euclidean');%1.1959
dis82 = pdist([po81;po83],'euclidean');%1.1286

po451 = [cal_x,cal_y];
po452 = [fitresult(5),fitresult(6)];
po453 = [4,3]*4.5;
dis45 = pdist([po451;po452],'euclidean');%3.2633
dis452 = pdist([po451;po453],'euclidean');%1.6585

po31 = [cal_x,cal_y];
po32 = [fitresult(5),fitresult(6)];
po33 = [7,5]*3;
dis3 = pdist([po31;po32],'euclidean');%0.0322
dis32 = pdist([po31;po33],'euclidean');%0.8473