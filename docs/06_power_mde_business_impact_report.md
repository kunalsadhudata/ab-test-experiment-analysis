# Phase 06 — Power, MDE, Sample Size and Business Impact

## 1. Executive Summary

This report evaluates prospective sample-size requirements, minimum detectable effects (MDEs), sensitivity to planning assumptions, and hypothetical business impact for the landing-page A/B testing project.

Using the historical control conversion rate of approximately 12.0418% as a future-planning baseline, the approved minimum practically important effect (MPE) of +1 percentage point requires approximately **17,213 users per group, or 34,426 users in total**, for 80% statistical power under a two-sided two-proportion z-test at a 5% significance level.

At the analyzed sample sizes of 145,294 control users and 145,290 treatment users, the prospective 80%-power MDE is approximately **+0.3403 percentage points** using the same reference baseline.

The experiment did not demonstrate a statistically significant conversion improvement in Phase 05. The results in this report do not override that finding or establish causal business gains.

## 2. Planning Assumptions

| Parameter | Value |
|---|---|
| Primary metric | User-level conversion rate |
| Statistical test | Two-sided two-proportion z-test |
| Significance level (alpha) | 0.05 |
| Approved target power | 80% |
| Approved primary MPE | +1 percentage point, absolute |
| Planned allocation | 50/50 |
| Historical control users | 145,294 |
| Historical control conversions | 17,496 |
| Historical control conversion rate | Approximately 12.0418% |
| Hypothetical treatment rate at primary MPE | Approximately 13.0418% |

The historical control rate comes from the analyzed experiment dataset. It was not a baseline prospectively locked before this experiment and is used here only for illustrative future-experiment planning.

## 3. Prospective Sample-Size Calculation

The primary planning scenario assumes a hypothetical increase from approximately 12.0418% to 13.0418%.

Using the normal-approximation two-proportion power calculation implemented with `statsmodels`:

| Result | Value |
|---|---:|
| Standardized effect size (Cohen's h, approximately) | 0.030200 |
| Required users per group (rounded up) | 17,213 |
| Required total users | 34,426 |
| Verified calculated power at rounded sample size | Approximately 80.0018% |

This is a prospective planning calculation based on a specified target effect, not a post-hoc power calculation using the observed treatment effect.

## 4. Minimum Detectable Effect at the Analyzed Sample Size

Holding alpha at 0.05 and target power at 80%, with the analyzed group sizes:

| Metric | Value |
|---|---:|
| Control users | 145,294 |
| Treatment users | 145,290 |
| Standardized MDE (Cohen's h, approximately) | 0.010394 |
| Baseline conversion rate | 12.0418% |
| Hypothetical treatment rate at MDE | 12.3821% |
| Absolute MDE | +0.3403 percentage points |
| Relative MDE | Approximately +2.8263% |

The MDE is a prospective sensitivity measure for the specified sample sizes and assumptions. It is not the observed experiment effect, does not establish equivalence, and must not be interpreted as observed statistical power.

## 5. Sample-Size Sensitivity to Target Improvement

All scenarios below assume 80% power, two-sided alpha of 0.05, equal allocation, and the historical control conversion rate as the reference baseline.

| Hypothetical absolute improvement | Users per group | Total users |
|---|---:|---:|
| +0.5 percentage points | 67,688 | 135,376 |
| +1.0 percentage point (approved MPE) | 17,213 | 34,426 |
| +1.5 percentage points | 7,777 | 15,554 |

Smaller target improvements require larger samples to detect with the same planned power.

## 6. Sensitivity to Target Power

Using the approved +1 percentage-point MPE and the historical control reference rate:

| Target power | Users per group | Total users |
|---|---:|---:|
| 80% (approved) | 17,213 | 34,426 |
| 90% (alternative scenario) | 23,043 | 46,086 |

Increasing the power target from 80% to 90% requires 11,660 additional users in total, approximately 33.9% more than the primary planning scenario. The approved target remains 80%.

## 7. Sensitivity to Baseline Conversion Rate

All scenarios assume an absolute +1 percentage-point improvement, 80% power, two-sided alpha of 0.05, and equal allocation.

| Hypothetical baseline | Hypothetical treatment rate | Users per group | Total users |
|---|---|---:|---:|
| 8.0000% | 9.0000% | 12,199 | 24,398 |
| 12.0418% (historical reference) | 13.0418% | 17,213 | 34,426 |
| 20.0000% | 21.0000% | 25,580 | 51,160 |

Required sample size changes with the baseline conversion probability, even when the absolute target improvement remains constant.

## 8. Hypothetical Conversion Impact

The following scenarios use a standardized illustrative population of 100,000 eligible users. This is not a verified company traffic forecast.

`Incremental expected conversions = Eligible users × Absolute conversion-rate change`

| Hypothetical conversion change | Illustrative eligible users | Incremental expected conversions |
|---|---:|---:|
| -0.5 percentage points | 100,000 | -500 |
| +0.5 percentage points | 100,000 | +500 |
| +1.0 percentage point (approved MPE) | 100,000 | +1,000 |

These figures are scenario calculations, not observed experiment results or causal estimates of realized gains.

## 9. Financial-Impact Framework

The following formulas can be applied when verified business inputs become available:

- **Incremental revenue** = Incremental conversions × Revenue per conversion
- **Incremental contribution profit** = Incremental conversions × Contribution profit per conversion
- **Net incremental benefit** = Incremental contribution profit − Incremental costs

The available experiment dataset does not provide verified revenue per conversion, contribution profit per conversion, or incremental costs.

Therefore, incremental revenue, contribution profit, and net incremental benefit are **unknown, not zero**. No realized financial impact is claimed.

## 10. Relationship to Phase 05 Findings

The Phase 05 primary statistical analysis reported:

| Metric | Result |
|---|---:|
| Observed treatment-minus-control difference | Approximately -0.1587 percentage points |
| 95% confidence interval | Approximately [-0.3947, +0.0773] percentage points |
| Two-sided p-value | Approximately 0.1876 |
| Significance threshold | 0.05 |

The primary result was not statistically significant at the approved alpha level. Failure to reject the null hypothesis does not prove no effect or establish equivalence.

The dataset's assignment information is provisional. The earliest observed user record was used without an independently verified original randomization assignment log. This limits causal certainty.

The prospective power and MDE calculations in this report do not change the observed results or remove the assignment-data limitations.

## 11. Product Manager Recommendation

**Do not claim a demonstrated conversion improvement or a verified financial benefit from the redesign.**

The observed primary result does not provide statistically significant evidence of improvement, and assignment provenance remains a limitation.

For future experimentation:

1. Verify and retain original randomization assignments.
2. Establish a trustworthy planning baseline before the next experiment.
3. Use the approved +1 percentage-point MPE, 80% power, and 0.05 alpha as the documented primary planning assumptions unless formally revised.
4. Estimate sample-size requirements using the relevant prospective baseline.
5. Obtain verified traffic and financial inputs before forecasting rollout duration or monetary impact.

## 12. Reproducibility and Scope

The calculations and visualizations are documented in:

- `notebooks/06_power_mde_business_impact.ipynb`

Related project documentation:

- `docs/experiment_design.md`
- `docs/data_quality_report.md`
- `docs/04_randomisation_sql_report.md`
- `docs/05_statistical_analysis_report.md`

This report covers prospective planning sensitivity and hypothetical business impact. It does not report observed power, establish equivalence, validate original randomization assignments, or claim actual revenue or profit effects.