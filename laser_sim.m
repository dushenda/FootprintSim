clear;clc
E = 180;                                        % ������������
t = 0.7;                                        % ��������Ч��
D_spot = 70;                                    % ������ֱ��
R_spot = D_spot/2;                              % �����߰뾶
p_use = 0.864;                                  % ��������ռ���ܵ�������С
P_sum = E*t*p_use;                              % ���������յļ����������
P_ground_get = E*t;                             % ������յ�������
P_avg = P_sum/(pi*(D_spot/2).^2);               % �����ƽ�������ܶ�
mu = [0,0];                                     % �������ĵ�����λ��
sigma_dependent = D_spot/2.986;                 % ��������ı�׼��
sigma = [sigma_dependent,0;0,sigma_dependent];  % ��Ԫ��׼�����
x = [-R_spot:1:R_spot]';                        % ����ǰ����
y = [-R_spot:1:R_spot]';
[X,Y] = meshgrid(x,y);
In = [X(:),Y(:)];                               
z = P_ground_get*mvnpdf(In,mu,sigma);          % ������Ԫ��˹�ֲ�
p_distribute = reshape(z,length(x),length(y)); % ���ݿ��ӻ�
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