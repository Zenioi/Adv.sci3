% Parameters
A0 = 20;          % Initial number of molecules
k = 0.1;          % Reaction rate constant (s^-1)
dt = 0.005;       % Time step (s)
Tmax = 50;        % Maximum simulation time (s)
numRuns = 100;    % Number of simulation runs

% Time vector
time = 0:dt:Tmax;
numSteps = length(time);

% Initialize array to store the results of each run
A_values = zeros(numRuns, numSteps);

% Perform the simulation for each run
for run = 1:numRuns
    % Initial number of molecules
    A = A0;
    for step = 1:numSteps
        % Store the current number of molecules
        A_values(run, step) = A;
        
        % Calculate the probability of a reaction in the next time step
        reactionProb = k * A * dt;
        
        % Generate a random number and determine if a reaction occurs
        if rand < reactionProb
            A = A - 1;
        end
        
        % Stop if all molecules are reacted
        if A <= 0
            A_values(run, step+1:end) = 0;
            break;
        end
    end
end

% Calculate the mean number of molecules over time
mean_A = mean(A_values, 1);

% Plot the results
figure;
hold on;

% Plot each run (different stochastic realizations)
for run = 1:numRuns
    stairs(time, A_values(run, :), 'LineWidth', 0.5);
end

% Plot the mean as a dashed line
plot(time, mean_A, 'k--', 'LineWidth', 2);

% Label the axes
xlabel('Time (sec)');
ylabel('Number of Molecules A');

% Set axis limits
xlim([0 Tmax]);
ylim([0 A0]);

% Add title and legend
title('Stochastic Simulation');
legend('Individual Runs', 'Mean Number of Molecules', 'Location', 'Northeast');

hold off;
