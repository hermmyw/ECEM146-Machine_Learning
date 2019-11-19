uclabruin = imread('UCLA_Bruin.jpg');
imshow(uclabruin);

%reformat image
img = zeros ( 120000, 5 );
for i = 1 : 300
    for j = 1 : 400
        img(j+400*i-400, 1) = i;
        img(j+400*i-400, 2) = j;
        img(j+400*i-400, 3) = uclabruin(i, j, 1);
        img(j+400*i-400, 4) = uclabruin(i, j, 2);
        img(j+400*i-400, 5) = uclabruin(i, j, 3);
    end
end

max_clst = 4;
u = img(1, 3:5);
for clus = 2 : max_clst
    curr_u = u(1, :);
        for i = 1 : 120000
            s = size(u);
            nClst = s(1);
            d1 = zeros(1, nClst);
            d2 = zeros(1, nClst);
            for j = 1 : s(1)
                d1(j) = norm(img(i, 3:5) - u(j, :));
                d2(j) = norm(curr_u - u(j, :));
            end
            if (min(d1) > min(d2))
                curr_u = img(i, 3:5);
            end
        end
    u = [u ; curr_u];
end

J = zeros(1, 10);
for iter = 1:10
    r = zeros(120000,max_clst); % intialize r_nk
    total = zeros(max_clst, 3);
    nPix = zeros(max_clst, 1);
    clst = 0;
    J_iter = 0;
	for i = 1:120000
		d = intmax;
		for k = 1:max_clst % find the closest u
			curr_d = norm(img(i, 3:5) - u(k, :));
			if (curr_d < d)
				d = curr_d;
				clst = k;
			end
		end
		r(i,clst) = 1;  % set the data point to the found cluster
		total(clst, :) = total(clst, :) + img(i, 3:5); % re-estimate u
		nPix(clst) = nPix(clst)+1;
    end
    for i = 1:120000
        for k = 1:max_clst
    		u(k, :) = total(k,:) / nPix(k);
    		J_iter = J_iter + r(i, k)*norm(img(i, 3:5) - u(k,:)).^2;
        end
	end
    J(iter) = J_iter;
end
figure;
scatter([1:10],J);


new = uclabruin;
for i = 1 : 300
    for j = 1 : 400
            current = zeros(1, 3);
            current = transpose(u) * transpose(r(j+400*i-400, :));
            new(i, j, 1) = current(1);
            new(i, j, 2) = current(2);
            new(i, j, 3) = current(3);
    end
end
imshow(new);
