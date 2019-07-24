% test20
clear;clc
tic
delta = 20;
detectorx = 0:delta:500+delta;detectory = -40:delta:420+delta;
[X,Y] = meshgrid(detectorx,detectory);
detectorxy = [reshape(X,numel(X),1),reshape(Y,numel(Y),1)];
for b=0:1:delta
    for m=0:1:30
        for s1=35:1:delta+35
            start1_l = s1;start1_y = b;
            start2_l = s1+170;start2_y = b;
            start3_l = s1+170*2;start3_y = b;
            
            current1_x = start1_l*cos(m*pi/180);
            current1_y = start1_y+start1_l*sin(m*pi/180);
            current2_x = start2_l*cos(m*pi/180);
            current2_y = start2_y+start2_l*sin(m*pi/180);
            current3_x = start3_l*cos(m*pi/180);
            current3_y = start3_y+start3_l*sin(m*pi/180);
            
            dis1 = pdist2(detectorxy,[current1_x,current1_y]);
            dis1 = mean(detectorxy(dis1<35,:));
            error1 = norm(dis1-[current1_x,current1_y]);
            dis2 = pdist2(detectorxy,[current2_x,current2_y]);
            dis2 = mean(detectorxy(dis2<=35,:));
            error2 = norm(dis2-[current2_x,current2_y]);
            dis3 = pdist2(detectorxy,[current3_x,current3_y]);
            dis3 = mean(detectorxy(dis3<35,:));
            error3 = norm(dis3-[current3_x,current3_y]);
            error(b+1,m+1,s1-35+1) = mean([error1,error2,error3]);
            std_all(b+1,m+1,s1-35+1) = std([error1,error2,error3]);
        end
    end
end
TMO = mean(error,'all');
TMSD = mean(std_all,'all');
toc