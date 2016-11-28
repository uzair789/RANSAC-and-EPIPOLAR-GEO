function [F_final,Inliers] = ransacF(pts1,pts2,normalization)

l=0;
Fpos=[];

for iteration = 1 : 1000
    
    fprintf('Running Ransac for iteration %d of %d\n',iteration,1000);
    rand_locations = randperm(60,7);
    pts_1 = pts1(:,rand_locations);
    pts_2 = pts2(:,rand_locations);

    FF = sevenpoint_norm(pts_1,pts_2,normalization);
                            
    pts11 = [pts1;ones(1,60)];
    pts22 = [pts2;ones(1,60)];

    for j = 1:3
        D=[];
        F = FF{j};
        inliers = [];
    
        for i = 1 : 60
 
            coeff = F * pts11(:,i);
            a = coeff(1);
            b = coeff(2);
            c = coeff(3);
           
            x0 = pts22(1,i);
            y0 = pts22(2,i);
    
            d = abs( a*x0 + b*y0 + c)/sqrt(a^2 + b^2);
                    
            if d < 3
                index = i;
                inliers = [inliers index];
            end
    
        end

        if length(inliers)  > l
            F_final = F;
            Inliers = inliers;
            l = length(inliers);
            Fpos = [iteration,j];
        end

    end
end%end for iterations

end