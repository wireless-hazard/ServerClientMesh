close all
clear
clc

r1 = 8;
r2 = 8;
r3 = 14;

theta = linspace(0,2*pi,360);

d1 = [5 10];
d2 = [5 -4.9];
d3 = [20 -5];

x = r1*cos(theta)+d1(1);
y = r1*sin(theta)+d1(2);
scatter(d1(1),d1(2),'r')
hold on
plot(x,y,'b')

x = r2*cos(theta)+d2(1);
y = r2*sin(theta)+d2(2);
scatter(d2(1),d2(2),'r')
plot(x,y,'b')

x = r3*cos(theta)+d3(1);
y = r3*sin(theta)+d3(2);
scatter(d3(1),d3(2),'r')
plot(x,y,'b')

x = -10:25;
y1 = ((r1^2-r2^2+(d2(1))^2-(d1(1))^2+(d2(2))^2-(d1(2))^2)/2 - (d2(1)-d1(1)).*x)/(d2(2)-d1(2));
plot(x,y1,'c')

y2 = ((r1^2-r3^2+(d3(1))^2-(d1(1))^2+(d3(2))^2-(d1(2))^2)/2 - (d3(1)-d1(1)).*x)/(d3(2)-d1(2));
plot(x,y2,'c')

y3 = ((r2^2-r3^2+(d3(1))^2-(d2(1))^2+(d3(2))^2-(d2(2))^2)/2 - (d3(1)-d2(1)).*x)/(d3(2)-d2(2));
plot(x,y3,'c')

[a,b] = polyxpoly(x,y1,x,y2);
scatter(a,b,'k')

axis([-5 35 -20 20])
