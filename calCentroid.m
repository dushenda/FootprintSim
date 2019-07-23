function centroidxy = calCentroid(delta,radium,slope,distance,index)
% delta：探测器间距
% radium：激光光斑半径
% slope：旋转角度取值
% distance：两个圆质心之间的距离
% index：光斑索引
    % 计算圆心所有的可能运动
    index = index-1;          % 下标从0开始
    N_s1 = delta+1;           % x方向的移动
    N_b = delta+1;            % y方向的移动
    N_m = length(slope);      % 角度的旋转
    % 三个光斑圆心出现位置确定
    % 扩展顺序是x移动→逆时针旋转→y方向的平移
    l_s1 = radium+index*distance:1:radium+index*distance+delta;% x方向移动
    l_m = repmat(l_s1,1,N_m);  % 逆时针旋转
    l_b = repmat(l_m,1,N_b);   % y方向平移
    l_all = l_b;               % 最后的x坐标全体
    y_b = -delta:1:0; 
    y_s1_b = repmat(y_b,N_s1*N_m,1);
    y_all_before = reshape(y_s1_b,1,N_s1*N_b*N_m);
    % 扩展顺序是逆时针旋转→x移动→y方向的平移
    y_slope_m = sin(slope*pi/180);
    x_slope_m = cos(slope*pi/180);
    y_slope_s1 = repmat(y_slope_m,N_s1,1);
    x_slope_s1 = repmat(x_slope_m,N_s1,1);
    y_slope_s1 = reshape(y_slope_s1,1,N_m*N_s1);
    x_slope_s1 = reshape(x_slope_s1,1,N_m*N_s1);
    y_slope_b = repmat(y_slope_s1,1,N_b);
    x_slope_b = repmat(x_slope_s1,1,N_b);
    y_slope_all = y_slope_b;
    x_slope_all = x_slope_b;
    % 计算y方向的位移
    y_gap = l_all.*y_slope_all;
    y_real = y_all_before+y_gap;
    x_real = l_all.*x_slope_all;
    centroidxy = [x_real;y_real];
end