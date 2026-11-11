# A/B Test and Experiment Analysis
## Experiment Design Document

### Summary

**Business question:** Does a redesigned landing page improve user conversion compared with the original landing page?  
**Primary metric:** User conversion rate.  
**Primary test:** Two-sided two-proportion z-test at α = 0.05, with a 95% confidence interval for absolute conversion lift as the primary reported result.  
**Assumed MPE:** Approved +1 percentage point, locked before outcome analysis.  
**Decision rule:** Ship if the entire 95% CI exceeds the MPE; retain the original if the entire CI is below the MPE; otherwise inconclusive, subject to data-quality checks.

**Project:** A/B Test and Experiment Analysis  
**Document status:** Approved  
**Analysis type:** Retrospective analysis of a public A/B testing dataset  
**Primary stakeholder:** Product Manager  
**Dataset status:** Not yet downloaded or analyzed

---

## 1. Business Context and Stakeholder

### Business scenario

A hypothetical e-commerce company wants to evaluate whether a redesigned landing page improves user conversions compared with its original landing page.

The Product Manager must decide whether to:

- Launch the redesigned landing page.
- Retain the original landing page.
- Recommend a larger or longer follow-up experiment.

### Business objective

Evaluate the direction, magnitude, uncertainty, and practical business value of the redesigned landing page's effect on user conversion.

### Experiment versions

- **Control:** Original landing page (`old_page`).
- **Treatment:** Redesigned landing page (`new_page`).

These labels are expected from the planned public dataset and must be verified after acquisition.

The business scenario is hypothetical and must not be presented as an actual company engagement.

## 2. Hypotheses

Let:

- $p_c$ = true control-group conversion probability.
- $p_t$ = true treatment-group conversion probability.

**Null hypothesis (H₀):**

$$
H_0:p_t=p_c
$$

**Alternative hypothesis (H₁):**

$$
H_1:p_t\neq p_c
$$

We will use a two-sided test because the redesign could improve or worsen conversions.

The statistical significance threshold is fixed at:

$$
\alpha=0.05
$$

We will not change the hypotheses or significance threshold after examining outcomes.

## 3. Primary Metric and Definitions

### Primary metric: User conversion rate

$$
\text{Conversion Rate}=
\frac{\text{Unique exposed users who converted}}
{\text{Unique exposed users}}\times100
$$

**Numerator:** Number of unique eligible exposed users recorded as converted.

**Denominator:** Number of unique eligible exposed users assigned to the relevant experiment group.

A user contributes one binary conversion outcome, 0 or 1, to the primary analysis.

The expected dataset field `converted` will be checked against the source documentation before interpretation.

### Primary comparison

The only primary comparison is treatment versus control on user conversion rate.

**Absolute conversion lift:**

$$
\Delta=p_t-p_c
$$

The estimated lift is:

$$
\hat{\Delta}=\hat{p}_t-\hat{p}_c
$$

We will report the absolute difference in percentage points.

**Relative lift:**

$$
\text{Relative Lift}=
\frac{\hat{p}_t-\hat{p}_c}{\hat{p}_c}\times100
$$

Relative lift will be reported as a supporting measure when the observed control conversion rate is nonzero.

The conversion attribution window, definition of exposure, and any unavailable business metadata will be documented as limitations rather than guessed.

## 4. Unit of Randomisation and Analysis

**Assumed randomisation unit:** Individual user.

**Planned analysis unit:** Individual user.

Each eligible user should contribute one independent observation.

We will investigate:

- Duplicate user IDs.
- Users associated with multiple experiment groups.
- Users associated with inconsistent landing-page versions.
- Possible repeated exposure records.

User-level randomisation is an assumption, not a verified dataset fact.

SRM, duplicate diagnostics, group/page mismatch checks, and date coverage will provide evidence about experiment integrity but cannot independently prove successful randomisation.

## 5. Traffic Allocation

The planned allocation is:

| Group | Planned allocation |
|---|---:|
| Control | 50% |
| Treatment | 50% |

Actual allocation will be measured from the acquired dataset.

Small deviations can occur naturally under random assignment.

Unexpectedly large deviations will be investigated using a Sample Ratio Mismatch test.

## 6. Statistical Plan

### Primary reported result

The primary result will be the estimated absolute conversion-rate difference and its **95% confidence interval**.

We will report:

1. Control and treatment sample sizes.
2. Conversions and non-conversions in each group.
3. Conversion rates.
4. Absolute lift in percentage points.
5. 95% confidence interval for absolute lift.
6. Two-sided p-value.
7. Relative lift as a derived measure.

### Primary hypothesis test

We will use a two-proportion z-test with:

$$
H_0:p_t=p_c
$$

and:

$$
H_1:p_t\neq p_c
$$

