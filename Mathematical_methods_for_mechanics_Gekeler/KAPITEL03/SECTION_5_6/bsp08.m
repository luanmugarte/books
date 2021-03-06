function Y = bsp08(X,flag,Parmeter);
% Himmelblau, S. 397
% flag = 1: Objective function
% flag = 2: Inequalities
% flag = 3: Equalities
% flag = 4: Gradient of objective function
% flag = 5: Gradient of inequalities
% flag = 6: Gradient of equalities
% -------------------------------------------
% Gradient of f: R_n -> R_m is (m,n)-matrix
% -------------------------------------------
switch flag
case 1
   Y = 1000 -  X(1)^2 - 2*X(2)^2 - X(3)^2;
   Y = Y - X(1)*X(2) - X(1)*X(3);
case 2
   Y = [X(1); X(2); X(3)];
case 3
   h1 = X(1)^2 + X(2)^2 + X(3)^2 - 25;
   h2 = 8*X(1) + 14*X(2) + 7*X(3) - 56;
   Y = [h1; h2];
case 4
   Y = [-2*X(1)-X(2)-X(3), -4*X(2)-X(1), -2*X(3)-X(1)];
case 5
   Y = [1 0 0; 0 1 0; 0 0 1];
case 6
   Y = [2*X(1), 2*X(2), 2*X(3);8,  14,  7];
end
