
# Phase 07 — Robustness Checks and Decision Framework

## 1. Executive Summary

### Business Question

An online business tested a redesigned landing page against its existing landing page.

The objective was to determine whether the redesign meaningfully improved user-level conversion and whether the evidence justified a rollout.

### Primary Statistical Findings

The primary analysis included 290,584 unique users.

- Control conversion rate: approximately 12.0418%.
- Treatment conversion rate: approximately 11.8831%.
- Observed treatment effect: -0.1587 percentage points.
- Two-sided two-proportion z-test p-value: 0.187589.
- Newcombe 95% confidence interval: [-0.3947, +0.0773] percentage points.
- Statistical significance threshold: 0.05.

The primary analysis did not detect a statistically significant conversion difference.

### Robustness Findings

Three secondary sensitivity analyses were performed:

1. Excluding group/landing-page mismatches.
2. Excluding users with cross-group assignment histories.
3. Excluding users with repeated observations.

All three analyses produced negative treatment-effect estimates, non-significant p-values, and confidence intervals that included zero.

The statistical conclusion remained consistent across these analytical populations.

### Practical Significance

The approved minimum practically important improvement was +1 percentage point.

The upper bounds of all four 95% confidence intervals were below this threshold.

The numerical evidence did not support an improvement reaching the approved MPE.

### Product Manager Recommendation

**Retain the original landing page — conditional.**

The available evidence does not justify rolling out the redesigned landing page.

However, the original randomized assignment log is unavailable. User assignments were reconstructed provisionally using the earliest observed record.

Therefore, the recommendation remains conditional on data-quality credibility and operational review.

The findings do not establish equivalence, prove that the redesign is harmful, or provide causal certainty.


---

## 2. Robustness Check Methodology

The primary analysis used the provisional user-level dataset created in Phase 03.

Each user contributed one observation. The earliest recorded observation was retained when multiple records existed.

Three secondary exclusion-based sensitivity analyses were conducted to assess whether the primary result depended materially on documented data-quality handling choices.

### Sensitivity Check 1 — Exclude Page Mismatches

Excluded 1,949 users whose retained `landing_page` did not match their recorded `group`.

Remaining population: 288,635 users.

This check evaluates sensitivity to group/page inconsistencies but may introduce selection bias.

### Sensitivity Check 2 — Exclude Cross-Group Users

Excluded 1,895 users who appeared in both experiment groups in the original dataset.

Remaining population: 288,689 users.

This check evaluates sensitivity to uncertain assignment histories.

### Sensitivity Check 3 — Exclude Repeated Users

Excluded 3,894 users who had multiple records in the original dataset.

Remaining population: 286,690 users.

This check evaluates sensitivity to the earliest-observation selection rule.

### Statistical Methods

All analyses used:

- User-level conversion as the outcome.
- Treatment minus Control as the effect direction.
- A two-sided two-proportion z-test.
- A significance threshold of 0.05.
- A Newcombe 95% confidence interval for the difference in proportions.

The primary analysis remains the approved analysis. The three additional analyses are secondary sensitivity checks and do not replace it.

---

## 3. Robustness Comparison Results

| Analysis | Users | Effect (pp) | P-value | 95% CI (pp) | Significant? |
|---|---:|---:|---:|---|---|
| Primary | 290,584 | -0.1587 | 0.187589 | [-0.3947, +0.0773] | No |
| Exclude page mismatches | 288,635 | -0.1695 | 0.160446 | [-0.4062, +0.0672] | No |
| Exclude cross-group users | 288,689 | -0.1633 | 0.176495 | [-0.4000, +0.0735] | No |
| Exclude repeated users | 286,690 | -0.1447 | 0.232288 | [-0.3821, +0.0927] | No |

### Interpretation

All four analyses produced negative point estimates and non-significant p-values.

The confidence intervals overlapped substantially and included zero.

The estimated treatment effects ranged from approximately -0.1695 to -0.1447 percentage points.

Therefore, the primary statistical conclusion was stable across the three documented exclusion-based sensitivity analyses.

However, these analyses do not independently establish original assignment integrity, eliminate possible selection bias, or prove equivalence between the landing pages.

---

## 4. Practical Significance Assessment

### Approved Minimum Practically Important Effect

The experiment design approved an absolute improvement threshold of +1 percentage point.

This threshold represents the minimum improvement considered practically important for the experiment's decision framework.

It is a planning assumption, not an observed treatment effect.

### Comparison Against the Approved MPE

| Analysis | 95% CI Upper Bound (pp) | Supports +1 pp Improvement? |
|---|---:|---|
| Primary | +0.0773 | No |
| Exclude page mismatches | +0.0672 | No |
| Exclude cross-group users | +0.0735 | No |
| Exclude repeated users | +0.0927 | No |

All four confidence intervals have upper bounds below +1 percentage point.

