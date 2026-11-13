# A/B Test — Product Manager Decision Memo

**Experiment:** Landing Page Redesign  
**Decision Owner:** Product Manager  
**Analysis Status:** Provisional — original assignment logs unavailable  
**Recommendation:** Retain original landing page — conditional

## 1. Executive Decision

**Do not roll out the redesigned landing page based on the available evidence.**

The redesigned page did not demonstrate a statistically significant conversion improvement, and the observed effect fell below the approved practical improvement threshold of +1 percentage point (pp).

Retaining the original page is recommended for the current rollout decision, conditional on data-quality credibility and operational review.

## 2. Business Context

The experiment compared an existing landing page (control) with a redesigned version (treatment). The primary business objective was to determine whether the redesign improved user-level conversion sufficiently to justify deployment.

The analysis used 290,584 provisional user-level records.

## 3. Key Statistical Evidence

| Metric | Verified Result |
|---|---|
| Control users | 145,294 |
| Treatment users | 145,290 |
| Control conversion rate | 12.0418% |
| Treatment conversion rate | 11.8831% |
| Observed treatment effect | −0.1587 pp |
| Two-sided p-value | 0.187589 |
| Newcombe 95% confidence interval | [−0.3947, +0.0773] pp |
| Significance threshold | 0.05 |
| Approved practical improvement threshold | +1.0 pp |

The p-value exceeds 0.05, and the confidence interval includes zero. Therefore, the analysis does not establish a statistically significant conversion difference.

The confidence interval's upper bound is also below the approved +1 pp improvement threshold. The available evidence does not support the business case for rolling out the redesign under the approved decision framework.

These findings do not prove that the two landing pages are equivalent or that the redesign causes harm.

## 4. Robustness Assessment

Three secondary sensitivity analyses excluded page-mismatch users, cross-group users, and repeated users separately.

Across the primary and all three sensitivity analyses:

- Estimated treatment effects remained slightly negative.
- All p-values exceeded 0.05.
- All 95% confidence intervals included zero.
- All upper confidence bounds remained below the approved +1 pp threshold.

The numerical conclusion was stable across these exclusion rules. However, these checks cannot independently verify the original randomization.

## 5. Evidence Limitations

The original randomized assignment and exposure logs were unavailable. For users with repeated observations, the earliest recorded observation was retained as a provisional assignment proxy.

The dataset contained documented repeated-user, cross-group assignment, and page-mismatch flags. Consequently, original assignment integrity cannot be conclusively established, and causal conclusions remain qualified.

The dataset also lacks verified revenue per conversion, contribution profit, and implementation or operating costs. No actual revenue impact, profitability, or ROI claim is supported.

## 6. Recommended Next Actions

1. Retain the original landing page for the current rollout decision, subject to operational review.
2. Investigate whether original randomization and exposure logs can be recovered.
3. Review experiment instrumentation, assignment consistency, and data-quality issues.
4. If the redesign remains strategically important, consider a new properly instrumented experiment using prospective sample-size planning.
5. Obtain verified financial and implementation-cost data before assessing commercial returns.

## 7. Final Decision Status

**RETAIN ORIGINAL — CONDITIONAL**

The available statistical evidence does not justify deploying the redesign under the approved +1 pp practical improvement criterion. The recommendation remains conditional on data-quality credibility and operational review.

**Supporting evidence:** Phase 05 statistical analysis, Phase 06 planning and business-impact report, Phase 07 robustness and decision report, and Phase 08 visualizations.