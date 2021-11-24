% Fall 2021 MATH 3700 OR
% HW 3
% Linear Programming Example(LP)
% Goal: use Matlab command linprog to solve the Klee and Minty problem
% Type help linprog for instructions or visit
% http://www.mathworks.com/help/optim/ug/linprog.html
%
% Test Problem: (n = 4) 
% maximize    8*x_1 + 4*x_2 + 2*x_3 + x_4 
% subject to     x_1                       <= 5
%              4*x_1 + x_2                 <= 25
%              8*x_1 + 4*x_2 + x_3         <= 125
%             16*x_1 + 8*x_2 + 4*x_3 + x_4 <= 625
%                    x_1 , x_2 , x_3 , x_4 >= 0

% Cost function: recall linprog solves a minimization problem
f = [-8 ; -4; -2; -1];
% Right-hand side:
b = [5; 25; 125; 625];
% Matrix A (constraints) nxn matrix for this LP
A = [1 0 0 0; 4 1 0 0; 8 4 1 0; 16 8 4 1];
% Lower-bounds (non-negativity constraint)
lb = zeros(4,1);

% Optimization solver options: ('interior-point' or 'dual-simplex')
method = 'interior-point';
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
