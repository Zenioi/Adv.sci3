function [samples, X_all, U_all, accept_indices] = acceptance_rejection(N)
    samples = [];
    X_all = [];
    U_all = [];
    accept_indices = [];

    % Constants
    C = sqrt(1 / (pi*2));

    % Target distribution: Standard Normal Distribution
    f = @(x) (1 / sqrt(2 * pi)) * exp(-0.5 * x.^2);

    % Proposal distribution: Uniform Distribution
    g = @(x) exp(0.00001 * x.^2);

    while length(samples) < N
        X = rand() * 10 - 5; % Sample from uniform distribution U(-5,5)
        U = rand(); % Sample from uniform distribution U(0,1)
        
        X_all = [X_all, X];
        U_all = [U_all, U];
        
        if U <= f(X) / (C * g(X))
            samples = [samples, X];
            accept_indices = [accept_indices, true];
        else
            accept_indices = [accept_indices, false];
        end
    end

    % Plot the target distribution
    x = linspace(-5, 5, 1000);
    plot(x, f(x), 'k', 'LineWidth', 2);
    hold on;

    % Plot accepted and rejected samples
    accepted_samples = X_all(logical(accept_indices));
    rejected_samples = X_all(~logical(accept_indices));
    accepted_U = U_all(logical(accept_indices)) * C;
    rejected_U = U_all(~logical(accept_indices)) * C;

    scatter(accepted_samples, accepted_U, 'bo');
    scatter(rejected_samples, rejected_U, 'rx');

    % Add labels and legend
    legend('target', 'accept', 'reject');
    title('Acceptance-Rejection Method for Normal Distribution');
    xlabel('x');
    ylabel('target(x)');
    hold off;
end
