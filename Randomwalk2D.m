% Parameters
n_steps = 1000; % Number of steps

% Initialize positions
x = zeros(1, n_steps);
y = zeros(1, n_steps);

% Create figure for position trajectories
figure;
hold on;
title('2D Random Walk: n\_steps =', num2str(n_steps));
xlabel('X position');
ylabel('Y position');
axis equal;

% Plot the starting point
plot(0, 0, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
text(0, 0, ' Start', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');

% Simulate random walks and plot trajectories
for step = 2:n_steps
    direction = randi(4); % Random direction: 1 = up, 2 = down, 3 = left, 4 = right
    switch direction
        case 1
            y(step) = y(step-1) + 1; % Move up
            x(step) = x(step-1);
        case 2
            y(step) = y(step-1) - 1; % Move down
            x(step) = x(step-1);
        case 3
            x(step) = x(step-1) - 1; % Move left
            y(step) = y(step-1);
        case 4
            x(step) = x(step-1) + 1; % Move right
            y(step) = y(step-1);
    end
    
    % Plot the current step
    plot(x(step-1:step), y(step-1:step), 'b');
    drawnow;
end

% Plot the final position
plot(x(end), y(end), 'go', 'MarkerSize', 10, 'MarkerFaceColor', 'g');
text(x(end), y(end), ' End', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');

hold off;
