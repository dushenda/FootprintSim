function error = calError(circle_xy,point_xy)
% 输入的矩阵格式为[x坐标;y坐标]
% circle_xy为输入的圆心坐标
% point_xy为输入的探测器坐标
% 返回每个圆心点的误差

    
    dis = pdist2(point_xy',circle_xy');
    isincircle = dis<35;
    [~,circlecount] = size(dis);
    numnozero = sum(isincircle);
%     calcircle = zeros(2,cicrlecount);
    for col = 1:circlecount
        pointin = repmat(isincircle(:,col),1,2).*point_xy';
        calcircle(col,:) = sum(pointin)./repmat(numnozero(col),1,2);
    end
    err = calcircle - circle_xy';
    error = abs(err(:,1)+err(:,2)*1i);
    
%     error = zeros(1,length(circle_xy)); % 循环前预分配内存    
%      for i = 1:length(circle_xy)
%          tmp = repmat(circle_xy(:,i),1,length(point_xy));
%          delta_xy = tmp - point_xy;
%          distance = sqrt(delta_xy(1,:).^2+delta_xy(2,:).^2);
%          index = distance<=35;
%          use_point_xy = point_xy;
%          use_point_xy(:,~index)=nan;
%          cal_xy = mean(use_point_xy,2,'omitnan');
%          error(i) = sqrt((circle_xy(1,i)-cal_xy(1))^2+(circle_xy(2,i)-cal_xy(2))^2);
%      end
end