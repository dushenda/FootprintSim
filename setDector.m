function dectorxy = setDector(x_min,x_max,y_min,y_max,delta)
% x_min��x�������Сֵ
% x_max��x��������ֵ
% y_min��y�������Сֵ
% y_max��y��������ֵ
% delta��̽����֮���ˮƽ���䴹ֱ���
    x = x_min:delta:x_max;
    y = y_min:delta:y_max;
    [X,Y] = meshgrid(x,y);
    dectorxy = [X(:),Y(:)]';
end