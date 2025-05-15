# clean_final1.R

rm(list = ls())
suppressPackageStartupMessages({
  library(lavaan)
  library(semTools)
  library(semPlot)
})

df <- read.csv("~/Desktop/7.csv", sep = ";", header = TRUE, stringsAsFactors = FALSE)
stopifnot(all(c("age","gender","education","frequency") %in% names(df)))

# CFA для определения коррелирующих ошибок
model_cfa <- '
  engagement =~ E1 + E2 + E3 + E4 + E5
  ai_perception =~ AI1 + AI2 + AI3 + AI4 + AI5
  loyalty =~ L1 + L2 + L3 + L4 + L5
  E2 ~~ E4
  E3 ~~ E5
  AI2 ~~ AI3
  AI2 ~~ L4
  AI5 ~~ L5
'
fit_cfa <- cfa(model_cfa, data = df, meanstructure = TRUE)
summary(fit_cfa, fit.measures = TRUE, standardized = TRUE)
mi <- modindices(fit_cfa, sort = TRUE, minimum.value = 10)
print(mi)

# Перекодировка контрольных переменных
df$age       <- as.numeric(as.factor(df$age))
df$gender    <- as.numeric(as.factor(df$gender))
df$education <- as.numeric(as.factor(df$education))
df$frequency <- as.numeric(as.factor(df$frequency))

# 1. H1: Engagement → Loyalty с контролями
model_H1 <- '
  engagement =~ E1 + E2 + E3 + E4 + E5
  loyalty    =~ L1 + L2 + L3 + L4 + L5
  loyalty ~ engagement + age + gender + education + frequency
'
fit_H1 <- sem(model_H1, data = df, meanstructure = TRUE)
summary(fit_H1, fit.measures = TRUE, standardized = TRUE)

dev.new(width = 6, height = 6)
semPaths(fit_H1, whatLabels = "std", layout = "tree2", style = "ram",
         residuals = FALSE, intercepts = FALSE, edge.label.cex = 0.8)
title("H1: Engagement → Loyalty (with Controls)", line = -1, cex.main = 1.2)

# 2. H2: AI Perception → Engagement с контролями
model_H2 <- '
  ai_perception =~ AI1 + AI2 + AI3 + AI4 + AI5
  engagement    =~ E1 + E2 + E3 + E4 + E5
  engagement ~ ai_perception + age + gender + education + frequency
'
fit_H2 <- sem(model_H2, data = df, meanstructure = TRUE)
summary(fit_H2, fit.measures = TRUE, standardized = TRUE)

dev.new(width = 6, height = 6)
semPaths(fit_H2, whatLabels = "std", layout = "tree2", style = "ram",
         residuals = FALSE, intercepts = FALSE, edge.label.cex = 0.8)
title("H2: AI Perception → Engagement (with Controls)", line = -1, cex.main = 1.2)

# 3. H3: Групповой анализ с контролями
# Создание группы по медиане AI-восприятия
df$ai_perception_score <- rowMeans(df[, paste0("AI", 1:5)], na.rm = TRUE)
df$AI_group <- factor(
  ifelse(df$ai_perception_score >= median(df$ai_perception_score, na.rm = TRUE),
         "High", "Low"),
  levels = c("Low", "High")
)

model_H3 <- '
  engagement =~ E1 + E2 + E3 + E4 + E5
  loyalty    =~ L1 + L2 + L3 + L4 + L5
  loyalty ~ engagement + age + gender + education + frequency
'
fit_H3_low  <- sem(model_H3, data = subset(df, AI_group == "Low"),  meanstructure = TRUE)
fit_H3_high <- sem(model_H3, data = subset(df, AI_group == "High"), meanstructure = TRUE)

summary(fit_H3_low, fit.measures = TRUE, standardized = TRUE)
summary(fit_H3_high, fit.measures = TRUE, standardized = TRUE)

dev.new(width = 12, height = 6)
par(mfrow = c(1, 2), mar = c(1, 1, 2, 1))
semPaths(fit_H3_low,  whatLabels = "std", layout = "tree2", style = "ram",
         residuals = FALSE, intercepts = FALSE, edge.label.cex = 0.8)
title("H3: Low AI (with Controls)", line = -1, cex.main = 1.2)
semPaths(fit_H3_high, whatLabels = "std", layout = "tree2", style = "ram",
         residuals = FALSE, intercepts = FALSE, edge.label.cex = 0.8)
title("H3: High AI (with Controls)", line = -1, cex.main = 1.2)

