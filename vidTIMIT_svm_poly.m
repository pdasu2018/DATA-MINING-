Test_Matrix = importdata('X_test.mat');
Train_Matrix = importdata('X_train.mat');
Y_test = importdata('y_test.mat');
Y_train = importdata('y_train.mat');
Array_test = reshape(Y_test,[],1);
Array_train = reshape(Y_train,[],1);
[rows] = size(Array_train,1);
column = 25;
final_test=[];
for r = 1:rows
    for c = 1:column
if c == Array_train(r,1)
            final_test(r, c) = 1;
        else
            final_test(r,c) = 0;
        end
    end
end
count = 0;
for r = 1:25
   model = fitcsvm(Train_Matrix, final_test(:,r), 'KernelFunction', 'polynomial', 'PolynomialOrder', 2);
   Answer = predict(model, Test_Matrix(:,:));
   rows = size(Answer(:,1));
   for row = 1:rows
       if Answer(row, 1) == 1 && Y_test(1,row) == r
           count = count + 1;
       end 
   end
end
accuracy = (count/1000)*100;
accuracy
