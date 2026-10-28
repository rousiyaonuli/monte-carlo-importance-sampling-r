# monte-carlo-importance-sampling-r
Monte Carlo simulation, importance sampling and statistical computation in R.



# Bayesian Statistics — R Coursework

This repository contains R programming exercises completed as part of MATH3871 Bayesian Inference and Computation at UNSW Sydney.

The coursework focuses on implementing and comparing statistical sampling methods, including Monte Carlo integration, rejection sampling, importance sampling, and effective sample size (ESS).

Through these exercises, I developed practical experience in statistical computation, simulation-based estimation, and evaluating the efficiency of different sampling methods.

## Methods Implemented

- **Monte Carlo Integration:** Estimating integrals using randomly generated samples.
- **Rejection Sampling:** Generating samples from a target distribution using acceptance-rejection criteria.
- **Importance Sampling:** Using alternative proposal distributions and importance weights to estimate quantities of interest.
- **Effective Sample Size (ESS):** Evaluating the efficiency of weighted samples.
- **Two-Stage Importance Sampling:** Constructing a new proposal distribution using weighted samples from an initial sampling stage.

## Experimental Comparison

Compared three proposal distributions:

- Uniform
- Beta
- Normal

For the integral estimation experiment, I conducted 1,000 simulation replications with 5,000 samples per replication.

### Key Result

The Normal proposal achieved a **49.3% reduction in estimator standard deviation** compared with Uniform sampling in the tested setting.

This demonstrates how the choice of proposal distribution can substantially influence the efficiency of importance sampling.

In the two-stage importance sampling exercise, the second-stage proposal achieved an effective sample size (ESS) of approximately 193 out of 1,000 samples in one simulation run.

## Tools & Skills

- **Language:** R
- **Statistical Methods:** Monte Carlo Integration, Rejection Sampling, Importance Sampling
- **Evaluation:** Estimator Variability, Effective Sample Size (ESS)
- **Visualisation:** Density Plots, Histograms

## Files

- `3871lab4.R` — R implementations of the sampling algorithms and simulation experiments.

## Key Learning Outcomes

- Implementing statistical sampling algorithms from mathematical definitions
- Evaluating Monte Carlo estimation accuracy and variability
- Understanding the importance of proposal distribution selection
- Comparing sampling efficiency through repeated simulations and ESS
