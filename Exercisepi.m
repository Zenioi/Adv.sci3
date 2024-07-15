N = 10000;

% Estimate pi
pi_value = estimate_pi(N);

% Display the estimated value of pi
disp(['Estimated value of pi after ', num2str(N), ' iterations: ', num2str(pi_value)]);
