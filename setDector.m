function dectorxy = setDector(x_min,x_max,y_min,y_max,delta)
% x_min：x方向的最小值
% x_max：x方向的最大值
% y_min：y方向的最小值
% y_max：y方向的最大值
% delta：探测器之间的水平及其垂直间距
    x = x_min:delta:x_max;
    y = y_min:delta:y_max;
    [X,Y] = meshgrid(x,y);
    dectorxy = [X(:),Y(:)]';
end