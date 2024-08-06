clear; close all;
% Parameters
A0 = 20;          % Initial number of molecules
k = 0.1;          % Reaction rate constant (s^-1)
dt = 0.005;       % Time step for SSA (s)
Tmax = 50;        % Maximum simulation time (s)
numRuns = 100;    % Number of simulation runs

% Time vector for SSA
time_ssa = 0:dt:Tmax;
numSteps_ssa = length(time_ssa);

% Initialize array to store the results of each SSA run
A_values_ssa = zeros(numRuns, numSteps_ssa);

% Perform SSA simulation for each run
for run = 1:numRuns
    A = A0;
    for step = 1:numSteps_ssa
        A_values_ssa(run, step) = A;
        reactionProb = k * A * dt;
        if rand < reactionProb
            A = A - 1;
        end
        if A <= 0
            A_values_ssa(run, step+1:end) = 0;
            break;
        end
    end
end

% Calculate the mean number of molecules over time for SSA
mean_A_ssa = mean(A_values_ssa);

% Gillespie Algorithm simulation
time_gillespie_all = [];
A_values_gillespie_all = [];
A = A0;
t = 0;
time_g = [];
A_g = [];
while A >= 0
    time_g = [time_g; t]; % Store time
    A_g = [A_g; A];       % Store number of molecules

    r = rand;
    tau = -log(r) / (A * k);  % Calculate time to next reaction
    t = t + tau;
    A = A - 1;
end
    

% Plot the results
figure;
hold on;

% Plot SSA individual runs
for run = 1:numRuns
    stairs(time_ssa, A_values_ssa(run, :), 'LineWidth', 0.5);
end

% Plot mean SSA result (Black dashed line)
plot(time_ssa, mean_A_ssa, 'k--', 'LineWidth', 2);

% Plot mean Gillespie result (Red dashed line)
plot(time_g, A_g, 'r--', 'LineWidth', 2);

% Label the axes
xlabel('Time (sec)');
ylabel('Number of Molecules A');

% Set axis limits
xlim([0 Tmax]);
ylim([0 A0]);

% Add title and legend
title('Comparison of SSA and Gillespie Algorithm');
%legend('Individual Runs (SSA)', 'Mean (SSA)', 'Mean (Gillespie)', 'Location', 'Northeast');

hold off;
