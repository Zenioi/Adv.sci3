% Number of samples
N = 1000;

% Generate samples can use both AR & acceptance_rejection functions
[samples, X_all, U_all, accept_indices] = AR(N);
