
> library(lavaan)
This is lavaan 0.6-19
lavaan is FREE software! Please report any bugs.
> your_data <- read.csv("Desktop/7.csv", sep = ";")
> model_cfa <- '
+   engagement =~ E1 + E2 + E3 + E4 + E5
+   ai_perception =~ AI1 + AI2 + AI3 + AI4 + AI5
+   loyalty =~ L1 + L2 + L3 + L4 + L5
+ '
> library(semTools)
 
###############################################################################
This is semTools 0.5-7
All users of R (or SEM) are invited to submit functions or ideas for functions.
###############################################################################
> reliability(fit_cfa)
       Engagement        AI   Loyalty
alpha   0.9384119 0.8213438 0.9464446
omega   0.9411207 0.8404341 0.9499145
omega2  0.9411207 0.8404341 0.9499145
omega3  0.9446198 0.8606620 0.9476213
avevar  0.7629156 0.5234915 0.7942527
Warning message:
In reliability(fit_cfa) : 
The reliability() function was deprecated in 2022 and will cease to be included in future versions of semTools. See help('semTools-deprecated) for details.

It is replaced by the compRelSEM() function, which can estimate alpha and model-based reliability in an even wider variety of models and data types, with greater control in specifying the desired type of reliability coefficient (i.e., more explicitly choosing assumptions). 

The average variance extracted should never have been included because it is not a reliability coefficient. It is now available from the AVE() function.
> fitMeasures(fit_cfa, c("cfi", "tli", "rmsea", "srmr"))
  cfi   tli rmsea  srmr 
0.757 0.707 0.220 0.113 
> modindices(fit_cfa, sort = TRUE, minimum.value = 10)
           lhs op rhs     mi    epc sepc.lv sepc.all sepc.nox
161        AI5 ~~  L5 53.098  0.741   0.741    0.608    0.608
136        AI2 ~~ AI3 46.151  0.430   0.430    0.837    0.837
142        AI2 ~~  L4 45.064  0.323   0.323    0.643    0.643
66     Loyalty =~ AI5 30.033  0.444   0.524    0.473    0.473
143        AI2 ~~  L5 25.967 -0.452  -0.452   -0.450   -0.450
102         E3 ~~  L2 25.429 -0.171  -0.171   -0.575   -0.575
155        AI4 ~~  L4 23.557 -0.146  -0.146   -0.527   -0.527
101         E3 ~~  L1 23.472  0.149   0.149    0.486    0.486
131        AI1 ~~  L1 22.108  0.149   0.149    0.444    0.444
137        AI2 ~~ AI4 21.359 -0.224  -0.224   -0.638   -0.638
86          E2 ~~ AI3 19.643 -0.254  -0.254   -0.430   -0.430
82          E2 ~~  E4 18.135  0.260   0.260    0.572    0.572
95          E3 ~~  E5 16.815  0.298   0.298    0.427    0.427
147        AI3 ~~  L2 15.021 -0.119  -0.119   -0.464   -0.464
134        AI1 ~~  L4 13.429 -0.173  -0.173   -0.339   -0.339
158        AI5 ~~  L2 13.275 -0.149  -0.149   -0.383   -0.383
132        AI1 ~~  L2 13.259  0.127   0.127    0.391    0.391
133        AI1 ~~  L3 13.015 -0.138  -0.138   -0.324   -0.324
41  Engagement =~ AI5 11.744 -0.224  -0.299   -0.270   -0.270
130        AI1 ~~ AI5 11.637 -0.231  -0.231   -0.294   -0.294
64     Loyalty =~ AI3 11.468 -0.219  -0.259   -0.220   -0.220
154        AI4 ~~  L3 11.322  0.082   0.082    0.356    0.356
125         E5 ~~  L4 10.728  0.183   0.183    0.309    0.309
56          AI =~  L5 10.036 -0.613  -0.409   -0.212   -0.212
> model_cfa_mod <- '
+   engagement =~ E1 + E2 + E3 + E4 + E5
+   ai_perception =~ AI1 + AI2 + AI3 + AI4 + AI5
+   loyalty =~ L1 + L2 + L3 + L4 + L5
+ 
+   # коррелирующие ошибки
+   AI5 ~~ L5
+   AI2 ~~ AI3
+   AI2 ~~ L4
+   E2 ~~ E4
+   E3 ~~ E5
+ '
> 
> fit_mod <- cfa(model_cfa_mod, data = your_data)
> summary(fit_mod, fit.measures = TRUE, standardized = TRUE)
lavaan 0.6-19 ended normally after 42 iterations

  Estimator                                         ML
  Optimization method                           NLMINB
  Number of model parameters                        38

                                                  Used       Total
  Number of observations                           235         236

Model Test User Model:
                                                      
  Test statistic                               268.617
  Degrees of freedom                                82
  P-value (Chi-square)                           0.000

Model Test Baseline Model:

  Test statistic                              3406.895
  Degrees of freedom                               105
  P-value                                        0.000

User Model versus Baseline Model:

  Comparative Fit Index (CFI)                    0.943
  Tucker-Lewis Index (TLI)                       0.928

Loglikelihood and Information Criteria:

  Loglikelihood user model (H0)              -4911.914
  Loglikelihood unrestricted model (H1)      -4777.605
                                                      
  Akaike (AIC)                                9899.827
  Bayesian (BIC)                             10031.291
  Sample-size adjusted Bayesian (SABIC)       9910.847

Root Mean Square Error of Approximation:

  RMSEA                                          0.098
  90 Percent confidence interval - lower         0.085
  90 Percent confidence interval - upper         0.112
  P-value H_0: RMSEA <= 0.050                    0.000
  P-value H_0: RMSEA >= 0.080                    0.990

Standardized Root Mean Square Residual:

  SRMR                                           0.046

Parameter Estimates:

  Standard errors                             Standard
  Information                                 Expected
  Information saturated (h1) model          Structured

Latent Variables:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
  engagement =~                                                         
    E1                1.000                               1.141    0.806
    E2                1.054    0.083   12.694    0.000    1.203    0.777
    E3                1.174    0.079   14.777    0.000    1.340    0.847
    E4                1.201    0.075   16.009    0.000    1.371    0.915
    E5                1.111    0.087   12.765    0.000    1.268    0.763
  ai_perception =~                                                      
    AI1               1.000                               1.297    0.827
    AI2               1.059    0.061   17.288    0.000    1.374    0.890
    AI3               1.076    0.064   16.933    0.000    1.396    0.883
    AI4               1.096    0.059   18.665    0.000    1.422    0.932
    AI5               0.913    0.063   14.545    0.000    1.184    0.782
  loyalty =~                                                            
    L1                1.000                               1.207    0.911
    L2                1.179    0.047   25.291    0.000    1.423    0.942
    L3                1.050    0.047   22.555    0.000    1.267    0.904
    L4                1.074    0.050   21.289    0.000    1.296    0.881
    L5                1.022    0.071   14.298    0.000    1.234    0.712

Covariances:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
 .AI5 ~~                                                                
   .L5                0.379    0.084    4.517    0.000    0.379    0.330
 .AI2 ~~                                                                
   .AI3               0.053    0.049    1.076    0.282    0.053    0.101
   .L4                0.112    0.039    2.902    0.004    0.112    0.228
 .E2 ~~                                                                 
   .E4                0.140    0.071    1.984    0.047    0.140    0.237
 .E3 ~~                                                                 
   .E5                0.270    0.084    3.206    0.001    0.270    0.299
  engagement ~~                                                         
    ai_perception     0.979    0.137    7.137    0.000    0.661    0.661
    loyalty           0.325    0.100    3.244    0.001    0.236    0.236
  ai_perception ~~                                                      
    loyalty           0.445    0.114    3.920    0.000    0.284    0.284

Variances:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
   .E1                0.704    0.079    8.889    0.000    0.704    0.351
   .E2                0.949    0.113    8.378    0.000    0.949    0.396
   .E3                0.705    0.090    7.803    0.000    0.705    0.282
   .E4                0.367    0.070    5.215    0.000    0.367    0.163
   .E5                1.155    0.127    9.061    0.000    1.155    0.418
   .AI1               0.778    0.082    9.489    0.000    0.778    0.316
   .AI2               0.498    0.063    7.885    0.000    0.498    0.209
   .AI3               0.553    0.069    8.021    0.000    0.553    0.221
   .AI4               0.306    0.048    6.407    0.000    0.306    0.131
   .AI5               0.891    0.090    9.864    0.000    0.891    0.389
   .L1                0.299    0.036    8.308    0.000    0.299    0.170
   .L2                0.258    0.038    6.786    0.000    0.258    0.113
   .L3                0.359    0.042    8.527    0.000    0.359    0.183
   .L4                0.487    0.054    9.070    0.000    0.487    0.225
   .L5                1.479    0.143   10.328    0.000    1.479    0.493
    engagement        1.303    0.179    7.269    0.000    1.000    1.000
    ai_perception     1.683    0.219    7.685    0.000    1.000    1.000
    loyalty           1.458    0.161    9.036    0.000    1.000    1.000

> fitMeasures(fit_mod, c("cfi", "tli", "rmsea", "srmr"))
  cfi   tli rmsea  srmr 
0.943 0.928 0.098 0.046 
> library(semTools)
> 
> # Стандартизация индикаторов вручную
> scale_vars <- function(x) scale(x, center = TRUE, scale = TRUE)[,1]
> 
> your_data_scaled <- your_data
> your_data_scaled[, c("E1","E2","E3","E4","E5",
+                      "AI1","AI2","AI3","AI4","AI5")] <- 
+   lapply(your_data_scaled[, c("E1","E2","E3","E4","E5",
+                                "AI1","AI2","AI3","AI4","AI5")], scale_vars)
> 
> # Создание переменных взаимодействия (по индикаторам)
> int.model <- indProd(
+   data = your_data_scaled,
+   var1 = c("E1", "E2", "E3", "E4", "E5"),
+   var2 = c("AI1", "AI2", "AI3", "AI4", "AI5"),
+   match = TRUE,
+   meanC = FALSE
+ )
> int.model$age_num <- as.numeric(as.factor(your_data$age))
> int.model$gender_num <- as.numeric(as.factor(your_data$gender))
> int.model$education_num <- as.numeric(as.factor(your_data$education))
> int.model$frequency_num <- as.numeric(as.factor(your_data$frequency))
> model_sem <- '
+   # Латентные переменные
+   engagement =~ E1 + E2 + E3 + E4 + E5
+   ai_perception =~ AI1 + AI2 + AI3 + AI4 + AI5
+   interaction =~ E1.AI1 + E2.AI2 + E3.AI3 + E4.AI4 + E5.AI5
+   loyalty =~ L1 + L2 + L3 + L4 + L5
+ 
+   # Структурные пути
+   engagement ~ ai_perception         # H2
+   loyalty ~ engagement + ai_perception + interaction  # H1 + H3
+ '
> fit_sem <- sem(model_sem, data = int.model, meanstructure = TRUE)
> summary(fit_sem, fit.measures = TRUE, standardized = TRUE)
lavaan 0.6-19 ended normally after 46 iterations

  Estimator                                         ML
  Optimization method                           NLMINB
  Number of model parameters                        65

                                                  Used       Total
  Number of observations                           235         236

Model Test User Model:
                                                      
  Test statistic                               511.558
  Degrees of freedom                               165
  P-value (Chi-square)                           0.000

Model Test Baseline Model:

  Test statistic                              4092.377
  Degrees of freedom                               190
  P-value                                        0.000

User Model versus Baseline Model:

  Comparative Fit Index (CFI)                    0.911
  Tucker-Lewis Index (TLI)                       0.898

Loglikelihood and Information Criteria:

  Loglikelihood user model (H0)              -5419.407
  Loglikelihood unrestricted model (H1)      -5163.628
                                                      
  Akaike (AIC)                               10968.815
  Bayesian (BIC)                             11193.688
  Sample-size adjusted Bayesian (SABIC)      10987.665

Root Mean Square Error of Approximation:

  RMSEA                                          0.095
  90 Percent confidence interval - lower         0.085
  90 Percent confidence interval - upper         0.104
  P-value H_0: RMSEA <= 0.050                    0.000
  P-value H_0: RMSEA >= 0.080                    0.995

Standardized Root Mean Square Residual:

  SRMR                                           0.060

Parameter Estimates:

  Standard errors                             Standard
  Information                                 Expected
  Information saturated (h1) model          Structured

Latent Variables:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
  engagement =~                                                         
    E1                1.000                               0.792    0.796
    E2                1.005    0.073   13.708    0.000    0.796    0.799
    E3                1.081    0.071   15.126    0.000    0.856    0.859
    E4                1.160    0.070   16.613    0.000    0.918    0.922
    E5                0.982    0.074   13.311    0.000    0.778    0.782
  ai_perception =~                                                      
    AI1               1.000                               0.821    0.825
    AI2               1.088    0.063   17.365    0.000    0.893    0.893
    AI3               1.086    0.063   17.328    0.000    0.891    0.892
    AI4               1.128    0.061   18.459    0.000    0.926    0.927
    AI5               0.940    0.068   13.906    0.000    0.772    0.774
  interaction =~                                                        
    E1.AI1            1.000                               0.648    0.648
    E2.AI2            1.345    0.134   10.037    0.000    0.872    0.808
    E3.AI3            1.353    0.139    9.702    0.000    0.877    0.770
    E4.AI4            1.406    0.139   10.123    0.000    0.912    0.819
    E5.AI5            1.018    0.124    8.241    0.000    0.660    0.627
  loyalty =~                                                            
    L1                1.000                               1.210    0.913
    L2                1.174    0.046   25.290    0.000    1.420    0.940
    L3                1.048    0.046   22.720    0.000    1.269    0.905
    L4                1.067    0.051   21.075    0.000    1.291    0.880
    L5                1.024    0.074   13.815    0.000    1.240    0.713

Regressions:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
  engagement ~                                                          
    ai_perception     0.628    0.067    9.371    0.000    0.652    0.652
  loyalty ~                                                             
    engagement        0.121    0.140    0.868    0.385    0.079    0.079
    ai_perception     0.331    0.139    2.385    0.017    0.225    0.225
    interaction      -0.065    0.135   -0.483    0.629   -0.035   -0.035

Covariances:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
  ai_perception ~~                                                      
    interaction      -0.155    0.042   -3.698    0.000   -0.291   -0.291

Intercepts:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
   .E1               -0.007    0.065   -0.103    0.918   -0.007   -0.007
   .E2               -0.006    0.065   -0.091    0.928   -0.006   -0.006
   .E3               -0.006    0.065   -0.090    0.928   -0.006   -0.006
   .E4               -0.006    0.065   -0.094    0.925   -0.006   -0.006
   .E5               -0.007    0.065   -0.101    0.920   -0.007   -0.007
   .AI1              -0.006    0.065   -0.095    0.924   -0.006   -0.006
   .AI2              -0.001    0.065   -0.014    0.989   -0.001   -0.001
   .AI3              -0.003    0.065   -0.045    0.964   -0.003   -0.003
   .AI4              -0.003    0.065   -0.048    0.962   -0.003   -0.003
   .AI5              -0.005    0.065   -0.076    0.940   -0.005   -0.005
   .E1.AI1           -0.007    0.065   -0.112    0.910   -0.007   -0.007
   .E2.AI2            0.001    0.070    0.009    0.993    0.001    0.001
   .E3.AI3           -0.002    0.074   -0.024    0.981   -0.002   -0.002
   .E4.AI4           -0.002    0.073   -0.029    0.977   -0.002   -0.002
   .E5.AI5           -0.006    0.069   -0.085    0.932   -0.006   -0.006
   .L1                4.706    0.086   54.439    0.000    4.706    3.551
   .L2                4.532    0.099   45.978    0.000    4.532    2.999
   .L3                4.851    0.091   53.049    0.000    4.851    3.461
   .L4                4.400    0.096   45.948    0.000    4.400    2.997
   .L5                3.613    0.113   31.867    0.000    3.613    2.079

Variances:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
   .E1                0.363    0.038    9.484    0.000    0.363    0.366
   .E2                0.358    0.038    9.452    0.000    0.358    0.361
   .E3                0.259    0.030    8.572    0.000    0.259    0.262
   .E4                0.148    0.023    6.351    0.000    0.148    0.149
   .E5                0.385    0.040    9.612    0.000    0.385    0.389
   .AI1               0.317    0.033    9.558    0.000    0.317    0.320
   .AI2               0.202    0.024    8.412    0.000    0.202    0.202
   .AI3               0.203    0.024    8.443    0.000    0.203    0.204
   .AI4               0.140    0.020    7.088    0.000    0.140    0.140
   .AI5               0.399    0.040    9.947    0.000    0.399    0.401
   .E1.AI1            0.580    0.060    9.669    0.000    0.580    0.580
   .E2.AI2            0.403    0.052    7.713    0.000    0.403    0.347
   .E3.AI3            0.529    0.063    8.443    0.000    0.529    0.407
   .E4.AI4            0.407    0.055    7.458    0.000    0.407    0.329
   .E5.AI5            0.673    0.069    9.797    0.000    0.673    0.607
   .L1                0.292    0.036    8.203    0.000    0.292    0.166
   .L2                0.266    0.039    6.861    0.000    0.266    0.116
   .L3                0.356    0.042    8.469    0.000    0.356    0.181
   .L4                0.488    0.054    9.071    0.000    0.488    0.226
   .L5                1.484    0.144   10.317    0.000    1.484    0.491
   .engagement        0.361    0.052    6.890    0.000    0.575    0.575
    ai_perception     0.674    0.088    7.661    0.000    1.000    1.000
    interaction       0.420    0.080    5.259    0.000    1.000    1.000
   .loyalty           1.337    0.148    9.013    0.000    0.913    0.913

> model_H1 <- '
+   engagement =~ E1 + E2 + E3 + E4 + E5
+   loyalty =~ L1 + L2 + L3 + L4 + L5
+ 
+   loyalty ~ engagement
+ '
> 
> fit_H1 <- sem(model_H1, data = your_data)
> summary(fit_H1, fit.measures = TRUE, standardized = TRUE)
lavaan 0.6-19 ended normally after 26 iterations

  Estimator                                         ML
  Optimization method                           NLMINB
  Number of model parameters                        21

                                                  Used       Total
  Number of observations                           235         236

Model Test User Model:
                                                      
  Test statistic                               143.928
  Degrees of freedom                                34
  P-value (Chi-square)                           0.000

Model Test Baseline Model:

  Test statistic                              2097.150
  Degrees of freedom                                45
  P-value                                        0.000

User Model versus Baseline Model:

  Comparative Fit Index (CFI)                    0.946
  Tucker-Lewis Index (TLI)                       0.929

Loglikelihood and Information Criteria:

  Loglikelihood user model (H0)              -3327.246
  Loglikelihood unrestricted model (H1)      -3255.282
                                                      
  Akaike (AIC)                                6696.492
  Bayesian (BIC)                              6769.143
  Sample-size adjusted Bayesian (SABIC)       6702.582

Root Mean Square Error of Approximation:

  RMSEA                                          0.117
  90 Percent confidence interval - lower         0.098
  90 Percent confidence interval - upper         0.137
  P-value H_0: RMSEA <= 0.050                    0.000
  P-value H_0: RMSEA >= 0.080                    0.999

Standardized Root Mean Square Residual:

  SRMR                                           0.054

Parameter Estimates:

  Standard errors                             Standard
  Information                                 Expected
  Information saturated (h1) model          Structured

Latent Variables:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
  engagement =~                                                         
    E1                1.000                               1.115    0.787
    E2                1.112    0.082   13.547    0.000    1.241    0.801
    E3                1.211    0.082   14.725    0.000    1.350    0.854
    E4                1.248    0.076   16.340    0.000    1.392    0.929
    E5                1.166    0.089   13.145    0.000    1.301    0.783
  loyalty =~                                                            
    L1                1.000                               1.210    0.913
    L2                1.174    0.046   25.281    0.000    1.420    0.940
    L3                1.047    0.046   22.642    0.000    1.267    0.904
    L4                1.068    0.051   21.108    0.000    1.292    0.880
    L5                1.027    0.074   13.861    0.000    1.242    0.715

Regressions:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
  loyalty ~                                                             
    engagement        0.253    0.075    3.395    0.001    0.233    0.233

Variances:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
   .E1                0.763    0.080    9.526    0.000    0.763    0.380
   .E2                0.858    0.091    9.387    0.000    0.858    0.358
   .E3                0.677    0.079    8.595    0.000    0.677    0.271
   .E4                0.308    0.053    5.778    0.000    0.308    0.137
   .E5                1.070    0.112    9.567    0.000    1.070    0.387
   .L1                0.292    0.036    8.194    0.000    0.292    0.166
   .L2                0.266    0.039    6.848    0.000    0.266    0.116
   .L3                0.359    0.042    8.493    0.000    0.359    0.183
   .L4                0.486    0.054    9.054    0.000    0.486    0.225
   .L5                1.477    0.143   10.311    0.000    1.477    0.489
    engagement        1.244    0.175    7.090    0.000    1.000    1.000
   .loyalty           1.384    0.153    9.022    0.000    0.946    0.946

> model_H2_H3_only <- '
+   # Латентные переменные
+   engagement =~ E1 + E2 + E3 + E4 + E5
+   ai_perception =~ AI1 + AI2 + AI3 + AI4 + AI5
+   interaction =~ E1.AI1 + E2.AI2 + E3.AI3 + E4.AI4 + E5.AI5
+   loyalty =~ L1 + L2 + L3 + L4 + L5
+ 
+   # Гипотеза 2
+   engagement ~ ai_perception
+ 
+   # Гипотеза 3
+   loyalty ~ ai_perception + interaction
+ '
> 
> fit_H2_H3_only <- sem(model_H2_H3_only, data = int.model, meanstructure = TRUE)
> summary(fit_H2_H3_only, fit.measures = TRUE, standardized = TRUE)
lavaan 0.6-19 ended normally after 48 iterations

  Estimator                                         ML
  Optimization method                           NLMINB
  Number of model parameters                        65

                                                  Used       Total
  Number of observations                           235         236

Model Test User Model:
                                                      
  Test statistic                               511.558
  Degrees of freedom                               165
  P-value (Chi-square)                           0.000

Model Test Baseline Model:

  Test statistic                              4092.377
  Degrees of freedom                               190
  P-value                                        0.000

User Model versus Baseline Model:

  Comparative Fit Index (CFI)                    0.911
  Tucker-Lewis Index (TLI)                       0.898

Loglikelihood and Information Criteria:

  Loglikelihood user model (H0)              -5419.407
  Loglikelihood unrestricted model (H1)      -5163.628
                                                      
  Akaike (AIC)                               10968.815
  Bayesian (BIC)                             11193.688
  Sample-size adjusted Bayesian (SABIC)      10987.665

Root Mean Square Error of Approximation:

  RMSEA                                          0.095
  90 Percent confidence interval - lower         0.085
  90 Percent confidence interval - upper         0.104
  P-value H_0: RMSEA <= 0.050                    0.000
  P-value H_0: RMSEA >= 0.080                    0.995

Standardized Root Mean Square Residual:

  SRMR                                           0.060

Parameter Estimates:

  Standard errors                             Standard
  Information                                 Expected
  Information saturated (h1) model          Structured

Latent Variables:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
  engagement =~                                                         
    E1                1.000                               0.792    0.796
    E2                1.005    0.073   13.708    0.000    0.796    0.799
    E3                1.081    0.071   15.126    0.000    0.856    0.859
    E4                1.160    0.070   16.613    0.000    0.918    0.922
    E5                0.982    0.074   13.311    0.000    0.778    0.782
  ai_perception =~                                                      
    AI1               1.000                               0.821    0.825
    AI2               1.088    0.063   17.365    0.000    0.893    0.893
    AI3               1.086    0.063   17.328    0.000    0.891    0.892
    AI4               1.128    0.061   18.459    0.000    0.926    0.927
    AI5               0.940    0.068   13.906    0.000    0.772    0.774
  interaction =~                                                        
    E1.AI1            1.000                               0.648    0.648
    E2.AI2            1.345    0.134   10.037    0.000    0.872    0.808
    E3.AI3            1.353    0.139    9.702    0.000    0.877    0.770
    E4.AI4            1.406    0.139   10.123    0.000    0.912    0.819
    E5.AI5            1.018    0.124    8.241    0.000    0.660    0.627
  loyalty =~                                                            
    L1                1.000                               1.210    0.913
    L2                1.174    0.046   25.290    0.000    1.420    0.940
    L3                1.048    0.046   22.720    0.000    1.269    0.905
    L4                1.067    0.051   21.075    0.000    1.291    0.880
    L5                1.024    0.074   13.815    0.000    1.240    0.713

Regressions:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
  engagement ~                                                          
    ai_perception     0.628    0.067    9.371    0.000    0.652    0.652
  loyalty ~                                                             
    ai_perception     0.407    0.105    3.893    0.000    0.276    0.276
    interaction      -0.065    0.135   -0.483    0.629   -0.035   -0.035

Covariances:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
  ai_perception ~~                                                      
    interaction      -0.155    0.042   -3.698    0.000   -0.291   -0.291
 .engagement ~~                                                         
   .loyalty           0.044    0.051    0.864    0.388    0.063    0.063

Intercepts:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
   .E1               -0.007    0.065   -0.103    0.918   -0.007   -0.007
   .E2               -0.006    0.065   -0.091    0.928   -0.006   -0.006
   .E3               -0.006    0.065   -0.090    0.928   -0.006   -0.006
   .E4               -0.006    0.065   -0.094    0.925   -0.006   -0.006
   .E5               -0.007    0.065   -0.101    0.920   -0.007   -0.007
   .AI1              -0.006    0.065   -0.095    0.924   -0.006   -0.006
   .AI2              -0.001    0.065   -0.014    0.989   -0.001   -0.001
   .AI3              -0.003    0.065   -0.045    0.964   -0.003   -0.003
   .AI4              -0.003    0.065   -0.048    0.962   -0.003   -0.003
   .AI5              -0.005    0.065   -0.076    0.940   -0.005   -0.005
   .E1.AI1           -0.007    0.065   -0.112    0.910   -0.007   -0.007
   .E2.AI2            0.001    0.070    0.009    0.993    0.001    0.001
   .E3.AI3           -0.002    0.074   -0.024    0.981   -0.002   -0.002
   .E4.AI4           -0.002    0.073   -0.029    0.977   -0.002   -0.002
   .E5.AI5           -0.006    0.069   -0.085    0.932   -0.006   -0.006
   .L1                4.706    0.086   54.439    0.000    4.706    3.551
   .L2                4.532    0.099   45.978    0.000    4.532    2.999
   .L3                4.851    0.091   53.049    0.000    4.851    3.461
   .L4                4.400    0.096   45.948    0.000    4.400    2.997
   .L5                3.613    0.113   31.867    0.000    3.613    2.079

Variances:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
   .E1                0.363    0.038    9.484    0.000    0.363    0.366
   .E2                0.358    0.038    9.452    0.000    0.358    0.361
   .E3                0.259    0.030    8.572    0.000    0.259    0.262
   .E4                0.148    0.023    6.351    0.000    0.148    0.149
   .E5                0.385    0.040    9.612    0.000    0.385    0.389
   .AI1               0.317    0.033    9.558    0.000    0.317    0.320
   .AI2               0.202    0.024    8.412    0.000    0.202    0.202
   .AI3               0.203    0.024    8.443    0.000    0.203    0.204
   .AI4               0.140    0.020    7.088    0.000    0.140    0.140
   .AI5               0.399    0.040    9.947    0.000    0.399    0.401
   .E1.AI1            0.580    0.060    9.669    0.000    0.580    0.580
   .E2.AI2            0.403    0.052    7.713    0.000    0.403    0.347
   .E3.AI3            0.529    0.063    8.443    0.000    0.529    0.407
   .E4.AI4            0.407    0.055    7.458    0.000    0.407    0.329
   .E5.AI5            0.673    0.069    9.797    0.000    0.673    0.607
   .L1                0.292    0.036    8.203    0.000    0.292    0.166
   .L2                0.266    0.039    6.861    0.000    0.266    0.116
   .L3                0.356    0.042    8.469    0.000    0.356    0.181
   .L4                0.488    0.054    9.071    0.000    0.488    0.226
   .L5                1.484    0.144   10.317    0.000    1.484    0.491
   .engagement        0.361    0.052    6.890    0.000    0.575    0.575
    ai_perception     0.674    0.088    7.661    0.000    1.000    1.000
    interaction       0.420    0.080    5.259    0.000    1.000    1.000
   .loyalty           1.342    0.149    9.007    0.000    0.917    0.917

> your_data$AI_group <- ifelse(your_data$ai_perception_score >= median(your_data$ai_perception_score, na.rm = TRUE),
+                              "High", "Low")
Error in `$<-.data.frame`(`*tmp*`, AI_group, value = logical(0)) : 
  replacement has 0 rows, data has 236
> your_data$AI_group <- as.factor(your_data$AI_group)
Error in `$<-.data.frame`(`*tmp*`, AI_group, value = integer(0)) : 
  replacement has 0 rows, data has 236
> # Шаг 1: создаём индекс восприятия AI
> int.model$ai_perception_score <- rowMeans(int.model[, c("AI1", "AI2", "AI3", "AI4", "AI5")], na.rm = TRUE)
> 
> # Шаг 2: создаём группы
> int.model$AI_group <- ifelse(int.model$ai_perception_score >= median(int.model$ai_perception_score, na.rm = TRUE),
+                              "High", "Low")
> int.model$AI_group <- as.factor(int.model$AI_group)
> 
> # Шаг 3: создаём SEM модель (влияние Engagement → Loyalty)
> model_group <- '
+   engagement =~ E1 + E2 + E3 + E4 + E5
+   loyalty    =~ L1 + L2 + L3 + L4 + L5
+   loyalty ~ engagement
+ '
> 
> # Шаг 4: подгонка модели с учётом групп
> fit_group <- sem(model_group, data = int.model, group = "AI_group", meanstructure = TRUE)
> 
> # Шаг 5: вывод результата
> summary(fit_group, fit.measures = TRUE, standardized = TRUE)
lavaan 0.6-19 ended normally after 45 iterations

  Estimator                                         ML
  Optimization method                           NLMINB
  Number of model parameters                        62

  Number of observations per group:               Used       Total
    Low                                            118         118
    High                                           117         118

Model Test User Model:
                                                      
  Test statistic                               268.698
  Degrees of freedom                                68
  P-value (Chi-square)                           0.000
  Test statistic for each group:
    Low                                        135.074
    High                                       133.624

Model Test Baseline Model:

  Test statistic                              2004.949
  Degrees of freedom                                90
  P-value                                        0.000

User Model versus Baseline Model:

  Comparative Fit Index (CFI)                    0.895
  Tucker-Lewis Index (TLI)                       0.861

Loglikelihood and Information Criteria:

  Loglikelihood user model (H0)              -2726.363
  Loglikelihood unrestricted model (H1)      -2592.013
                                                      
  Akaike (AIC)                                5576.725
  Bayesian (BIC)                              5791.219
  Sample-size adjusted Bayesian (SABIC)       5594.705

Root Mean Square Error of Approximation:

  RMSEA                                          0.158
  90 Percent confidence interval - lower         0.139
  90 Percent confidence interval - upper         0.179
  P-value H_0: RMSEA <= 0.050                    0.000
  P-value H_0: RMSEA >= 0.080                    1.000

Standardized Root Mean Square Residual:

  SRMR                                           0.077

Parameter Estimates:

  Standard errors                             Standard
  Information                                 Expected
  Information saturated (h1) model          Structured


Group 1 [Low]:

Latent Variables:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
  engagement =~                                                         
    E1                1.000                               0.575    0.660
    E2                1.331    0.176    7.576    0.000    0.765    0.791
    E3                1.264    0.171    7.377    0.000    0.727    0.766
    E4                1.545    0.182    8.489    0.000    0.888    0.950
    E5                1.038    0.166    6.261    0.000    0.597    0.634
  loyalty =~                                                            
    L1                1.000                               0.933    0.893
    L2                1.190    0.073   16.250    0.000    1.110    0.938
    L3                1.136    0.089   12.764    0.000    1.060    0.841
    L4                1.280    0.091   14.126    0.000    1.194    0.882
    L5                1.025    0.131    7.810    0.000    0.956    0.625

Regressions:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
  loyalty ~                                                             
    engagement        0.380    0.161    2.362    0.018    0.235    0.235

Intercepts:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
   .E1               -0.458    0.080   -5.714    0.000   -0.458   -0.526
   .E2               -0.379    0.089   -4.254    0.000   -0.379   -0.392
   .E3               -0.531    0.087   -6.079    0.000   -0.531   -0.560
   .E4               -0.448    0.086   -5.198    0.000   -0.448   -0.478
   .E5               -0.459    0.087   -5.292    0.000   -0.459   -0.487
   .L1                4.297    0.096   44.705    0.000    4.297    4.115
   .L2                4.178    0.109   38.349    0.000    4.178    3.530
   .L3                4.517    0.116   38.928    0.000    4.517    3.584
   .L4                4.059    0.125   32.548    0.000    4.059    2.996
   .L5                3.339    0.141   23.697    0.000    3.339    2.182

Variances:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
   .E1                0.428    0.059    7.194    0.000    0.428    0.564
   .E2                0.350    0.054    6.474    0.000    0.350    0.374
   .E3                0.372    0.056    6.692    0.000    0.372    0.413
   .E4                0.086    0.036    2.360    0.018    0.086    0.098
   .E5                0.531    0.073    7.265    0.000    0.531    0.598
   .L1                0.220    0.038    5.858    0.000    0.220    0.202
   .L2                0.168    0.039    4.368    0.000    0.168    0.120
   .L3                0.465    0.071    6.601    0.000    0.465    0.293
   .L4                0.409    0.067    6.088    0.000    0.409    0.223
   .L5                1.428    0.193    7.403    0.000    1.428    0.610
    engagement        0.331    0.084    3.929    0.000    1.000    1.000
   .loyalty           0.822    0.134    6.135    0.000    0.945    0.945


Group 2 [High]:

Latent Variables:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
  engagement =~                                                         
    E1                1.000                               0.697    0.775
    E2                0.958    0.110    8.674    0.000    0.668    0.763
    E3                0.840    0.090    9.294    0.000    0.586    0.808
    E4                1.093    0.104   10.522    0.000    0.762    0.902
    E5                0.929    0.103    9.003    0.000    0.648    0.787
  loyalty =~                                                            
    L1                1.000                               1.324    0.916
    L2                1.212    0.066   18.241    0.000    1.605    0.939
    L3                1.030    0.057   18.117    0.000    1.364    0.937
    L4                0.991    0.066   14.974    0.000    1.313    0.877
    L5                1.058    0.100   10.563    0.000    1.402    0.744

Regressions:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
  loyalty ~                                                             
    engagement        0.060    0.187    0.323    0.747    0.032    0.032

Intercepts:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
   .E1                0.449    0.083    5.394    0.000    0.449    0.499
   .E2                0.370    0.081    4.576    0.000    0.370    0.423
   .E3                0.524    0.067    7.818    0.000    0.524    0.723
   .E4                0.439    0.078    5.622    0.000    0.439    0.520
   .E5                0.450    0.076    5.912    0.000    0.450    0.547
   .L1                5.120    0.134   38.322    0.000    5.120    3.543
   .L2                4.889    0.158   30.950    0.000    4.889    2.861
   .L3                5.188    0.135   38.555    0.000    5.188    3.564
   .L4                4.744    0.138   34.268    0.000    4.744    3.168
   .L5                3.889    0.174   22.320    0.000    3.889    2.063

Variances:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
   .E1                0.323    0.049    6.539    0.000    0.323    0.399
   .E2                0.320    0.048    6.624    0.000    0.320    0.417
   .E3                0.182    0.029    6.243    0.000    0.182    0.346
   .E4                0.133    0.030    4.425    0.000    0.133    0.186
   .E5                0.257    0.040    6.442    0.000    0.257    0.380
   .L1                0.334    0.056    5.939    0.000    0.334    0.160
   .L2                0.344    0.066    5.188    0.000    0.344    0.118
   .L3                0.258    0.049    5.275    0.000    0.258    0.122
   .L4                0.518    0.079    6.582    0.000    0.518    0.231
   .L5                1.587    0.219    7.258    0.000    1.587    0.447
    engagement        0.486    0.100    4.847    0.000    1.000    1.000
   .loyalty           1.752    0.272    6.451    0.000    0.999    0.999

> # Модель с наложенным ограничением равенства пути
> fit_constrained <- sem(model_group, data = int.model, group = "AI_group",
+                        group.equal = "regressions", meanstructure = TRUE)
> 
> # Сравнение со свободной моделью
> anova(fit_group, fit_constrained)

Chi-Squared Difference Test

                Df    AIC    BIC  Chisq Chisq diff    RMSEA Df diff Pr(>Chisq)
fit_group       68 5576.7 5791.2 268.70                                       
fit_constrained 69 5576.4 5787.4 270.36     1.6609 0.074999       1     0.1975
> model_group_ctrl <- '
+   engagement =~ E1 + E2 + E3 + E4 + E5
+   loyalty    =~ L1 + L2 + L3 + L4 + L5
+   loyalty ~ engagement + age + gender + education + frequency
+ '
> fit_group_ctrl <- sem(model_group_ctrl, data = int.model, group = "AI_group", meanstructure = TRUE)
> model_group_ctrl <- '
+   engagement =~ E1 + E2 + E3 + E4 + E5
+   loyalty    =~ L1 + L2 + L3 + L4 + L5
+   loyalty ~ engagement + age + gender + education + frequency
+ '
> fit_group_ctrl <- sem(model_group_ctrl, data = int.model, group = "AI_group", meanstructure = TRUE)
> summary(fit_group_ctrl, fit.measures = TRUE, standardized = TRUE)
lavaan 0.6-19 ended normally after 77 iterations

  Estimator                                         ML
  Optimization method                           NLMINB
  Number of model parameters                        70

  Number of observations per group:               Used       Total
    Low                                            118         118
    High                                           117         118

Model Test User Model:
                                                      
  Test statistic                               350.467
  Degrees of freedom                               140
  P-value (Chi-square)                           0.000
  Test statistic for each group:
    Low                                        186.177
    High                                       164.290

Model Test Baseline Model:

  Test statistic                              2117.282
  Degrees of freedom                               170
  P-value                                        0.000

User Model versus Baseline Model:

  Comparative Fit Index (CFI)                    0.892
  Tucker-Lewis Index (TLI)                       0.869

Loglikelihood and Information Criteria:

  Loglikelihood user model (H0)              -2711.080
  Loglikelihood unrestricted model (H1)             NA
                                                      
  Akaike (AIC)                                5562.160
  Bayesian (BIC)                              5804.331
  Sample-size adjusted Bayesian (SABIC)       5582.460

Root Mean Square Error of Approximation:

  RMSEA                                          0.113
  90 Percent confidence interval - lower         0.098
  90 Percent confidence interval - upper         0.128
  P-value H_0: RMSEA <= 0.050                    0.000
  P-value H_0: RMSEA >= 0.080                    1.000

Standardized Root Mean Square Residual:

  SRMR                                           0.077

Parameter Estimates:

  Standard errors                             Standard
  Information                                 Expected
  Information saturated (h1) model          Structured


Group 1 [Low]:

Latent Variables:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
  engagement =~                                                         
    E1                1.000                               0.576    0.661
    E2                1.328    0.175    7.587    0.000    0.765    0.791
    E3                1.262    0.171    7.390    0.000    0.727    0.766
    E4                1.541    0.181    8.505    0.000    0.888    0.949
    E5                1.037    0.165    6.270    0.000    0.597    0.634
  loyalty =~                                                            
    L1                1.000                               0.931    0.893
    L2                1.191    0.074   16.188    0.000    1.108    0.937
    L3                1.138    0.089   12.758    0.000    1.059    0.841
    L4                1.282    0.091   14.104    0.000    1.193    0.882
    L5                1.025    0.132    7.782    0.000    0.954    0.623

Regressions:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
  loyalty ~                                                             
    engagement        0.368    0.156    2.353    0.019    0.228    0.228
    age              -0.054    0.056   -0.975    0.330   -0.058   -0.089
    gender           -0.093    0.171   -0.543    0.587   -0.100   -0.050
    education        -0.091    0.046   -1.981    0.048   -0.098   -0.183
    frequency        -0.061    0.060   -1.020    0.308   -0.066   -0.093

Intercepts:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
   .E1               -0.458    0.080   -5.714    0.000   -0.458   -0.526
   .E2               -0.379    0.089   -4.254    0.000   -0.379   -0.392
   .E3               -0.531    0.087   -6.079    0.000   -0.531   -0.560
   .E4               -0.448    0.086   -5.198    0.000   -0.448   -0.478
   .E5               -0.459    0.087   -5.292    0.000   -0.459   -0.487
   .L1                5.190    0.394   13.178    0.000    5.190    4.977
   .L2                5.242    0.466   11.242    0.000    5.242    4.435
   .L3                5.534    0.452   12.254    0.000    5.534    4.395
   .L4                5.205    0.506   10.293    0.000    5.205    3.847
   .L5                4.255    0.428    9.949    0.000    4.255    2.781

Variances:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
   .E1                0.427    0.059    7.189    0.000    0.427    0.563
   .E2                0.351    0.054    6.472    0.000    0.351    0.375
   .E3                0.372    0.056    6.688    0.000    0.372    0.413
   .E4                0.087    0.036    2.379    0.017    0.087    0.099
   .E5                0.531    0.073    7.262    0.000    0.531    0.598
   .L1                0.221    0.038    5.878    0.000    0.221    0.203
   .L2                0.169    0.038    4.394    0.000    0.169    0.121
   .L3                0.463    0.070    6.596    0.000    0.463    0.292
   .L4                0.407    0.067    6.083    0.000    0.407    0.222
   .L5                1.431    0.193    7.405    0.000    1.431    0.611
    engagement        0.332    0.084    3.936    0.000    1.000    1.000
   .loyalty           0.774    0.127    6.110    0.000    0.894    0.894


Group 2 [High]:

Latent Variables:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
  engagement =~                                                         
    E1                1.000                               0.698    0.775
    E2                0.956    0.110    8.661    0.000    0.667    0.762
    E3                0.840    0.090    9.296    0.000    0.586    0.808
    E4                1.093    0.104   10.530    0.000    0.762    0.902
    E5                0.930    0.103    9.019    0.000    0.649    0.788
  loyalty =~                                                            
    L1                1.000                               1.328    0.916
    L2                1.213    0.066   18.282    0.000    1.610    0.940
    L3                1.032    0.057   18.236    0.000    1.370    0.939
    L4                0.991    0.066   14.965    0.000    1.316    0.876
    L5                1.058    0.100   10.576    0.000    1.405    0.744

Regressions:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
  loyalty ~                                                             
    engagement        0.148    0.169    0.877    0.380    0.078    0.078
    age               0.137    0.085    1.617    0.106    0.104    0.143
    gender            1.142    0.232    4.932    0.000    0.860    0.430
    education        -0.005    0.078   -0.062    0.950   -0.004   -0.005
    frequency        -0.023    0.093   -0.252    0.801   -0.018   -0.022

Intercepts:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
   .E1                0.449    0.083    5.394    0.000    0.449    0.499
   .E2                0.370    0.081    4.576    0.000    0.370    0.423
   .E3                0.524    0.067    7.818    0.000    0.524    0.723
   .E4                0.439    0.078    5.622    0.000    0.439    0.520
   .E5                0.450    0.076    5.912    0.000    0.450    0.547
   .L1                3.064    0.638    4.804    0.000    3.064    2.114
   .L2                2.396    0.770    3.110    0.002    2.396    1.398
   .L3                3.066    0.656    4.675    0.000    3.066    2.101
   .L4                2.707    0.636    4.253    0.000    2.707    1.803
   .L5                1.714    0.701    2.444    0.015    1.714    0.908

Variances:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
   .E1                0.323    0.049    6.539    0.000    0.323    0.399
   .E2                0.321    0.048    6.633    0.000    0.321    0.419
   .E3                0.182    0.029    6.246    0.000    0.182    0.347
   .E4                0.133    0.030    4.424    0.000    0.133    0.186
   .E5                0.257    0.040    6.436    0.000    0.257    0.379
   .L1                0.337    0.056    5.979    0.000    0.337    0.160
   .L2                0.344    0.066    5.222    0.000    0.344    0.117
   .L3                0.253    0.048    5.254    0.000    0.253    0.119
   .L4                0.522    0.079    6.608    0.000    0.522    0.232
   .L5                1.591    0.219    7.266    0.000    1.591    0.446
    engagement        0.487    0.100    4.849    0.000    1.000    1.000
   .loyalty           1.411    0.220    6.400    0.000    0.800    0.800


setwd("~/Desktop")

print(getwd())     
print(list.files())  

int.model <- read.csv("7.csv", sep = ";", stringsAsFactors = FALSE)

# 3) Подготовка контрольных переменных
int.model$age_num       <- as.numeric(as.factor(int.model$age))
int.model$gender_num    <- as.numeric(as.factor(int.model$gender))
int.model$education_num <- as.numeric(as.factor(int.model$education))
int.model$freq_num      <- as.numeric(as.factor(int.model$frequency))


library(lavaan)
library(semPlot)

model_H1_cv <- '
  engagement =~ E1 + E2 + E3 + E4 + E5
  loyalty    =~ L1 + L2 + L3 + L4 + L5

  loyalty ~ engagement + age_num + gender_num + education_num + freq_num
'

fit_H1_cv <- sem(model_H1_cv,
                 data          = int.model,
                 meanstructure = TRUE)

# Вывод результатов H1
summary(fit_H1_cv, fit.measures = TRUE, standardized = TRUE)

# Диаграмма H1
quartz(width=6, height=6)   # на Windows – windows(), на Linux – X11()
semPaths(fit_H1_cv,
         whatLabels     = "std",
         layout         = "tree2",
         style          = "ram",
         residuals      = FALSE,
         intercepts     = FALSE,
         edge.label.cex = 0.8)
title("H1: Engagement → Loyalty\n(with Controls)", line = 0, cex.main = 1.3)



model_H2_cv <- '
  ai_perception =~ AI1 + AI2 + AI3 + AI4 + AI5
  engagement    =~ E1  + E2  + E3  + E4  + E5

  engagement ~ ai_perception + age_num + gender_num + education_num + freq_num
'

fit_H2_cv <- sem(model_H2_cv,
                 data          = int.model,
                 meanstructure = TRUE)

# Вывод результатов H2
summary(fit_H2_cv, fit.measures = TRUE, standardized = TRUE)

# Диаграмма H2
quartz(width=6, height=6)
semPaths(fit_H2_cv,
         whatLabels     = "std",
         layout         = "tree2",
         style          = "ram",
         residuals      = FALSE,
         intercepts     = FALSE,
         edge.label.cex = 0.8)
title("H2: AI Perception → Engagement\n(with Controls)", line = 0, cex.main = 1.3)

library(lavaan)
library(semPlot)

# 1) Расчёт группы по медиане
int.model$ai_perception_score <- rowMeans(int.model[, paste0("AI",1:5)], na.rm = TRUE)
int.model$AI_group <- factor(
  ifelse(int.model$ai_perception_score >= median(int.model$ai_perception_score, na.rm=TRUE),
         "High","Low"),
  levels = c("Low","High")
)

# 2) Спецификация H3 с контролями
model_group_cv <- '
  # измерительные модели
  engagement =~ E1 + E2 + E3 + E4 + E5
  loyalty    =~ L1 + L2 + L3 + L4 + L5

  # структурное уравнение: loyalty на engagement + контролы
  loyalty ~ engagement + age + gender + education + frequency
'

# 3) Подгонка для Low AI
fit_low_cv <- sem(model_group_cv,
                  data          = subset(int.model, AI_group=="Low"),
                  meanstructure = TRUE)
# 4) Подгонка для High AI
fit_high_cv <- sem(model_group_cv,
                   data          = subset(int.model, AI_group=="High"),
                   meanstructure = TRUE)

# 5) Визуализация
quartz(width=10, height=5)   # на macOS; на Windows — windows()
par(mfrow=c(1,2), mar=c(1,1,2,1))

semPaths(fit_low_cv,
         whatLabels     = "std",
         layout         = "tree2",
         style          = "ram",
         residuals      = FALSE,
         intercepts     = FALSE,
         edge.label.cex = 0.8)
title("H3: Low AI (with Controls)", line=0, cex.main=1.3)

semPaths(fit_high_cv,
         whatLabels     = "std",
         layout         = "tree2",
         style          = "ram",
         residuals      = FALSE,
         intercepts     = FALSE,
         edge.label.cex = 0.8)
title("H3: High AI (with Controls)", line=0, cex.main=1.3)