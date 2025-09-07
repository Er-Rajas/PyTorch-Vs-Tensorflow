% Load real input CSV (ensure it has DATE_TIME, AMBIENT_TEMPERATURE, IRRADIATION)
data = readtable('D:\Project\Major Project\Energy Forecasting\data\temperature_irradiance_test.csv');

% Convert DATE_TIME column properly
data.DATE_TIME = datetime(data.DATE_TIME, 'InputFormat', 'yyyy-MM-dd''T''HH:mm');

% Basic cleaning (optional)
data = rmmissing(data);  % Remove rows with missing values

% Extract input variables
irradiation = data.IRRADIATION;
temperature = data.AMBIENT_TEMPERATURE;

% Parameters
Voc = 18.4;              % Open circuit voltage (V)
Isc = 1.65;              % Short circuit current (A)
Vmp = 15.3;
Imp = 1.57;

Ns = 1;                 % Number of cells in series
Np = 1;                  % Number of parallel strings
G_ref = 1000;            % Reference irradiance (W/m^2)
T_ref = 25;              % Reference temperature (for delta only)
alpha = 0.004;           % Temp coefficient of current
beta = -0.0023;          % Temp coefficient of voltage

% Initialize DC power output
dc_power = zeros(height(data), 1);

% Loop through time points and simulate
for i = 1:height(data)
    G = irradiation(i);
    T = temperature(i);
    
    % Skip if irradiance is zero (night)
    if G <= 0
        dc_power(i) = 0;
        continue;
    end

    % Calculate temperature and irradiance-adjusted parameters
    I = Imp * (G / G_ref) * (1 + alpha * (T - T_ref));
    V = Vmp * (1 + beta * (T - T_ref));
    
    % Approximate DC power output (simple PV model)
    P = I * V * Ns ;
    dc_power(i) = max(P, 0); % Avoid negative power
end

% Add to table
data.DC_POWER = dc_power;

% Feature Engineering
data.HOUR = hour(data.DATE_TIME);
data.MINUTE = minute(data.DATE_TIME);
data.HOUR_SIN = sin(2*pi*data.HOUR/24);
data.HOUR_COS = cos(2*pi*data.HOUR/24);
data.IS_NIGHT = double(data.HOUR < 6 | data.HOUR > 18);
data.DAWN_DUSK = double((data.HOUR >= 5 & data.HOUR < 7) | (data.HOUR >= 17 & data.HOUR <= 19));
data.DC_PER_IRR = data.DC_POWER ./ (data.IRRADIATION + 1e-3);

% Lag features
data.IRR_15MIN_AGO = [NaN; data.IRRADIATION(1:end-1)];
data.TEMP_30MIN_AGO = [NaN; NaN; data.AMBIENT_TEMPERATURE(1:end-2)];

% Time-based
data.DAY_OF_WEEK = weekday(data.DATE_TIME);
data.IS_WEEKEND = ismember(data.DAY_OF_WEEK, [1, 7]);

% Save the dataset
writetable(data, 'simulated_test.csv');
disp("Simulation complete! Dataset saved.");