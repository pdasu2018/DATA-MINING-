Test_Matrix = importdata('X_test.mat');
Train_Matrix = importdata('X_train.mat');
Y_test = importdata('y_test.mat');
Y_train = importdata('y_train.mat');
% Array_test = reshape(Y_test,[],1);
% Array_train = reshape(Y_train,[],1);
% [rows] = size(Array_train,1);
% column = 6;
% final_test=[];
% for r = 1:rows
%     for c = 1:column
% if c == Array_train(r,1)
%             final_test(r, c) = 1;
%         else
%             final_test(r,c) = 0;
%         end
%     end
% end
Final = [];
for r = 1:6
   model = fitcsvm(Train_Matrix, Y_train(:,r), 'KernelFunction', 'polynomial', 'PolynomialOrder', 2, 'KernelScale', 'auto');
   Answer = predict(model, Test_Matrix(:,:));
   Final = horzcat(Final, Answer);

end
[rows,cols] = size(Final);
intersection_count = 0;
union_count = 0;
sum = 0;

for row = 1:rows
    accuracy = 0;
    intersection_count = 0;
    union_count = 0;
    for col = 1:cols
       if Final(row, col) == 1 && Y_test(row, col) == 1
           intersection_count = intersection_count + 1;
           union_count = union_count + 1;
       elseif Final(row, col) == 0 && Y_test(row, col) == 1
               union_count = union_count + 1;
           
       elseif Final(row, col) == 1 && Y_test(row, col) == 0
               union_count = union_count + 1;
           
       end
       
       
    end
    accuracy = intersection_count/union_count;
   sum = sum + accuracy;
end

% for i = 1:rows
%     
%     result = isequal(Final(i,:), Y_test(i,:));
%     
% end
%union = ((970*2)-count);

(sum/rows)*100
