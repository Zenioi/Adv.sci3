% Number of Monte Carlo simulations
num_simulations = 10000;

% Simulate rolling two dice
dice1 = randi(6, num_simulations, 1); % Roll for first die
dice2 = randi(6, num_simulations, 1); % Roll for second die

% Sum of the two dice
sum_of_dice = dice1 + dice2;

% Calculate the frequency of each possible sum (2 to 12)
simulated_counts = histcounts(sum_of_dice, 1.5:1:12.5);
simulated_probabilities = simulated_counts / num_simulations;

% Manually input probabilities for comparison
manual_probabilities = [1, 2, 8, 11, 17, 13, 12, 13, 12, 8, 3] / 100;

% Exact theoretical probabilities for each sum
exact_probabilities = [1, 2, 3, 4, 5, 6, 5, 4, 3, 2, 1] / 36;

% Possible sums
possible_sums = 2:12;

% Plot the histogram of the simulation results
figure;
bar(possible_sums, simulated_probabilities, 'b', 'DisplayName', 'Simulation', 'BarWidth', 0.6);
hold on;

% Plot the manual probabilities
plot(possible_sums, manual_probabilities, 'ro-', 'LineWidth', 2, 'DisplayName', 'Manual');
% Plot the sim probabilities
plot(possible_sums, simulated_probabilities, 'bo-', 'LineWidth', 2, 'DisplayName', 'simulated');
plot(possible_sums, exact_probabilities, 'go-', 'LineWidth', 2, 'DisplayName', 'Exact');

% Labels and legend
xlabel('Sum of Two Dice');
ylabel('Probability');
title('Monte Carlo Simulation vs Manual Probabilities');
legend('show');
hold off;
