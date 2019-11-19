x_train = csvread("dataTraining_X.csv")
y_train = csvread("dataTraining_Y.csv")
x_test = csvread("dataTesting_X.csv")
y_test = csvread("dataTesting_Y.csv")

knn1 = fitcknn(x_train, y_train , 'NumNeighbors', 1)
knn3 = fitcknn(x_train, y_train , 'NumNeighbors', 3)
knn5 = fitcknn(x_train, y_train, 'NumNeighbors', 5)
dt = fitctree(x_train, y_train, 'SplitCriterion', 'deviance')

acc_dt = loss(dt, x_train, y_train)
acc_k1 = loss(knn1, x_train, y_train)
acc_k3 = loss(knn3, x_train, y_train)
acc_k5 = loss(knn5, x_train, y_train)

acc_dt_test = loss(dt, x_test, y_test)
acc_k1_test = loss(knn1, x_test, y_test)
acc_k3_test = loss(knn3, x_test, y_test)
acc_k5_test = loss(knn5, x_test, y_test)

cv_k1 = kfoldLoss(crossval(knn1))
cv_k3 = kfoldLoss(crossval(knn3))
cv_k5 = kfoldLoss(crossval(knn5))
cv_dt = kfoldLoss(crossval(dt))



for k = 1:15
    knn = fitcknn(x_train, y_train , 'NumNeighbors', k)
    t_err(k) =  loss(knn, x_test, y_test)
    v_err(k) =  kfoldLoss(crossval(knn))
end
x = transpose(linspace(1,15,15))
scatter(x, v_err)
hold on
scatter(x, t_err)
hold off
