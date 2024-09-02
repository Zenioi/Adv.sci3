% SIR Model using Gillespie Algorithm
clear; close all;
% Parameters
N = 1000;          % Total population
I0 = 10;           % Initial number of infected individuals
S0 = N - I0;       % Initial number of susceptible individuals
R0int = 0;            % Initial number of recovered individuals
beta = 0.57;        % Infection rate
gamma = 1/7;       % Recovery rate
Tmax = 1000;        % Maximum simulation time

% Initialize variables
S = S0; I = I0; R = R0int;  % Initialize S, I, R
t = 0;                   % Start time
R0 = beta / gamma;
time = t;
S_all = S;
I_all = I;
R_all = R;

while t <= Tmax && I >= 0
    % Calculate propensities
    alpha1 = (beta * S * I) / N;  % Infection
    alpha2 = gamma * I;           % Recovery
    alpha0 = alpha1 + alpha2;     % Total rate
    
    % Generate random numbers
    r1 = rand;
    r2 = rand;
    
    % Calculate time to next reaction
    tau = -log(r1) / alpha0;
    
    % Determine which reaction occurs
    if r2 < alpha1 / alpha0
        % Infection event
        S = S - 1;
        I = I + 1;
    else
        % Recovery event
        I = I - 1;
        R = R + 1;
    end
    
    % Update time
    t = t + tau;
    
    % Store results
    time = [time; t];
    S_all = [S_all; S];
    I_all = [I_all; I];
    R_all = [R_all; R];
end

% Plot the results
figure;
plot(time, S_all, 'b-', 'LineWidth', 2);
hold on;
plot(time, I_all, 'r-', 'LineWidth', 2);
plot(time, R_all, 'g-', 'LineWidth', 2);
xlabel('Time');
ylabel('Number of Individuals');
legend('Susceptible', 'Infected', 'Recovered');
title(['SIR Model Simulation using Gillespie Algorithm (R0 = ', num2str(R0), ')']);
grid on;
