
# Phase 05 — Core Statistical Analysis Report

## 1. Executive Summary

This report evaluates whether a redesigned landing page
(treatment) changed user conversion compared with the
existing landing page (control).

The analysis includes 290,584 unique users.

The observed treatment conversion rate was slightly lower
than control, but the difference was not statistically
significant at the approved 5% significance level.

The 95% confidence interval also falls entirely below
the approved +1 percentage-point minimum practical
improvement threshold.

The findings do not establish equivalence or prove
that the redesign caused a conversion decline.

Original experimental assignments cannot be
independently verified, limiting causal interpretation.

No final product launch decision is made in this phase.

## 2. Experiment Design

| Component | Specification |
|---|---|
| Primary stakeholder | Product Manager |
| Control | Existing landing page |
| Treatment | Redesigned landing page |
| Primary metric | User-level conversion rate |
| Unit of analysis | Unique user |
| Planned allocation | 50/50 |
| Hypothesis test | Two-sided two-proportion z-test |
| Significance level | 0.05 |
| Confidence level | 95% |
| Approved primary MPE | +1 percentage point |

### Hypotheses

Null hypothesis:

$$H_0: p_t = p_c$$

Alternative hypothesis:

$$H_1: p_t \ne p_c$$

Here, $p_t$ and $p_c$ represent the treatment and
control conversion probabilities, respectively.

## 3. Dataset and Analysis Population

The original educational dataset contains 294,478 rows.

The cleaned provisional user-level dataset contains
290,584 rows representing 290,584 unique users.

The primary analysis retains flagged users according
to the previously documented cleaning methodology.

For repeated users, the earliest observed record was
retained as a provisional assignment proxy.

This is not an independently verified original
assignment or fully verified intent-to-treat analysis.

## 4. Conversion Summary

| Metric | Control | Treatment |
|---|---:|---:|
| Total users | 145,294 | 145,290 |
| Converted users | 17,496 | 17,265 |
| Non-converted users | 127,798 | 128,025 |
| Conversion rate | 12.0418% | 11.8831% |

The observed absolute difference, calculated as
treatment minus control, was -0.1587 percentage points.

The relative difference was -1.3176%.

These are descriptive estimates, not definitive
causal effects.

## 5. Sample Ratio Mismatch Check

Phase 04 evaluated consistency with the planned
50/50 allocation.

- Chi-square statistic: approximately 0.00005506
- Degrees of freedom: 1
- SRM p-value: approximately 0.994079
- Approved SRM alarm threshold: 0.001
- Result: No SRM alarm

The observed allocation is consistent with the plan.

However, the absence of an SRM alarm does not
independently establish valid randomization.

## 6. Primary Hypothesis Test

The approved two-sided two-proportion z-test was
performed using Python's statsmodels library.

### Verified Results

| Statistic | Result |
|---|---:|
| Z-statistic | -1.317745 |
| Two-sided p-value | 0.187589 |
| Significance level | 0.05 |
| Decision | Fail to reject H0 |

The test was independently checked using the pooled
conversion proportion and pooled standard error.

- Pooled conversion proportion: 0.119625
- Pooled standard error: 0.00120403

The manual z-statistic and p-value matched the
statsmodels implementation.

### Interpretation

Because the p-value exceeds 0.05, the experiment
does not provide sufficient statistical evidence
to reject equality of the underlying conversion
probabilities.

This does not establish that the two pages are
equivalent.

## 7. Effect Size

The observed absolute effect was:

**-0.1587 percentage points**

The observed relative conversion-rate difference was:

**-1.3176%**

The treatment group had a slightly lower observed
conversion rate than the control group.

However, the observed negative difference is not
definitive evidence that the redesign is harmful.

## 8. Confidence Interval

A 95% confidence interval for the absolute difference
was calculated using the Newcombe score-based method.

| Measure | Result |
|---|---:|
| Point estimate | -0.1587 pp |
| Lower bound | -0.3947 pp |
| Upper bound | +0.0773 pp |

The confidence interval includes zero.

Therefore, a zero difference remains compatible
with the observed data at the 95% confidence level.

The interval describes uncertainty under the
statistical model's assumptions.

## 9. Practical Significance

The approved minimum practical effect is a
+1 percentage-point absolute improvement.

The observed effect does not meet this threshold.

Furthermore, the upper confidence bound of
+0.0773 percentage points is below +1 percentage point.

Under the statistical model's assumptions, the
confidence interval provides evidence against an
improvement as large as the approved threshold.

This assessment is distinct from the primary
two-sided significance test.

The result does not prove equivalence or establish
a final launch decision.

## 10. Statistical Assumptions

### User-Level Structure

The cleaned dataset contains one retained record
per unique user.

### Binary Outcome

The conversion indicator contains valid binary
values representing conversion and non-conversion.

### Normal Approximation

Expected successes and failures under the pooled
null proportion exceed 10 in both groups.

The normal approximation check passed.

### Independence

Independence between user-level observations
cannot be fully verified from the available data.

### Randomization

The dataset does not include an independently
verified original assignment log.

Therefore, valid original randomization cannot
be conclusively established.

## 11. Data-Quality and Provenance Limitations

The cleaned dataset retains the following flags:

| Data-quality flag | Users/records |
|---|---:|
| Repeated-user flag | 3,894 |
| Cross-group assignment flag | 1,895 |
| Retained page mismatch flag | 1,949 |

These categories may overlap.

Flagged users were not silently excluded from
the approved primary analysis.

The source is a public Kaggle educational dataset
attributed to Shubham Jaiswal.

Its provenance and licensing limitations are
documented separately.

These limitations restrict the strength of
causal conclusions.

## 12. Reproducibility

Statistical analysis notebook:

`notebooks/05_core_statistical_analysis.ipynb`

Cleaned analysis dataset:

`data/processed/ab_data_provisional_user_level.csv`

SQL analysis:

`sql/04_experiment_sql_analysis.sql`

Experiment design:

`docs/experiment_design.md`

Data-quality documentation:

`docs/data_quality_report.md`

The notebook was restarted and executed from
beginning to end successfully.

The statistical calculations were verified
against the approved dataset summaries.

## 13. Phase 05 Conclusion

The redesigned landing page did not demonstrate
a statistically significant conversion difference
at the approved 5% significance level.

The observed treatment effect was -0.1587
percentage points, with a 95% confidence interval
of [-0.3947, +0.0773] percentage points.

The interval falls entirely below the approved
+1 percentage-point practical improvement threshold.

The results do not establish equivalence, definitive
harm, or a fully verified causal effect.

A later decision-oriented phase should consider
these findings alongside business assumptions,
experiment validity, and implementation risks
before making a final ship-or-hold recommendation.
