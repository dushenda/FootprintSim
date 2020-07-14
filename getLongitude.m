function [PositionLonStr,PositionLonNum] = getLongitude(LongitudeStr)
% 得到经度信息，10404.00096E东经104°4′0.096″
NumStr = LongitudeStr(1:end-1);
Num = str2double(NumStr);
NumDeg = fix(Num/100);
NumMin = fix(Num-NumDeg*100);
NumSec = (Num - floor(Num))*100;
LocStr = LongitudeStr(end);
if(LocStr == 'E')
    Loc = '东经';
elseif(LocStr == 'W')
    Loc = '西经';
else
    disp('not in Earth');
end
PositionLonStr = strcat(Loc,num2str(NumDeg),'°',num2str(NumMin),...
    '''',num2str(NumSec),'''''');
PositionLonNum = NumDeg+NumMin/60+NumSec/3600;
end