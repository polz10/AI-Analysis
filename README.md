# Master's Thesis Repository

**Title:** The Role of Artificial Intelligence in Shaping the Relationship Between User Engagement and Loyalty on Chinese Educational Platforms  
**Author:** Polina Zueva  
**Institution:** National Research University Higher School of Economics (HSE)  
**Program:** Master's in International Business in the Asia-Pacific Region  

## Overview

This repository contains the materials used in the empirical part of the master’s thesis. The study investigates the moderating effect of AI perception on the relationship between user engagement and loyalty in the context of Chinese EdTech platforms. Structural Equation Modeling (SEM) was employed to test the hypotheses.

## Contents

- `dataset.csv`: anonymized dataset (n = 235) based on the online questionnaire.
- `SEM_model_final.R`: R script for performing CFA and SEM using `lavaan` and `semTools`.
- `survey_CN.pdf`: original survey questionnaire in Mandarin Chinese (uploaded separately).
- `README.md`: project documentation (this file).

## Data Collection

- **Platform:** [Tencent Questionnaire (腾讯问卷)]
- **Period:** January – March 2025
- **Method:** Online snowball sampling via WeChat learning groups and education forums.
- **Eligibility criteria:**
  - Must be an active user of a Chinese educational platform.
  - Must have used AI-based features (e.g., chatbot, personalized recommendation, automated feedback).
  - Only participants who selected “Yes” to the AI screening question were included.

## Variables

The dataset includes:
- **Demographics:** Age, Gender, Education level, Frequency of platform use.
- **Engagement (E1–E5):** Measures of emotional, cognitive, and behavioral involvement.
- **AI Perception (AI1–AI5):** Trust and satisfaction toward AI features (TAM-based).
- **Loyalty (L1–L5):** Intention to reuse, satisfaction, and willingness to recommend.

All latent constructs were measured on a 7-point Likert scale (1 = strongly disagree, 7 = strongly agree).

## Analysis

- Software: R version 4.3.2
- Key libraries: `lavaan`, `semTools`, `psych`
- Steps:
  - Confirmatory Factor Analysis (CFA)
  - Structural Equation Modeling (SEM)
  - Multi-group SEM for moderation (median split on AI perception)
  - Assessment of reliability (Cronbach’s alpha, McDonald’s omega)
  - Fit indices: CFI, TLI, RMSEA, SRMR

Correlated errors were added based on modification indices to improve model fit while preserving theoretical coherence.
