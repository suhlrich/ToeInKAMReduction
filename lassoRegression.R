library(glmnet)
library(selectiveInference)
library(Rmpfr)

# Set working directory
setwd("W:/OA_GaitRetraining/Matlab/R/KAMreducerAnalysis/forGithub")

# # # # End of User Inputs # # # # # #

# Load X and y matrices
X <- read.csv("X_TIdiff.csv",sep=",",header = FALSE)
y <- read.csv("y_TIP1diff.csv",sep=",",header = FALSE)

X_unscaled = data.matrix(X, rownames.force = NA)
y = data.matrix(y, rownames.force = NA) 
nSubs = length(y)

# Scale inputs
X = scale(X_unscaled)


# # # # # # # LASSO # # # # # # #

fit = glmnet(X,y,standardize=FALSE)
plot(fit)
fit

# 10-fold cross-validation to select lambda that is 1 standard
# error from the lambda that minimizes prediction error (lambda.1se)
seedSequence <- 1:10
count <- 0
lambdaVec <- matrix(0, nrow = 10, ncol = 1)
for (i in seedSequence) {
  i
  set.seed(i)  
  lambdaVec[i,1] <- cv.glmnet(X,y)$lambda.1se
  cFit= cv.glmnet(X,y)
  plot(cFit)
}
lambda_mean = mean(lambdaVec)
lambda_mean
lambda=lambda_mean

# Identify selected coefficients
selectedCoeffs = coef(fit, s =lambda,exact=TRUE,x=X,y=y)[-1]

# estimate sigma
sigmaEst = estimateSigma(X, y, intercept=TRUE, standardize=FALSE)

# compute fixed lambda p-values and selection intervals
out = fixedLassoInf(X,y,selectedCoeffs,lambda*nSubs,alpha=0.05,sigma = sigmaEst$sigmahat)
out


# # # MULTIPLE REGRESSION WITH REMAINING COVARIATES FROM LASSO # # # # 
selectedCovariates = which(selectedCoeffs!=0)

# Model with all selected covariates
multReg <- lm(y ~  X[,selectedCovariates])
summaryMetrics = summary(multReg)
summaryMetrics
adjustedR2_full = summaryMetrics$adj.r.squared

# Model with covariates removed
deltaR2 = matrix(data=NA,nrow=length(selectedCovariates),ncol=1)
for (i in 1:length(selectedCovariates)) {
  covariateSubset = selectedCovariates[selectedCovariates!=selectedCovariates[i]]
  multReg <- lm(y ~  X[,covariateSubset])
  deltaR2[i] = adjustedR2_full - summary(multReg)$adj.r.squared 
}

# Print R^2 for full model and delta R^2 values for each covariate removed from model
adjustedR2_full
selectedCovariates
deltaR2



