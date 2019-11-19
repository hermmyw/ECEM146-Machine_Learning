%5(a) import data
x1 = table2array(data2(:,1));
x2 = table2array(data2(:,2));
y = table2array(data2(:,3));
x = table2array(data2(:,1:2));
hold on;
for i = 1:size(y)
    if (y(i) == 1)
        scatter(x1(i), x2(i), 'b');
    else
        scatter(x1(i), x2(i), 'r');
    end
end
%blue: Y = 1
%red: Y = 0

%5(b)
p0 = 1 - sum(y)/200;
u0 = zeros(1, 2);
u1 = zeros(1, 2);
for i = 1 : 200
	if (y(i) == 1)
		u1(1) = u1(1) + x1(i);
        u1(2) = u1(2) + x2(i);
	else
		u0(1) = u0(1) + x1(i);
        u0(2) = u0(2) + x2(i);
        
	end
end
u1 = u1/sum(y);
u0 = u0/(200-sum(y));

sum1 = zeros(2, 2);
sum0 = zeros(2, 2);
for i = 1:200
	if (y(i) == 1)
		sum1 = sum1 + transpose(x(i,:) - u1) * (x(i,:)  - u1);
	else
		sum0 = sum0 + transpose(x(i,:) - u0) * (x(i,:) - u0);
    end
end
E = (sum1 + sum0)/200;

% P(Y = 0) = 0.4850
% sum0 = 127.7764
% sum1 = 95.9694
% u0 = 1.9348
% u1 = 5.8565



% 5(c). from 2(b)
w = inv(E) * (transpose(u0-u1));
b = log(p0/(1-p0)) + 0.5*(u1*inv(E)*transpose(u1) - u0*inv(E)*transpose(u0));
x_axis = linspace(-2, 10, 1201);
y_axis = -(w(1)*x_axis+b)/w(2);
plot(x_axis, y_axis);
axis([-2 10 -8 2]);


% 5(d)
[X1, X2] = meshgrid(-2:0.1:10, -8:0.1:2);
P0 = zeros(121, 121);
P1 = zeros(121, 121);
for i = 1:121
	for j = 1:121
		P0(i,j) = 1/(2*pi*det(E)^(0.5))* exp(-0.5*transpose([X1(i,j)-u0(1); X2(i,j)-u0(2)])*inv(E)*[X1(i,j)-u0(1); X2(i,j)-u0(2)]);
		P1(i,j) = 1/(2*pi*det(E)^(0.5))* exp(-0.5*transpose([X1(i,j)-u1(1); X2(i,j)-u1(2)])*inv(E)*[X1(i,j)-u1(1); X2(i,j)-u1(2)]);
	end
end
contour(X1,X2, P0, 'LevelList', logspace(-3,-1,7));
contour(X1,X2, P1, 'LevelList', logspace(-3,-1,7));
axis([-2 10 -8 2]);