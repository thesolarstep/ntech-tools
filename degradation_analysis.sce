// Time (min) 
t = [5, 15, 30, 45, 60]; // Modify as per data

// Absorbance at each time (At)
At = [0.108, 0.048, 0.019, 0.018, 0.001]; // Modify as per data

// Initial absorbance (A0 = at x min in your data)
A0 = 0.02; // Modify as per data

// Degradation % at each time
degradation_percent = ((A0 - At) ./ A0) * 100;

// Degradation efficiency = % at final time
degradation_efficiency = degradation_percent($);

// Plot: Degradation Curve
scf(0);
plot(t, At, '-o');
xlabel("Time (min)");
ylabel("Absorbance (At)");
title("Degradation Curve");

// Plot: Degradation % over time
scf(1);
plot(t, degradation_percent, 'r-o');
xlabel("Time (min)");
ylabel("Degradation %");
title("Degradation Percentage Over Time");

// First-order kinetics: ln(At) vs t
ln_At = log(At);
scf(2);
plot(t, ln_At, 'g-o');
xlabel("Time (min)");
ylabel("ln(At)");
title("First-Order Kinetics Plot");

// Estimate rate constant k from slope of ln(At) vs t
coeff = polyfit(t', ln_At', 1); // linear fit
k = -coeff(1); // rate constant

// Half-life calculation
t_half = log(2) / k;

// Display results
disp("Rate constant (k): " + string(k) + " min^-1");
disp("Half-life (t1/2): " + string(t_half) + " min");
disp("Degradation Efficiency: " + string(degradation_efficiency) + " %");

for i = 1:length(t)
    mprintf("Time: %d min | At: %.3f | Degradation %%: %.2f\n", t(i), At(i), degradation_percent(i));
end

// Optional enzyme kinetics (Michaelis-Menten simulation)
Vmax = 1;
Km = 0.03; // assumed
v_reaction = Vmax .* At ./ (Km + At);

scf(3);
plot(At, v_reaction, 'm-x');
xlabel("Substrate Absorbance (At)");
ylabel("Reaction Rate (v)");
title("Michaelis-Menten Approximation");