The significance level is 0.05.

The pooled standard error will be used for the null-hypothesis z-test.

The confidence interval will estimate the uncertainty around the difference in conversion rates. We will use an appropriate two-sample proportion-difference confidence interval, preferably a score-based method, and document the selected implementation before calculating results.

### Cross-check

We will also run an uncorrected Pearson chi-square test on the 2×2 table of group by conversion outcome.

**The Pearson chi-square test will be run WITHOUT continuity correction** (for example, `correction=False` in SciPy) so that the chi-square statistic equals the squared z-statistic under equivalent assumptions.

Under equivalent assumptions, the chi-square statistic should equal the squared z-statistic:

$$
\chi^2=z^2
$$

The cross-check is a validation procedure, not a separate primary discovery.

### Statistical assumptions

We will assess:

- One eligible observation per user.
- Independence between users.
- No material interference between users.
- One consistent landing-page version per user.
- Sufficient conversions and non-conversions in both groups for the normal approximation.
- Credible assignment and measurement processes.

If assumptions are not adequately supported, we will disclose the limitation and reconsider the appropriate analysis.

## 7. Practical Significance — Minimum Practical Effect (MPE)

The **Assumed Minimum Practical Effect (MPE)** represents the smallest positive absolute conversion-rate improvement that would justify adopting the redesign.

It is a business-planning parameter, not a statistical significance threshold.

A fixed percentage-point improvement can represent very different relative improvements depending on the baseline conversion rate.

The baseline conversion rate has not yet been observed.

### Break-even justification

A practical MPE should ideally reflect:

- Redesign implementation costs.
- Ongoing maintenance costs.
- Expected eligible traffic.
- Incremental contribution profit per conversion.
- Business risks and operational constraints.

For illustration only, assume:

- Incremental redesign and maintenance cost: **INR 10,000 per month**.
- Eligible traffic: **10,000 users per month**.
- Incremental contribution profit: **INR 200 per conversion**.

The break-even lift would be:

$$
\frac{10{,}000}{200\times10{,}000}
=0.005
$$

This equals **0.5 percentage points**.

**All figures in this example are fictional.**

### MPE planning rule

The MPE must be fixed before outcome analysis.

Because actual company economics are unavailable, the project will use a clearly labeled assumed MPE.

**Approved primary MPE: +1 percentage point (planning assumption, not a verified business requirement), locked on 2026-11-11.**

We will also present a sensitivity table using assumed MPE values of:

| Scenario | Assumed MPE |
|---|---:|
| Lower threshold | +0.5 percentage points |
| Approved primary threshold | +1.0 percentage point |
| Higher threshold | +2.0 percentage points |

These sensitivity scenarios will not replace or retroactively change the primary MPE.

## 8. Power and Minimum Detectable Effect (MDE)

We will use:

- Two-sided significance level: 0.05.
- Target statistical power: 80%.
- Planned allocation: 50/50.

### Existing dataset MDE

After data cleaning, we will calculate the MDE corresponding to 80% power using the actual eligible sample sizes and the **observed control conversion rate as the documented baseline planning input**.

The observed control conversion rate will be used as a **variance input, not the effect being tested**.

This calculation describes the effect size the available sample would be **able to detect** with 80% probability under the stated assumptions.

### Follow-up sample size

We will calculate the required sample size per group for a future experiment designed to detect the fixed MPE with 80% power.

The calculation will use the **observed control conversion rate as the documented baseline planning input**, treated as a variance input rather than the effect being tested.

The calculation will account for the expected allocation.

### Prohibited analysis: Observed power

We will not calculate post-hoc observed power by substituting the observed treatment effect into the power formula.

Observed power largely repeats information contained in the observed test statistic and does not meaningfully resolve uncertainty.

Instead, we will interpret the confidence interval and use prospective power calculations for future planning.

## 9. Data Quality and SRM Plan

### Sample Ratio Mismatch

We will use a chi-square goodness-of-fit test to compare observed allocation against the planned 50/50 split.

The SRM alarm threshold is:

$$
p_{\text{SRM}}<0.001
$$

SRM will be checked:

1. Before cleaning, using group counts from the raw data.
2. After cleaning, using the eligible user-level analysis population.

We will distinguish raw-record counts from unique-user counts and document any differences in their interpretation.

An SRM alarm will trigger investigation before conversion lift is interpreted.

### Planned cleaning order

The following order will guide the data-quality workflow, subject to verifying the dataset structure:

1. Preserve the raw dataset unchanged.
2. Inspect column names, types, missing values, and identifiers.
3. Validate group and landing-page labels.
4. Identify missing or invalid required values.
5. Investigate group/page mismatches.
6. Investigate duplicate user IDs and conflicting assignments.
7. Apply documented eligibility and deduplication rules.
8. Verify one eligible observation per user.
9. Recalculate group counts and perform post-cleaning SRM.
10. Create the final eligible analysis population.

