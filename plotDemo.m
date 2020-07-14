x = 1:10;y=x;
[X,Y] = meshgrid(x,y);
scatter(X(:),Y(:),'k.');
xlim([x(1)-1 x(end)+1]);ylim([y(1)-1 y(end)+1]);
circle_center = [5.5,5.9];circle_radium = 1.8;
viscircles(circle_center,circle_radium);
hold on;
plot(circle_center(1),circle_center(2),'*r');
active_dx = [];active_dy = [];
for ix=x
    if (ix>circle_center(1)-circle_radium)&&(ix<circle_center(1)+circle_radium)
        for iy=y
            if (iy>circle_center(2)-circle_radium)&&(iy<circle_center(2)+circle_radium)
                if( ((ix-circle_center(1))^2 + (iy-circle_center(2))^2) < circle_radium^2 ) 
                    active_dx = [active_dx;ix];
                    active_dy = [active_dy;iy];
                end
            end
        end
    end
end
plot(active_dx,active_dy,'m.');
cal_x = mean(active_dx);cal_y = mean(active_dy);
scatter(cal_x,cal_y,'*b');
legend('dector','real laser center','active dector','calculate laser center');
axis equal;
print('demo','-dpng','-r0')