r = 10;
r1 = 12;

theta = linspace(0,2*pi,360);

d0 = [1 2];
d1 = [15 -4];
d2 = [5 -15];

x = r*cos(theta)+d0(1);
y = r*sin(theta)+d0(2);
scatter(d0(1),d0(2),'r')
hold on
plot(x,y,'b')

x = r*cos(theta)+d1(1);
y = r*sin(theta)+d1(2);
scatter(d1(1),d1(2),'r')
plot(x,y,'b')

x = r1*cos(theta)+d2(1);
y = r1*sin(theta)+d2(2);
scatter(d2(1),d2(2),'r')
plot(x,y,'b')

x = -10:25;
y1 = ((r^2-r^2+(d1(1))^2-(d0(1))^2+(d1(2))^2-(d0(2))^2)/2 - (d1(1)-d0(1)).*x)/(d1(2)-d0(2));
plot(x,y1,'r')

y2 = ((r^2-r1^2+(d2(1))^2-(d0(1))^2+(d2(2))^2-(d0(2))^2)/2 - (d2(1)-d0(1)).*x)/(d2(2)-d0(2));
plot(x,y2,'r')

y3 = ((r^2-r1^2+(d2(1))^2-(d1(1))^2+(d2(2))^2-(d1(2))^2)/2 - (d2(1)-d1(1)).*x)/(d2(2)-d1(2));
plot(x,y3,'r')

[a,b] = polyxpoly(x,y1,x,y2);
scatter(a,b,'k')
