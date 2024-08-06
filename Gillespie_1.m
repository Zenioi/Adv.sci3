clear; close all;

% Parameters
A0 = 0;   % Initial number of molecules A
B0 = 0;   % Initial number of molecules B
k1 = 1e-3; % Rate constant for A + A -> ∅
k2 = 1e-2; % Rate constant for A + B -> ∅
k3 = 1.2;  % Rate constant for ∅ -> A
k4 = 1.0;  % Rate constant for ∅ -> B
Tmax = 180; % Maximum simulation time (s)
numRuns = 10; % Number of simulation runs

% Store the time and molecules for each run
time_all = cell(numRuns, 1);
A_all = cell(numRuns, 1);
B_all = cell(numRuns, 1);
max_len = 0;

for run = 1:numRuns
    t = 0;
    A = A0;
    B = B0;
    time = [];
    A_values = [];
    B_values = [];
    
    while t < Tmax
        % Store current values
        time = [time; t];
        A_values = [A_values; A];
        B_values = [B_values; B];
        
        % Propensity functions
        alpha1 = k1 * A * (A - 1) / 2; % A + A -> ∅
        alpha2 = k2 * A * B;           % A + B -> ∅
        alpha3 = k3;                   % ∅ -> A
        alpha4 = k4;                   % ∅ -> B
        alpha0 = alpha1 + alpha2 + alpha3 + alpha4;
        
        if alpha0 == 0
            break;
        end
        
        % Time to the next reaction
        r1 = rand;
        tau = -log(r1) / alpha0;
        t = t + tau;
        
        % Determine which reaction occurs
        r2 = rand;
        if r2 < alpha1 / alpha0
            A = A - 2;
        elseif r2 < (alpha1 + alpha2) / alpha0
            A = A - 1;
            B = B - 1;
        elseif r2 < (alpha1 + alpha2 + alpha3) / alpha0
            A = A + 1;
        else
            B = B + 1;
        end
        
        % Prevent negative molecule counts
        if A < 0
            A = 0;
        end
        if B < 0
            B = 0;
        end
    end
    
    % Store the results for each run
    time_all{run} = time;
    A_all{run} = A_values;
    B_all{run} = B_values;
    
    % Update max length for padding
    max_len = max(max_len, length(time));
end

% Interpolate data to a common time vector
common_time = linspace(0, Tmax, max_len);

% Preallocate arrays for interpolated data
A_interpolated = zeros(numRuns, max_len);
B_interpolated = zeros(numRuns, max_len);

for run = 1:numRuns
    A_interpolated(run, :) = interp1(time_all{run}, A_all{run}, common_time, 'previous', 'extrap');
    B_interpolated(run, :) = interp1(time_all{run}, B_all{run}, common_time, 'previous', 'extrap');
end

% Calculate the mean number of molecules over time for A and B
mean_A = mean(A_interpolated, 1);
mean_B = mean(B_interpolated, 1);

% Plot the results for A
figure;
subplot(1, 2, 1);
hold on;
for run = 1:numRuns
    plot(common_time, A_interpolated(run, :), 'Color', [0.5, 0.5, 0.5]);
end
% Plot mean values for A
plot(common_time, mean_A, 'r-', 'LineWidth', 2);
xlabel('Time (sec)');
ylabel('Number of Molecules A');
title('A');
legend('mean', 'Location', 'Northeast');
hold off;

% Plot the results for B
subplot(1, 2, 2);
hold on;
for run = 1:numRuns
    plot(common_time, B_interpolated(run, :), 'Color', [0.5, 0.5, 0.5]);
end
% Plot mean values for B
plot(common_time, mean_B, 'b-', 'LineWidth', 2);
xlabel('Time (sec)');
ylabel('Number of Molecules B');
title('B');
legend('mean', 'Location', 'Northeast');
hold off;
