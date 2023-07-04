% MathVisualizer

% Generate x values from -10 to 10
x = linspace(-10, 10, 100);

% Define the functions to visualize
y1 = sin(x);
y2 = cos(x);
y3 = tan(x);

% Plot the functions with advanced features
figure;
hold on;
plot(x, y1, 'r', 'LineWidth', 2);
plot(x, y2, 'g', 'LineWidth', 2);
plot(x, y3, 'b', 'LineWidth', 2);
xlabel('x');
ylabel('y');
title('Math Visualizer');
legend('sin(x)', 'cos(x)', 'tan(x)');
grid on;
hold off;

% Add advanced features
% Add data markers to the plots
set(gca, 'Marker', 'o', 'MarkerSize', 5);

% Add annotations to specific points on the plot
annotation('textarrow', [0.2 0.3], [0.6 0.5], 'String', 'Maxima Point');
annotation('textarrow', [0.6 0.7], [0.2 0.3], 'String', 'Minima Point');

% Add a draggable legend to reposition it on the plot
[~,icons,plots,~] = legend('sin(x)', 'cos(x)', 'tan(x)');
draggable(icons(1:3), plots(1:3));

% Save the plot as an image file
saveas(gcf, 'math_visualization.png');

% Add interactive features
% Enable zooming and panning
zoom on;
pan on;

% Add tooltips to the data points
dcm_obj = datacursormode(gcf);
set(dcm_obj, 'DisplayStyle', 'window', 'SnapToDataVertex', 'on');
set(dcm_obj, 'UpdateFcn', @tooltipFunction);

% Custom tooltip function to display x and y coordinates
function txt = tooltipFunction(~, event_obj)
    pos = get(event_obj, 'Position');
    txt = {['x: ' num2str(pos(1))], ['y: ' num2str(pos(2))]};
end

% Add interactive controls
% Create sliders to adjust the parameters of the functions
sliderFigure = figure;
sliderFigure.Position(3:4) = [300 200];
amplitudeSlider = uicontrol('Style', 'slider', 'Min', 0, 'Max', 2, 'Value', 1, 'Position', [20 150 260 20]);
frequencySlider = uicontrol('Style', 'slider', 'Min', 0, 'Max', 10, 'Value', 1, 'Position', [20 100 260 20]);
phaseSlider = uicontrol('Style', 'slider', 'Min', 0, 'Max', 2*pi, 'Value', 0, 'Position', [20 50 260 20]);

% Add a callback function to update the plot when sliders are adjusted
addlistener(amplitudeSlider, 'Value', 'PostSet', @updatePlot);
addlistener(frequencySlider, 'Value', 'PostSet', @updatePlot);
addlistener(phaseSlider, 'Value', 'PostSet', @updatePlot);

% Callback function to update the plot based on slider values
function updatePlot(~,~)
    amplitude = get(amplitudeSlider, 'Value');
    frequency = get(frequencySlider, 'Value');
    phase = get(phaseSlider, 'Value');
    
    % Update the functions with new parameters
    y1 = amplitude * sin(frequency * x + phase);
    y2 = amplitude * cos(frequency * x + phase);
    y3 = amplitude * tan(frequency * x + phase);
    
    % Update the plot
    set(0, 'CurrentFigure', 1);
    set(gca, 'NextPlot', 'replacechildren');
    plot(x, y1, 'r', 'LineWidth', 2);
    plot(x, y2, 'g', 'LineWidth', 2);
    plot(x, y3, 'b', 'LineWidth', 2);
end
