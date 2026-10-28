#Q1a
N <- 5000

#sample from g1=uniform(0,1)
x <- runif(N)

# importance weights & normalization
w <- x^2*exp(-x)
w <- w/sum(w)

# resample according to the importance weights 
#sample()是 R 里“从一堆东西里面抽取”的函数。

sample_f <- sample(x, size = N, replace = TRUE, prob = w)

#b
x_rej <- runif(N)
u <- runif(N)
k <- exp(-1)

accept <- u <= (x_rej^2*exp(-x_rej))/k
sample_rej <- x_rej[accept]

plot(density(sample_f),
     main = "Importance vs Rejection Sampling",
     xlab = "x")

lines(density(sample_rej))

mean(sample_f)
mean(sum(w * x))
mean(sample_rej)


#c
u <- runif(N)
x2 <- sqrt(u)

w2 <- 1/2*(x2*exp(-x2))
w2 <- w2/sum(w2)

sample_g2 <- sample(x2, N, replace= TRUE, prob=w2)

ees_g2 <- 1/sum(w2^2)
ees_g1 <- 1/sum(w^2)

ees_g1
ees_g2




# Q2a
N <- 5000

# sample from g1(u) = Uniform(0,1)
u <- runif(N)

# transformed integrand
f_prime <- 2/u^2 * exp(-(1/u - 1)^2)

# importance sampling estimate
I_hat <- mean(f_prime)

I_hat

# Q2b

# sample from g2 = Beta(2, 1.2)
u2 <- rbeta(N, shape1 = 2, shape2 = 1.2)

# transformed integrand
f_prime2 <- 2/u2^2 * exp(-(1/u2 - 1)^2)

# density of sampling distribution
g2 <- dbeta(u2, shape1 = 2, shape2 = 1.2)

# importance weights
w2 <- f_prime2 / g2

# estimate integral
I_hat2 <- mean(w2)

I_hat2

u_grid <- seq(0.001, 0.999, length.out = 1000)

f_grid <- 2/u_grid^2 * exp(-(1/u_grid - 1)^2)

g1_grid <- dunif(u_grid, 0, 1)

g2_grid <- dbeta(u_grid, 2, 1.2)

plot(u_grid, f_grid, type = "l",
     xlab = "u", ylab = "Density")

lines(u_grid, g1_grid,col=3)

lines(u_grid, g2_grid,col=2)

#c
N<-5000
x <- rnorm(N)
fx <- exp(-x^2)
g3x <- (1/sqrt(2*pi))*exp(-(x^2/2))
#or g3x <- ?dnorm(x,0,1)
i_hat3 <- mean(fx/g3x)

curve(exp(-x^2), from = -4, to = 4,
      xlab = "x", ylab = "Density")

curve(dnorm(x), from = -4, to = 4,
      add = TRUE,col=2)

#d(tmd)
N <- 5000
nrep <- 1000

estimate_c <- replicate(nrep, {
  
  x <- rnorm(N)
  
  fx <- exp(-x^2)
  
  g3x <- dnorm(x)
  
  mean(fx/g3x)
  
})

estimate_b <- replicate(nrep, {
  u2 <- rbeta(N, shape1 = 2, shape2 = 1.2)


  f_prime2 <- 2/u2^2 * exp(-(1/u2 - 1)^2)


  g2 <- dbeta(u2, shape1 = 2, shape2 = 1.2)


  w2 <- f_prime2 / g2

  I_hat2 <- mean(w2)})


estimate_a <- replicate(nrep, {u <- runif(N)


f_prime <- 2/u^2 * exp(-(1/u - 1)^2)


I_hat <- mean(f_prime)})
sd(estimate_a)
sd(estimate_b)
sd(estimate_c)

sd_uniform <- sd(estimate_a)
sd_normal <- sd(estimate_c)

reduction <- (sd_uniform - sd_normal) / sd_uniform * 100

reduction
#3a
N <- 5000
x1 <- rt(N, df=3)
iihat1 <- mean(abs(x1))

x2 <- rt(N,df=1)
g2 <- dt(x2,df=1)
f2 <- abs(x2)*dt(x2,df=3)
iihat2 <- mean(f2/g2)

x3 <- rnorm(N,0,1)
f3 <- abs(x3)*dt(x3,df=3)
g3 <- dnorm(x3,0,1)
iihat3 <- mean(f3/g3)

#b
# Q3b
x <- seq(-6, 6, length.out = 1000)

# Four functions
f <- abs(x) * dt(x, df = 3)
t3 <- dt(x, df = 3)
t1 <- dt(x, df = 1)
phi <- dnorm(x)

# Plot the target integrand
plot(x, f, type = "l", col = "black", lwd = 2,
     ylim = c(0, 0.45),
     xlab = "x", ylab = "Density / Integrand",
     main = "Comparison of Sampling Distributions")

