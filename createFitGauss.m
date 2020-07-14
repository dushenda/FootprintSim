function [fitresult, gof, xData, yData, zData] = createFitGauss(X, Y, Z)
    [xData, yData, zData] = prepareSurfaceData( X, Y, Z );
%     gauss2DEqn = '2*pi*a*b*sqrt(1-c^2)*exp((-1/(2*(1-c^2)))*((x-d)^2/a^2-2*c*(x-d)*(y-e)/(a*b)+(y-e)^2/b^2))';
    % Set up fittype and options.
    ft = fittype( 'loess' );
% [fitresult, gof] = fit([xData,yData],zData,gauss2DEqn);
    
    % Fit model to data.
    [fitresult, gof] = fit( [xData, yData], zData, ft, 'Normalize', 'on' );
    
    % Plot fit with data.
    figure( 'Name', 'untitled fit 1' );
    h = plot( fitresult, [xData, yData], zData );
    legend( h, 'Local linear regression (surface)', 'Power', 'Location', 'NorthEast', 'Interpreter', 'none' );
    % Label axes
    xlabel( 'X', 'Interpreter', 'none' );
    ylabel( 'Y', 'Interpreter', 'none' );
    zlabel( 'Z', 'Interpreter', 'none' );
    grid on
    
    
