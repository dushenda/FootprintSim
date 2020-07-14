function [fitresult,gof,xData, yData, zData] = fitGauss(file,path,step)
    T = readtable([path,file],'ReadVariableNames',false);
    Z = table2array(T);
    [row,col] = size(T);
    xr = ones(row,1)*step;
    xc = ones(1,col)*step;
    xr = cumsum(xr,1);
    xc = cumsum(xc,2);
    [X,Y] = meshgrid(xr,xc);
    [fitresult, gof, xData, yData, zData] = createFitGauss(X, Y, Z);
end