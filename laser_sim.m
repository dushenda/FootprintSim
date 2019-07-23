clear;clc
E = 180;                                        % 激光脉冲能量
t = 0.7;                                        % 大气传输效率
D_spot = 70;                                    % 激光光斑直径
R_spot = D_spot/2;                              % 激光光斑半径
p_use = 0.864;                                  % 激光光斑所占的总的能量大小
P_sum = E*t*p_use;                              % 传感器接收的激光的总能量
P_ground_get = E*t;                             % 地面接收的总能量
P_avg = P_sum/(pi*(D_spot/2).^2);               % 激光的平均能量密度
mu = [0,0];                                     % 激光中心点所在位置
sigma_dependent = D_spot/2.986;                 % 计算独立的标准差
sigma = [sigma_dependent,0;0,sigma_dependent];  % 二元标准差矩阵
x = [-R_spot:1:R_spot]';                        % 数据前处理
y = [-R_spot:1:R_spot]';
[X,Y] = meshgrid(x,y);
In = [X(:),Y(:)];                               
z = P_ground_get*mvnpdf(In,mu,sigma);          % 独立二元高斯分布
p_distribute = reshape(z,length(x),length(y)); % 数据可视化
density_distribute = exp(-2*(X.^2+Y.^2)/D_spot^2);
subplot(2,2,1);
mesh(X,Y,p_distribute);colormap('jet');colorbar;
xlabel('x direction/m');ylabel('y direction/m');zlabel('Power/mJ');title('Power Distribute');
subplot(2,2,2);
contourf(X,Y,p_distribute);colorbar;axis equal;
xlabel('x direction/m');ylabel('y direction/m');zlabel('Power/mJ');title('Power Distribute');
subplot(2,2,3);
mesh(X,Y,density_distribute);colorbar;
xlabel('x direction/m');ylabel('y direction/m');zlabel('Power Density');title('Gassian tansverse intensity profile');
subplot(2,2,4);
contourf(X,Y,density_distribute);colorbar;axis equal;
xlabel('x direction/m');ylabel('y direction/m');zlabel('Power Density');title('Gassian tansverse intensity profile');