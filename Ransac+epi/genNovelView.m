 function genNovelView

    clear all;
	addpath(genpath('.'));
	load('data/K.mat'); %intrinsic parameters K
	i1 = imread('data/i1.jpg');
	i2 = imread('data/i2.jpg');
    
	load ('noisy_correspondences.mat');
    
    [F,Inliers] = ransacF(pts1,pts2,1920^2)

    P1 = pts1(:,Inliers);
    P2 = pts2(:,Inliers);
 
    M1 = K * [eye(3) zeros(3,1)];
    M2 = camera2(F,K,K,P1,P2);
    
    P = triangulate(M1,P1,M2,P2);
    P3 = P;
    plane_coeffs = zeros(4,2);
  
 for plane = 1:2  
   plane
    l=0;
    plane_coef=[];
    for iteration = 1:1000
        
        rand = randperm(size(P,2),4);
        A = [P(:,rand)' ones(4,1)];
        [U,S,V] = svd(A);
        coeff  = V(:,end);
        
        a = coeff(1);
        b = coeff(2);
        c = coeff(3);
        d = coeff(4);
        
        inliers2 = [];
    
        for i = 1:size(P,2) 
        
          x0 = P(1,i);
          y0 = P(2,i);
          z0 = P(3,i);
            
          distance = abs( a*x0 + b*y0 + c*z0 + d)/sqrt(a^2 + b^2 + c^2);
       
          if distance < 0.001
              index = i;
              inliers2 = [inliers2 index];
          end
       
        end
    
        if length(inliers2) > l
           Inliers2 = inliers2;
           plane_coef=[a b c d];
           l = length(inliers2);
       end
    end
    
    P(:,Inliers2) = [];
    plane_coeffs(:,plane) = plane_coef
    
 end   
 
M5 = [1493 0 1500 -900;
        0 1471.84 508.54 -100;
        0 0 1 -0.0551];
    
 frame = drawNovelView(plane_coeffs(:,1),plane_coeffs(:,2),M5); 
 figure;imshow(frame)   
 
M6 = [1493 00 1500 100;
    0 1471 508.5 1200;
    0 0.1 1 2.5];      
frame = drawNovelView(plane_coeffs(:,1),plane_coeffs(:,2),M6); 
figure;imshow(frame)   
 end