# Add sampling densities
lines(x, t3, col = "blue", lwd = 2)
lines(x, t1, col = "red", lwd = 2)
lines(x, phi, col = "green", lwd = 2)

legend("topright",
       legend = c("|x|t3(x)", "t3(x)", "t1(x)", "Normal(0,1)"),
       col = c("black", "blue", "red", "green"),
       lty = 1, lwd = 2)

#3c
w1 <- abs(x1)
w1 <- w1/sum(w1)
ESS1 <- 1/sum(w1^2)

w2 <- f2/g2
w2 <- w2/sum(w2)
ESS2 <- 1/sum(w2^2)
w3 <- f3/g3
w3 <- w3/sum(w3)
ESS3 <- 1/sum(w3^2)

ESS1
ESS2
ESS3

par(mfrow = c(1, 3))

hist(w1, main = "Method 1: t3",
     xlab = "Normalized weights")

hist(w2, main = "Method 2: t1",
     xlab = "Normalized weights")

hist(w3, main = "Method 3: Normal",
     xlab = "Normalized weights")

par(mfrow = c(1, 1))




# Q4(a)
N <- 5000

# 1. Sample from g(theta) = U(0,1)
theta <- runif(N)

# 2. Calculate target density f(theta)
f <- dnorm(theta, mean = 0.5, sd = 0.01)

# 3. Calculate sampling density g(theta)
g <- dunif(theta, min = 0, max = 1)

# 4. Importance weights
w <- f/g

# 5. Normalize weights
w <- w/sum(w)

# 6. Effective sample size
ESS <- 1/sum(w^2)
ESS

# Q4(b)

N <- 1000
ESS <- 0

while (ESS <= 5000) {
  
  theta <- runif(N)
  
  f <- dnorm(theta, mean = 0.5, sd = 0.01)
  g <- dunif(theta, 0, 1)
  
  w <- f/g
  w <- w/sum(w)
  
  ESS <- 1/sum(w^2)
  
  N <- N + 1000
}

N - 1000
ESS


# Q4(c) Stage 1
N <- 1000

# Sample from Uniform(0,1)
theta1 <- runif(N)

# Calculate first-stage weights
f1 <- dnorm(theta1, mean = 0.5, sd = 0.01)^0.02
g1 <- dunif(theta1, 0, 1)

w1 <- f1/g1
w1 <- w1/sum(w1)

# Calculate weighted mean and SD
mu_w <- sum(w1 * theta1)
sd_w <- sqrt(sum(w1 * (theta1 - mu_w)^2))

# Resample according to weights
sample_stage1 <- sample(theta1, size = N,
                        replace = TRUE, prob = w1)

# Histogram
hist(sample_stage1, probability = TRUE,
     main = "Stage 1 Sampling",
     xlab = "theta",
     col = "lightgray")

# Grid for density curves
theta_grid <- seq(0, 1, length.out = 1000)

# Original target
lines(theta_grid,
      dnorm(theta_grid, 0.5, 0.01),
      col = "blue", lwd = 2)

# First-stage target, normalized over [0,1]
h <- dnorm(theta_grid, 0.5, 0.01)^0.02
h <- h / (sum(h) * (theta_grid[2] - theta_grid[1]))

lines(theta_grid, h, col = "red", lwd = 2)

# Uniform sampling density
lines(theta_grid,
      dunif(theta_grid, 0, 1),
      col = "green", lwd = 2)

legend("topright",
       legend = c("Original f", "First-stage target", "Uniform"),
       col = c("blue", "red", "green"),
       lty = 1, lwd = 2)


# Create a grid for plotting
theta_grid <- seq(0, 1, length.out = 1000)

# Plot target density
plot(theta_grid,
     dnorm(theta_grid, mean = 0.5, sd = 0.01),
     type = "l",
     col = "blue",
     lwd = 2,
     main = "Target vs Sampling Density",
     xlab = "theta",
     ylab = "Density")

# Add sampling density
lines(theta_grid,
      dunif(theta_grid, 0, 1),
      col = "red",
      lwd = 2)

legend("topright",
       legend = c("Target: Normal", "Sampling: Uniform"),
       col = c("blue", "red"),
       lty = 1,
       lwd = 2)

# Q4(c) Stage 2

# Sample from new Normal proposal
theta2 <- rnorm(N, mean = mu_w, sd = sd_w)

# Original target density
f2 <- dnorm(theta2, mean = 0.5, sd = 0.01)

# New sampling density
g2 <- dnorm(theta2, mean = mu_w, sd = sd_w)

# Importance weights
w2 <- f2/g2
w2 <- w2/sum(w2)

# Effective sample size
ESS2 <- 1/sum(w2^2)
ESS2

