function [TMO,TMSD] = calMean(c1,c2,c3,dectorxy,radium)
% ��������Բ���������c1,c2,c3
% ����̽�����ĵ������dectorxy
    error1 = calError(c1,dectorxy,radium);
    error2 = calError(c2,dectorxy,radium);
    error3 = calError(c3,dectorxy,radium);
    MEAN_jkn = (error1+error2+error3)/3;
    TMO = mean(MEAN_jkn);
    TMSD = mean(sqrt(((error1-MEAN_jkn).^2+(error2-MEAN_jkn).^2+(error3-MEAN_jkn).^2)/3));
end