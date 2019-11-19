x1 = table2array(Data(:,1));
x2 = table2array(Data(:,2));
y = table2array(Data(:,3));
x = table2array(Data(:,1:2));
hold on;
for i = 1:size(y)
    if (y(i) == 1)
        scatter(x1(i), x2(i), 'b');
    else
        scatter(x1(i), x2(i), 'r');
    end
end

cvx_setup
cvx_begin
    variable w(2);
    variable b;
    minimize( norm(w) ) subject to transpose(y).*(w.'*x.'+b) >= 1;
cvx_end
a = 0 : 0.01 : 10;
y = 0.5*a + 2;
plot(a, y);
hold off;


cvx_begin
    variable a(29);
    maximize( sum(a)- 0.5*sum(((x*transpose(x)) *(a.*y)).'*(a.*y))));
    subject to
        a >= 0;
        sum (a .* y) == 0;
cvx_end

w_vec = zeros(1,2);
for j = 1 : 29
    w_vec(1) = w_vec(1) + x1(j)*y(j)*a(j);
    w_vec(2) = w_vec(2) + x2(j)*y(j)*a(j);
end