Therefore, conditional on the analytical assumptions, the numerical evidence does not support an improvement reaching the approved practical threshold.

This does not establish that the two landing pages are equivalent or that the true effect is exactly zero.

---

## 5. Product Manager Decision Framework

### Approved Decision Rules

The Phase 01 experiment design established the following numerical decision rules:

| Confidence Interval Condition | Decision |
|---|---|
| Entire 95% CI above +1 pp | Ship, subject to operational review |
| Entire 95% CI below +1 pp | Retain original |
| CI crosses +1 pp or permits a meaningful improvement | Inconclusive; consider follow-up |
| Serious data-quality failure or SRM alarm | Investigate before interpreting |

The data-quality override takes priority when the evidence is not sufficiently trustworthy.

### Application to the Experiment

The primary 95% confidence interval was:

**[-0.3947, +0.0773] percentage points.**

Its upper bound was below the approved +1 percentage-point threshold.

All three secondary sensitivity analyses produced the same numerical classification.

### Numerical Decision

**Retain original — conditional.**

### Business Interpretation

The redesigned landing page did not demonstrate a statistically significant conversion improvement.

The available evidence does not justify rolling out the redesign based on the approved decision framework.

However, the numerical decision must be interpreted alongside the provisional assignment reconstruction and the absence of independently verified original randomization records.

The recommendation is not proof that the redesign is harmful or that the two pages are equivalent.

---

## 6. Limitations and Evidence Quality

### 6.1 Provisional Assignment Reconstruction

The original independently verified randomized assignment log is unavailable.

For users with multiple observations, the earliest recorded observation was retained as a provisional assignment proxy.

Therefore, original randomization integrity cannot be conclusively verified.

### 6.2 Data-Quality Limitations

The original dataset contained repeated users, cross-group assignment histories, and group/landing-page mismatches.

Three exclusion-based sensitivity analyses produced results consistent with the primary analysis.

However, excluding flagged users may introduce selection bias and does not reconstruct the original randomized assignments.

### 6.3 Statistical Limitations

The primary p-value was greater than 0.05, and the confidence interval included zero.

The analysis did not establish a statistically significant conversion difference.

Non-significance does not prove equivalence, absence of an effect, or that the redesigned page is harmful.

### 6.4 Multiple Comparisons

The three secondary sensitivity analyses were conducted to evaluate robustness, not to discover a statistically significant result.

They do not replace the approved primary hypothesis test.

No exploratory result should be presented as a new confirmatory finding.

### 6.5 Financial Limitations

The dataset does not contain verified revenue per conversion, contribution profit, implementation costs, or incremental operating costs.

Actual incremental revenue and rollout profitability cannot be established.

Missing financial information must not be interpreted as zero financial impact.

### 6.6 Causal Interpretation

Because original randomization assignments cannot be independently verified, the analysis does not establish causal certainty.

The conclusions remain conditional on the credibility of the recorded data and analytical assumptions.

---

## 7. Final Product Manager Recommendation

### Decision: Retain the Original Landing Page — Conditional

The available evidence does not justify rolling out the redesigned landing page.

The primary analysis and three secondary sensitivity analyses produced consistent numerical conclusions.

None demonstrated a statistically significant conversion improvement, and all confidence interval upper bounds were below the approved +1 percentage-point MPE.

### Recommended Next Actions

1. Retain the existing landing page for the current rollout decision.
2. Investigate whether original randomization and exposure logs can be recovered.
3. Review experiment instrumentation and group/page assignment consistency.
4. If the redesign remains strategically important, conduct a new experiment with independently verifiable user assignments.
5. Use prospective sample-size planning and the approved practical-improvement threshold for future experiment design.
6. Evaluate verified business value and implementation costs before any future rollout.

### Final Decision Status

**Retain original — conditional on data-quality credibility and operational review.**

This recommendation follows the approved experiment decision framework and does not claim that the redesigned page is definitively harmful or equivalent to the original.

---

## 8. Reproducibility and Supporting Files

The analysis is supported by the following project files:

- `docs/experiment_design.md` — Approved experiment design and decision rules.
- `docs/data_quality_report.md` — Data-cleaning methodology and assignment limitations.
- `notebooks/05_core_statistical_analysis.ipynb` — Primary statistical analysis.
- `docs/05_statistical_analysis_report.md` — Primary statistical findings.
- `notebooks/06_power_mde_business_impact.ipynb` — Power, MDE, and business-impact calculations.
- `docs/06_power_mde_business_impact_report.md` — Phase 06 findings.
- `notebooks/07_robustness_decision_framework.ipynb` — Phase 07 robustness calculations and decision framework.
- `docs/07_robustness_decision_report.md` — Phase 07 findings and recommendation.

The Phase 07 sensitivity analyses use the provisional user-level dataset generated during Phase 03.

The original primary analysis is preserved, and the sensitivity analyses are reported separately.
