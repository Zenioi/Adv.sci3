% Parameters
N_walker = 1000;
n_steps = 1000;

% Initialize positions
positions = zeros(N_walker, n_steps);

% Create figure for position trajectories
figure;
trajectories_plot = gobjects(N_walker, 1); % Initialize an array of graphic objects
hold on;
for walker = 1:N_walker
    trajectories_plot(walker) = plot(zeros(1, n_steps));
end
xlabel('Number of steps (n)');
ylabel('Position (x)');

% Plot for mean position <x>
mean_position_plot = plot(zeros(1, n_steps), 'k', 'LineWidth', 2);

% Create figure for mean square displacement
figure;
mean_square_disp_plot = plot(zeros(1, n_steps));
%title('Mean square displacement <x^2> vs Number of steps (n)');
xlabel('Number of steps (n)');
ylabel('Mean square displacement <x^2>');
hold on;

% Simulate random walks and update plots dynamically
for step = 1:n_steps
    for walker = 1:N_walker
        if rand() > 0.5
            positions(walker, step) = positions(walker, max(step-1,1)) + 1;
        else
            positions(walker, step) = positions(walker, max(step-1,1)) - 1;
        end
    end
    
    % Update trajectories plot
    figure(1);
    for walker = 1:N_walker
        set(trajectories_plot(walker), 'YData', positions(walker, 1:step));
        set(trajectories_plot(walker), 'XData', 1:step);
    end
    
    % Calculate mean position and update plot
    mean_position = mean(positions(:, 1:step), 1);
    set(mean_position_plot, 'YData', mean_position);
    set(mean_position_plot, 'XData', 1:step);
    
    % Update the title with the current mean position <x>
    %title(['N\_walkers = ', num2str(N_walker), ' , n\_steps = ', num2str(n_steps), ' , <x> = ', num2str(mean(mean_position))]);

    drawnow;
    
    % Calculate and update mean square displacement
    mean_square_disp = mean(positions(:, 1:step).^2, 1);
    figure(2);
    set(mean_square_disp_plot, 'YData', mean_square_disp);
    set(mean_square_disp_plot, 'XData', 1:step);
    drawnow;
end

% Use the final value of mean square displacement as the variance
final_variance = mean_square_disp(end); 

% Update the title of the mean square displacement plot with the final variance
figure(2);
title(['N\_walkers = ', num2str(N_walker), ' , n\_steps = ', num2str(n_steps), ' , <x^2> = ', num2str(final_variance)]);

% Plot histogram of positions at the final step
figure;
histogram(positions(:, end), 'Normalization', 'count');
title(['Positions of ', num2str(N_walker), ' walkers after ', num2str(n_steps), ' steps']);
xlabel('Position');
ylabel('Number of particles');

hold off;

% Calculate and display the number of walkers that moved more than the number of steps
walkers_exceeding_steps = sum(abs(positions(:, end)) > n_steps);
disp(['Number of walkers that moved more than ', num2str(n_steps), ' steps: ', num2str(walkers_exceeding_steps)]);
