% Nonnegative matrix factorization
% Argyris Zymnis, Joelle Skaf, Stephen Boyd
%
% We are given a matrix A in R^{m*n}
% and are interested in solving the problem:
%
% minimize    ||A - Y*X||_F
% subject to  Y >= 0, X >= 0
%
% where Y in R{m*k} and X in R{k*n}.
% This script generates a random matrix A and obtains an
% *approximate* solution to the above problem by first generating
% a random initial guess for Y and the alternatively minimizing
% over X and Y for a fixed number of iterations.

figure(1);
cla;

rand('state', 5934);
for i = 1:5
	% Generate data matrix A
	m = 50; n = 50; k = 5;
	A = rand(m,k)*rand(k,n);

	% Initialize Y randomly
	Y = rand(m,k);

	% Perform alternating minimization
	MAX_ITERS = 30;
	residual = zeros(1,MAX_ITERS);
	for iter = 1:MAX_ITERS
		cvx_begin
			cvx_quiet(true);
			if mod(iter,2) == 1
				variable X(k,n)
			else
				variable Y(m,k)
			end
			X >= 0; 
			Y >= 0;
			minimize(norm(A - Y*X,'fro'));
		cvx_end
		fprintf(1,'Iteration %d, residual norm %g\n',iter,cvx_optval);
		residual(iter) = cvx_optval;
	end

	% Display results
	disp( 'Original matrix:' );
	disp( A );
	disp( 'Left factor Y:' );
	disp( Y );
	disp( 'Right factor X:' );
	disp( X );
	disp( 'Residual A - Y * X:' );
	disp( A - Y * X );
	fprintf( 'Residual after %d iterations: %g\n', iter, cvx_optval );

	% Plot residuals
	plot(residual); 
	hold on;
end

xlabel('x');
ylabel('y');
set(gca, 'FontSize',18);
print -deps2 nmf.eps