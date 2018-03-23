Test_Matrix = importdata('X_test.txt');
Train_Matrix = importdata('X_train.txt');
Y_test = importdata('y_test.txt');
Y_train = importdata('y_train.txt');
Array1 = reshape(Y_test,[],1);
Array2 = reshape(Y_train,[],1);

[IDX,D] = knnsearch(Train_Matrix,Test_Matrix,'k',7);
A = [];
 [rows,columns] = size(IDX);
 for c = 1:rows
     for d = 1:columns
         temp = IDX(c,d);
         A(c,d) = Array2(temp,1);
     end
 end
 A_mode = mode(A,2);
 counter = 0;
 for e = 1:rows
    if A_mode(e,1) == Array1(e,1);
        counter = counter +1;
    end
 end
 percentage = counter/rows;
 percentage = percentage*100;
 percentage
