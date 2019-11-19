train_data = csvread('regression_train.csv');
x = train_data(:,1);
y = train_data(:,2);
format long;
X = [ones(length(x),1) x];
for m = 0:10
	w = zeros(m,1);
	theta = x^
	Jw_curr = intmax('int32');
	Jw_prev = intmax('int32');
	eta = 0.0407
	for iter = 1:10
		z1 = 0;
		z2 = 0;
		for i = 1:length(x)
			z1 = z1+(w(1)+w(2)*x(i)-y(i))*X(i,1);
			z2 = z2+(w(1)+w(2)*x(i)-y(i))*X(i,2);
		end
		w(1) = w(1) - eta*z1;
		w(2) = w(2) - eta*z2;
		Jw_curr = norm(X*w-y,2);
		if abs(Jw_curr - Jw_prev) < 0.0001
			break;
		end
		Jw_prev = Jw_curr;
	end
end
scatter(x,y);
xlabel('input');
ylabel('output');
hold on;
y1 = X*w;
plot(x,y1);



train_data = csvread('regression_train.csv');
x = train_data(:,1);
y = train_data(:,2);
format long;
E_rms = zeros(11,1);
for m = 0:10
    clear X;
	for i = 1:20
		a = zeros(m+1,1);
		for j = 0:m
			a(j+1) = power(x(i),j);
        end
		X(i, :) = transpose(a);
    end
    disp("X:");
    disp(X);
	w = X\y;
	y1 = X*w;
	E_rms(m+1) = sqrt(norm(X*w-y,2)/20);
	plot(x, y1);
end
x_axis = [0;1;2;3;4;5;6;7;8;9;10];
xlabel("polynomial degree");
ylabel("RMSE");




test_data = csvread('regression_test.csv');
x = test_data(:,1);
y = test_data(:,2);
format long;
E_rms = zeros(11,1);
for m = 0:10
    clear X;
	for i = 1:20
		a = zeros(m+1,1);
		for j = 0:m
			a(j+1) = power(x(i),j);
        end
		X(i, :) = transpose(a);
    end
    disp("X:");
    disp(X);
	w = X\y;
	y1 = X*w;
	E_rms(m+1) = sqrt(norm(X*w-y,2)/20);
	plot(x, y1);
end
x_axis = [0;1;2;3;4;5;6;7;8;9;10];
xlabel("input");
ylabel("output");


train_data = csvread('regression_train.csv');
x = train_data(:,1);
y = train_data(:,2);
test_data = csvread('regression_test.csv');
x_t = test_data(:,1);
y_t = test_data(:,2);
format long;
E_rms = zeros(11,1);
for m = 0:10
    clear X;
    clear Z;
	for i = 1:20
		a = zeros(m+1,1);
		b = zeros(m+1,1);
		for j = 0:m
			a(j+1) = power(x(i),j);
			b(j+1) = power(x_t(i),j);
        end
		X(i, :) = transpose(a);
		Z(i, :) = transpose(b);
    end
    disp("X:");
    disp(X);
	w = X\y;
	y1 = X*w;

	E_rms(m+1) = sqrt((norm(X*w-y,2)*norm(X*w-y,2)+norm(Z*w-y_t,2)*norm(Z*w-y_t,2))/40);
end
x_axis = [0;1;2;3;4;5;6;7;8;9;10];
%plot(x_axis, E_rms);
scatter(x_axis, E_rms);
xlabel('input');
ylabel('output');




test_data = csvread('regression_test.csv');
x = test_data(:,1);
y = test_data(:,2);
scatter(x,y);
xlabel('input');
ylabel('output');