Test_Matrix = importdata('seeds.txt');
k=3;
centroid_samples=datasample(Test_Matrix,k,'Replace',false);
m = pdist2(Test_Matrix, centroid_samples);
[min_dist,cluster]=min(m,[],2);

%sum_centroid=zeros(k,7);
 temp=10.0; 
 sse=0.0;
  q=1;
while (q <= 100)&&( temp-sse >= 0.001)
count=zeros(k,1);
sum_centroid=zeros(k,7);
  sse=temp ;
  temp = 0.0;
for i=1:k
  for j=1:210
  if cluster(j)==i
      for x=1:7
      sum_centroid(i,x)= sum_centroid(i,x)+Test_Matrix(j,x);
      end
      count(i)=count(i)+1;
  end 
  end
end 
for x=1:7
     sum_centroid(1,x)=sum_centroid(1,x)/count(1);
     sum_centroid(2,x)=sum_centroid(2,x)/count(2);
     sum_centroid(3,x)=sum_centroid(3,x)/count(3);
  
end

 
  m = pdist2(Test_Matrix, sum_centroid);
  [min_dist1, cluster1]=min(m,[],2);
  q=q+1;
  su = zeros(k,1);
  for o = 1:k
      for l = 1:210
          if cluster1(l) == o
          su(o,1) = su(o,1)+(m(l, cluster(l)).^2) ;
          end
      end
  end
      for o=1:k
          temp = temp+su(o,1);
      end
      cluster = cluster1;
      min_dist = min_dist1;
  end 
   
