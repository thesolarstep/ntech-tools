All data processing and kinetic modeling were conducted using SciLab, enabling numerical analysis
and curve fitting for precise parameter estimation. The following SciLab script was developed for
enlisted purposes.

1. Degradation % at each time.
2. Degradation efficiency.
3. Estimate rate constant k from slope of ln(At) vs t.
4. Half life calculation.
5. Optional enzyme kinetics (Michaelis-Menten simulation)
6. Plot: First-order kinetics: ln(At) vs t
7. Plot: Degradation Curve

The code was structured to input empirical constants derived from experimental results and to simulate
the system under varying conditions.

The code runs by applying the following kinetic equations.

a. Degradation Percentage

Degradation % = ((A0 − At) / A0) × 100

A0 = Initial Absorbance  
At = Absorbance at time t  

This represents the percent degradation of the compound over time.

b. First-Order Reaction Kinetics

ln(At) = ln(A0) - kt

Rearranged to fit a linear model:

ln(At) = −kt + ln(A0)

Used to:
- Plot ln(At) vs t  
- Estimate rate constant k from the slope of the linear regression  

c. Half-Life of First-Order Reaction

t1/2 = ln(2) / k

Represents the time required for the concentration (or absorbance) to reduce by half.

d. Michaelis-Menten Equation

v = (Vmax × [S]) / (Km + [S])

Where,
v = Rate of reaction  
Vmax = Maximum rate of reaction  
[S] = Substrate concentration (may be approximated by absorbance At)  
Km = Michaelis constant (substrate concentration at half-max rate)  

This equation models enzyme-substrate interaction assuming At ∝ [S]

353.2.8.1 SciLab Code

// Time (min)
t = [5, 15, 30, 45, 60];

// Absorbance at each time (At)
At = [0.108, 0.048, 0.019, 0.018, 0.001];

// Initial absorbance (A0 = at 5 min in your data)
A0 = 0.02;

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
    mprintf("Time: %d min | At: %.3f | Degradation %%: %.2f\n", ...
            t(i), At(i), degradation_percent(i));
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
