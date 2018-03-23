t = importdata('X_test.mat');
u = importdata('X_train.mat');
a = importdata('y_test.mat');
b = importdata('y_train.mat');
%Since there are 25 Classes, i.e., persons in the video. We will change out
%Train Classes to 25 indices Vector with Value 1 on the Class label indices
%and rest are 0. For example - Class Value 1 is vector
%1000000000000000000000000
[rows,columns] = size(u);
x_train_processed = zeros(3500,25,'double');
for i = 1:rows
    temp = b(1,i);
    x_train_processed(i,temp) = 1;
end

net1 = init(net1);
net1 = feedforwardnet(25);
net1 = train(net1,u',x_train_processed');
view(net1)
outputs = net1(t');
answers = vec2ind(outputs);
[row, column] = size(answers)
counter = 0
for k = 1:column
if answers(1,k) == a(1,k)
    counter = counter +1;
end
end
percentage = counter/column;
percentage = percentage*100;
percentage


