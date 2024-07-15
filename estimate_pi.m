function pi_estimate = estimate_pi(N)
    % Initialize variables
    circle_points = 0;
    square_points = 0;
    
    % Arrays to store points for plotting
    x_inside = [];
    y_inside = [];
    x_outside = [];
    y_outside = [];
    
    for i = 1:N
        % Generate random points x and y
        x = rand();
        y = rand();
        
        % Calculate distance from origin
        d = x^2 + y^2;
        
        % Check if the point is inside the circle
        if d <= 1
            circle_points = circle_points + 1;
            x_inside = [x_inside, x];
            y_inside = [y_inside, y];
        else
            x_outside = [x_outside, x];
            y_outside = [y_outside, y];
        end
        
        % Increment square points (every point is inside the square)
        square_points = square_points + 1;
    end
    
    % Estimate pi
    pi_estimate = 4 * (circle_points / square_points);
    
    % Plot the points
    figure;
    hold on;
    plot(x_inside, y_inside, 'g.', 'MarkerSize', 5);
    plot(x_outside, y_outside, 'r.', 'MarkerSize', 5);
    rectangle('Position', [0, 0, 1, 1], 'EdgeColor', 'b');
    theta = linspace(0, pi/2, 100);
    plot(cos(theta), sin(theta), 'b-');
    axis equal;
    title(['\pi with ', num2str(N), ' iterations = ', num2str(pi_estimate)]);
    xlabel('x');
    ylabel('y');
    legend('Inside Circle', 'Outside Circle', 'Unit Square', 'Quarter Circle');
    hold off;
end