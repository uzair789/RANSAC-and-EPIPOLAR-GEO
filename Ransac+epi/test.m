

F = eightpoint_norm(pts1,pts2,1920^2);


 F = sevenpoint_norm(pts1,pts2,1920^2);

i1=imread('data/i1.jpg');
i2=imread('data/i2.jpg');
displayEpipolarF(i1,i2,F_final)