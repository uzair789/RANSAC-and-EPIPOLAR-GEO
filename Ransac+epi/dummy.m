
A = [2 0;
    0 2];

B = [0;0];

X = [1;1];
D = [-2;-2]

u = (D' * D) / (D'*A*D)

X = X + u * D