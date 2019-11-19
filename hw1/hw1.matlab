data1 = csvread('data1.csv');
x = data1(:,1);
x1 = x(1:50);
x2 = x(51:100);
y = data1(:,2);
y1 = y(1:50);
y2 = y(51:100);
z = data1(:,3);
w1 = 0;
w2 = 0;
b = 0;
u = 0;
a= 0;
for iter = 1:1000
	for i = 1:100
		a = w1*x(i)+w2*y(i)+b;
		if z(i)*a <= 0
			fprintf("%d\n", i);
			u = u+1;
			w1 = w1 + z(i)*x(i);
			w2 = w2 + z(i)*y(i);
			b = b+z(i);
		end
	end
end
scatter(x1,y1);
hold on;
scatter(x2,y2);
w = (-w1*x-b)/w2;
plot(x,w);
hold off;

min = 10000;
for k = 1:100
	dist = abs((w1*x(k)+w2*y(k)+b)/sqrt(w1*w1+w2*w2));
	if dist < min
		min = dist;
	end
end

% linearly separable 

data2 = csvread('data2.csv');
x = data2(:,1);
x1 = x(1:50);
x2 = x(51:100);
y = data2(:,2);
y1 = y(1:50);
y2 = y(51:100);
z = data2(:,3);
w1 = 0;
w2 = 0;
b = 0;
u = 0;
a= 0;
for iter = 1:1000
	for i = 1:100
		a = w1*x(i)+w2*y(i)+b;
		if z(i)*a <= 0
			fprintf("%d\n", i);
			u = u+1;
			w1 = w1 + z(i)*x(i);
			w2 = w2 + z(i)*y(i);
			b = b+z(i);
		end
	end
end
scatter(x1,y1);
hold on;
scatter(x2,y2);
w = (-w1*x-b)/w2;
plot(x,w);
hold off;
min = 10000;
for k = 1:100
	dist = abs((w1*x(k)+w2*y(k)+b)/sqrt(w1*w1+w2*w2));
	if dist < min
		min = dist;
	end
end

% linearly separable 




data3 = csvread('data3.csv');
x = data3(:,1);
y = data3(:,2);
z = data3(:,3);

x1 = x(1:50);
x2 = x(51:100);
y1 = y(1:50);
y2 = y(51:100);

w1 = 0;
w2 = 0;
b = 0;
u = 0;
a= 0;
for iter = 1:1000
	for i = 1:100
		a = w1*x(i)+w2*y(i)+b;
		if z(i)*a <= 0
			u = u+1;
			w1 = w1 + z(i)*x(i);
			w2 = w2 + z(i)*y(i);
			b = b+z(i);
		end
	end
end


scatter(x1,y1);
hold on;
scatter(x2,y2);


w = (-w1*x-b)/w2;
plot(x,w);
hold off;


gamma = 10000;
for k = 1:100
	dist = abs((w1*x(k)+w2*y(k)+b)/sqrt(w1*w1+w2*w2));
	if dist < gamma
		gamma = dist;
	end
end
