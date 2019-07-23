function error = calError(circle_xy,point_xy)
% ����ľ����ʽΪ[x����;y����]
% circle_xyΪ�����Բ������
% point_xyΪ�����̽��������
% ����ÿ��Բ�ĵ�����
    error = zeros(1,length(circle_xy)); % ѭ��ǰԤ�����ڴ�
     for i = 1:length(circle_xy)
         tmp = repmat(circle_xy(:,i),1,length(point_xy));
         delta_xy = tmp - point_xy;
         distance = sqrt(delta_xy(1,:).^2+delta_xy(2,:).^2);
         index = distance<=35;
         use_point_xy = point_xy;
         use_point_xy(:,~index)=nan;
         cal_xy = mean(use_point_xy,2,'omitnan');
         error(i) = sqrt((circle_xy(1,i)-cal_xy(1))^2+(circle_xy(2,i)-cal_xy(2))^2);
     end
end