Before any outcome-based analysis, exact handling rules for duplicates, conflicts, and exclusions will be recorded using available source documentation and observed data-quality structure, without selecting rules to favor a conversion result.

### Cleaning and Decisions Log

For each cleaning rule, record:

- Rule ID and description.
- Reason for the rule.
- Number of records and users affected.
- Before and after counts.
- Whether records were removed, modified, or retained.
- Verification evidence.

No records will be silently deleted.

### Sensitivity analysis

Where feasible, we will compare the primary eligible-user analysis with a clearly defined alternative that retains otherwise excluded observations without violating the one-user-one-observation requirement.

**If group/page mismatch rows exist, the alternative analysis will use the assigned group instead of the page shown, and both versions will be reported.**

We will report whether conclusions are sensitive to defensible inclusion and exclusion choices.

## 10. Decision Framework

Business decisions will be based primarily on the location of the 95% confidence interval for absolute conversion lift relative to zero and the fixed MPE.

All decisions require acceptable data quality and sufficiently credible test assumptions.

| Condition | Recommendation |
|---|---|
| Entire 95% CI above the MPE | **Ship:** evidence supports a practically worthwhile improvement, subject to operational review |
| Entire 95% CI below the MPE | **Retain original:** a gain meeting the MPE is not supported by the interval |
| CI crosses the MPE, or includes zero while still allowing a meaningful gain | **Inconclusive:** recommend a properly powered follow-up experiment |
| SRM alarm or serious data-quality failure | **No decision:** investigate before interpreting lift |

For exact boundary cases, a confidence interval whose upper bound is below the MPE supports retaining the original; a confidence interval whose lower bound exceeds the MPE supports shipping. Intervals containing the MPE are inconclusive.

An interval entirely above zero but below the MPE may indicate a positive statistical effect that is not sufficiently valuable to justify implementation.

A statistically insignificant result does not automatically establish equivalence.

### Follow-up experiment

If the result is inconclusive, we will recommend a new experiment with a stated sample size per group, calculated using the fixed MPE and the planning assumptions.

Because the dataset is historical, we cannot literally extend the original experiment.

## 11. Exploratory Analysis Policy

The project has:

- One primary metric.
- One primary control-versus-treatment comparison.
- One fixed-horizon primary analysis.

Exploratory checks may include:

- Day-of-week conversion patterns.
- Early versus late experiment periods.
- Time-based treatment-effect patterns.
- User segments, only where suitable verified fields exist.

These checks are not additional primary hypotheses.

If multiple exploratory hypothesis tests are conducted, we will apply a documented multiple-testing correction such as Holm or Bonferroni, or explicitly label unadjusted findings as non-confirmatory.

Exploratory results will not override the primary experiment conclusion.

### No peeking or optional stopping

The primary analysis will use the full eligible historical dataset once the cleaning and analysis rules have been finalized.

Daily or weekly views may be used as diagnostics, including for possible novelty effects, but not as rules for stopping or restarting the experiment.

We will not repeatedly change analysis choices to obtain statistical significance.

## 12. Assumptions and Limitations

The following are planning assumptions or potential limitations until verified:

- The public dataset represents an A/B experiment.
- Assignment occurred at user level.
- The intended allocation was 50/50.
- Control and treatment correspond to the expected page labels.
- The conversion outcome is correctly recorded.
- Users were independently assigned and measured.
- Users did not materially influence each other's outcomes.
- The conversion attribution window may be unavailable.
- Business revenue, profit, implementation cost, and maintenance cost may be unavailable.
- The experiment's original operational procedures may not be fully documented.

Diagnostics can identify inconsistencies but cannot guarantee that all assumptions hold.

If necessary information is unavailable, we will document the limitation rather than invent values.

All business impact estimates will distinguish observed data from illustrative assumptions.

## 13. Disclosure

This project is a **retrospective educational analysis of an existing public A/B testing dataset**.

The e-commerce business scenario and Product Manager stakeholder are hypothetical case-study constructs.

The analysis plan is being documented before downloading and examining conversion outcomes as a **simulated pre-registration exercise**.

This is not genuine prospective pre-registration because the underlying experiment has already been conducted.

No claim will be made that we designed, launched, or operated the original experiment.

The final analysis will transparently report statistically significant, insignificant, positive, or negative results according to the verified evidence.

---

**Document status:** Approved.

**Next milestone:** Save the approved design to `docs/experiment_design.md`, verify its contents, and continue Phase 01 documentation and GitHub work.

**No experiment outcomes have been analyzed.**