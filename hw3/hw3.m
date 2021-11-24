clear all;
n = 6;
% Cost function: recall linprog solves a minimization problem
%f = [-8 ; -4; -2; -1];
f = flip(-1*power(2, 0:n-1))
% Right-hand side:
%b = [5; 25; 125; 625];
b = power(5, 1:n);
% Matrix A (constraints) nxn matrix for this LP

A = tril(ones(n));
for i = 1:n
    for j = i+1:n
        A(j, i) = 2^(j-i+1);
    end
end
A;
% Lower-bounds (non-negativity constraint)
lb = zeros(n,1);

% Optimization solver options: ('interior-point' or 'dual-simplex')
method = 'interior-point'; %dual-simplex interior-point
options = optimoptions(@linprog,'Algorithm',method);

% Find solution x, f(x), and number of iterations
ub  = [];
Aeq = [];
beq = [];
x0  = [];

% Start timer
tic
[x,fopt,exitflag, output,lambda] = linprog(f,A,b,Aeq,beq,lb,ub,x0,options);
% Stop timer
total_time = toc;
x

fprintf('***************************************\n\n');
message = strcat(['Optimal point x found. Method used: ', ' ',method]);
fprintf(strcat(message, ' algorithm\n'));
fprintf('f(x) = %f, after %d iterations \n', -fopt,output.iterations)
% Notice that the solution that Matlab returns must be multiplied by -1
% for our maximization problem
fprintf('Time : %f seconds\n', total_time);
fprintf('***************************************\n\n');