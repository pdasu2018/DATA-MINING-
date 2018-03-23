Test_Matrix = importdata('X_test.mat');
Train_Matrix = importdata('X_train.mat');
Y_test = importdata('y_test.mat');
Y_train = importdata('y_train.mat');
Array1_knn = reshape(Y_test,[],1);
Array2_knn = reshape(Y_train,[],1);

[IDX,D] = knnsearch(Train_Matrix,Test_Matrix,'k',7);
A = [];
 [rows,columns] = size(IDX);
 for c = 1:rows
     for d = 1:columns
         temp = IDX(c,d);
         A(c,d) = Array2_knn(temp,1);
     end
 end
 Answer_knn = mode(A,2);
 counter_knn = 0;
 for e = 1:rows
    if Answer_knn(e,1) == Array1_knn(e,1);
        counter_knn = counter_knn +1;
    end
 end
 percentage_knn = counter_knn/rows;
 percentage_knn = percentage_knn*100;
 percentage_knn
 
[ rows,columns] = size(Train_Matrix);
x_train_processed = zeros(500,10,'double');
for i = 1:rows
    temp = Y_train(i,1);
    x_train_processed(i,temp) = 1;
end


net1 = feedforwardnet(25);
net1 = train(net1,Train_Matrix',x_train_processed');
view(net1)
outputs = net1(Test_Matrix');
answers_neural = vec2ind(outputs);
[row, column_neural] = size(answers_neural);
counter_neural = 0;
for k = 1:column_neural
if answers_neural(1,k) == Y_test (k,1)
    counter_neural = counter_neural +1;
end
end
percentage_neural = counter_neural/column_neural;
percentage_neural = percentage_neural*100;
percentage_neural


Y_test = importdata('y_test.mat');
Y_train = importdata('y_train.mat');
Array_test_svm = reshape(Y_test,[],1);
Array_train_svm = reshape(Y_train,[],1);
[rows] = size(Array_train_svm,1);
column = 10;
final_test=[];
for r = 1:rows
    for c = 1:column
if c == Array_train_svm(r,1)
            final_test(r, c) = 1;
        else
            final_test(r,c) = 0;
        end
    end
end
count_svm= 0;
Final_svm=0;
for r = 1:10
   model = fitcsvm(Train_Matrix, final_test(:,r), 'KernelFunction', 'polynomial', 'PolynomialOrder', 2);
   Answer_svm = predict(model, Test_Matrix(:,:));
   rows = size(Answer_svm(:,1));
    for row = 1:rows
       if Answer_svm(row, 1) == 1
          Final_svm(row , 1)=r; 
           
       end 
   end
   
   for row = 1:rows
       if Answer_svm(row, 1) == 1 && Y_test(row,1) == r
           count_svm = count_svm + 1;
       end 
   end
end
accuracy_svm = (count_svm/3251)*100;
accuracy_svm
 

answers_neural= transpose(answers_neural);

e_answer=[];


for r=1:rows
if Final_svm(r,1)==Answer_knn(r,1)
    e_answer= Final_svm;

elseif Final_svm(r,1)== answers_neural(r,1)
        e_answer=Final_svm;
    
    elseif Answer_knn(r,1)==answers_neural(r,1)
         e_answer= Answer_knn;    
       
end
end
count_en=0;
for row = 1:rows
       if e_answer(row, 1) == Y_test(row,1)
           count_en = count_en + 1;
       end 
end

   
accuracy_en=count_en/3251 *100;
accuracy_en