D = 784;
N = 400;
x = table2array(MNIST3);

% 2(a)

% mean vector of x
x_bar = sum(x)/400;

% data covariance
S = zeros(784, 784);
t = linspace(1,100,100);
for i = 1:N
    temp = (x(i,:) - x_bar);
    temp2 = transpose(temp)*temp;
	S = S + temp2;
end
S = S/N;

% eigenvalue
eigen = eig(S);
eigen = sort(eigen, 'descend');
eigen = eigen(1:100);
figure;
scatter(t, eigen);

% 2(b)
% eigenvector
[V, Diag] = eig(S);  % V is the corresponding right eigenvectors
V = V(:, D-3:D); % get the first 4 eigenvectors
% rescale
for i = 1:4
	max_pixel = max(V(:, i));
    V(:,i) = 255/max_pixel * V(:,i);
end
% visualization
figure;
for i = 1:4
	img = zeros(28,28);
	for j = 1:784
		a = (j-1 - mod(j-1, 28))/28 + 1;
		b = mod(j-1, 28)+1;
		img(a,b) = V(j, i);
	end
	subplot(2,2,i);
	imshow(transpose(img));
end


% 2(c)
figure;
% show first image
img = zeros(28,28);
for j = 1:D
	a = (j-1 - mod(j-1, 28))/28 + 1;
	b = mod(j-1, 28)+1;
	img(a,b) = x(1, j);
end
subplot(3,2,1);
imshow(transpose(img));
title('Original');

% show compressed image
M = [0 1 10 50 250];
[V, Diag] = eig(S);  % V is the corresponding right eigenvectors


for m = 1:5
    c_img = zeros(28,28);
    x_tilda = zeros(1,D);
    for i = 1:M(m)
        eigen_vec = V(:,785-i); %784*1
        temp1 = (x(1,:)*eigen_vec-x_bar*eigen_vec) * eigen_vec;
        x_tilda = x_tilda + transpose(temp1);
    end
    x_tilda = x_tilda + x_bar;

    for j = 1:D
        a = (j-1 - mod(j-1, 28))/28 + 1;
        b = mod(j-1, 28)+1;
        c_img(a,b) = x_tilda(1, j);
    end
    subplot(3,2,m+1);
    imshow(transpose(c_img));
    title(M(m));
end



%=========================================
%=========================================
%=========================================










% 6(a)
data = table2array(AdaBoostdata);
x1 = data(:,1);
x2 = data(:,2);
y = data(:,3);
figure;
hold on;
for i = 1:size(y)
    if (y(i) == 1)
        scatter(x1(i),x2(i),'b');
    else
        scatter(x1(i),x2(i),'r');
    end
end
hold off;

% 6(b)
K = 3;
N = length(y);
f = zeros(1,K);
alph = zeros(1,K);

% Initialize uniform importance
d(1:N) = (1/N) * ones(N,1);

for k = 1:K
    if k == 1 % given optimal s and i
        i = 1; s = -1;
    elseif k == 2
        i = 1; s = -1;
    else
        i = 2; s = 1;
    end
    err = zeros(1,N);
    
    % Find optimal t
    for t = 0:N-1
        for n = 1:N
            y_prd(n) = sign((data(n,i)-t)*s); % Make predictions on training data
            if y_prd(n)~= y(n)  % Error
                err(t+1) = err(t+1) + d(n); % Compute weighted training error
            end
        end
    end
    [min_err, min_ind] = min(err);
    f(k) = min_ind-1; % t
    alph(k) = 1/2*log((1-min_err)/min_err); % Compute adaptive parameter

    % Re-weight examples and normalize
    for n = 1:N
        y_prd(n) = sign((data(n,i)-f(k))*s);
        d(n) = d(n)*exp(-alph(k)*y(n)*y_prd(n)); % update weight on misclassified point
    end
    % Normalize
    d = d / sum(d);
end












