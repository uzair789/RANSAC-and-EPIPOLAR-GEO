function F = eightpoint_norm(pts1,pts2,normalization_constant)
 
pts1_n = pts1;
pts2_n = pts2;

one_s = repmat(1,[1 size(pts1,2)]);
pts1_h = [pts1_n;one_s];
pts2_h = [pts2_n;one_s];

A=[];
for i = 1:size(pts1,2)
    row1 = [pts2_h(1,i).*pts1_h(:,i)' pts2_h(2,i).*pts1_h(:,i)' pts2_h(3,i).*pts1_h(:,i)'];
    A=[A ;row1];
end

A=A./normalization_constant;

[U,S,V]=svd(A);
Fvec = V(:,end);
F = reshape(Fvec,3,3)'

 end