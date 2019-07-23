% test20
clear;clc
delta = 20;
detectorx = 0:delta:500+delta;detectory = -35:delta:500+delta;
[X,Y] = meshgrid(detectorx,detectory);
dectorxy = [reshape(X,numel(X),1),reshape(Y,numel(Y),1)];
for b=0:1:delta
    for m=0:1:15
        for s1=0:1:delta
            start1_l = 35+s1;start1_y = b;
            start2_l = 205+s1;start2_y = b;
            start3_l = 375+s1;start3_y = b;
            
            current1_x = start1_l*cos(m*pi/180);
            current1_y = start1_y+start1_l*sin(m*pi/180);
            current2_x = start2_l*cos(m*pi/180);
            current2_y = start2_y+start2_l*sin(m*pi/180);
            current3_x = start3_l*cos(m*pi/180);
            current3_y = start3_y+start3_l*sin(m*pi/180);
            
            dis1 = pdist2(dectorxy,[current1_x,current1_y]);
            dis1 = mean(dectorxy(dis1<35,:));
            error1 = norm(dis1-[current1_x,current1_y]);
            dis2 = pdist2(dectorxy,[current2_x,current2_y]);
            dis2 = mean(dectorxy(dis2<=35,:));
            error2 = norm(dis2-[current2_x,current2_y]);
            dis3 = pdist2(dectorxy,[current3_x,current3_y]);
            dis3 = mean(dectorxy(dis3<35,:));
            error3 = norm(dis3-[current3_x,current3_y]);
            error(b+1,m+1,s1+1) = mean([error1,error2,error3]);
            std_all(b+1,m+1,s1+1) = std([error1,error2,error3]);
        end
    end
end
TMO = mean(error,'all');
TMSD = mean(std_all,'all');