# Phase 04 — Randomisation Check and SQL Summary

## 1. Objective

Validate the provisional user-level A/B experiment dataset in PostgreSQL, assess the planned 50/50 allocation, reproduce the Sample Ratio Mismatch (SRM) test, and prepare descriptive conversion summaries.

**Database:** `ab_test_analysis`  
**Table:** `public.ab_experiment_users`  
**Source:** `data/processed/ab_data_provisional_user_level.csv`

## 2. Dataset Validation

| Validation | Verified result |
|---|---:|
| Total records | 290,584 |
| Unique users | 290,584 |
| Missing values | 0 across all eight columns |
| Invalid group values | 0 |
| Invalid landing-page values | 0 |
| Invalid conversion values | 0 |
| Inconsistent mismatch flags | 0 |

The PostgreSQL import passed the performed integrity checks.

## 3. Experiment Allocation

| Group | Users | Allocation |
|---|---:|---:|
| Control | 145,294 | 50.0007% |
| Treatment | 145,290 | 49.9993% |
| **Total** | **290,584** | **100%** |

The observed allocation closely matches the planned 50/50 split.

### Sample Ratio Mismatch Test

- **Test:** Chi-square goodness-of-fit
- **Degrees of freedom:** 1
- **Chi-square statistic:** 0.00005506
- **SRM p-value:** 0.994079
- **Approved alarm threshold:** p-value below 0.001
- **Result:** No SRM alarm

The test did not detect an unexpected sample allocation imbalance under the planned allocation model.

A non-significant SRM result does not establish that the original randomization was valid.

## 4. Descriptive Conversion Analysis

| Metric | Control | Treatment |
|---|---:|---:|
| Total users | 145,294 | 145,290 |
| Converted users | 17,496 | 17,265 |
| Non-converted users | 127,798 | 128,025 |
| Conversion rate | 12.0418% | 11.8831% |

**Observed absolute conversion-rate difference (Treatment − Control): −0.1587 percentage points.**

The treatment group has a slightly lower observed conversion rate. This is a descriptive comparison, not evidence of a statistically significant treatment effect.

No primary hypothesis test or launch decision was performed in Phase 04.

## 5. Data-Quality Findings

| Flag | Control | Treatment | Total |
|---|---:|---:|---:|
| Repeated users | 2,001 | 1,893 | 3,894 |
| Cross-group assignment | 994 | 901 | 1,895 |
| Page mismatch | 975 | 974 | 1,949 |

The flags may overlap and must not be summed to estimate the number of distinct affected users.

### Group and Page Consistency

| Group | Landing page | Users |
|---|---|---:|
| Control | old_page | 144,319 |
| Control | new_page | 975 |
| Treatment | new_page | 144,316 |
| Treatment | old_page | 974 |

- Correctly paired retained records: 288,635
- Mismatched retained records: 1,949

Mismatched and cross-group users were not automatically excluded.

## 6. Scientific Limitations

The original dataset does not contain an independently verified randomization assignment log.

For users with multiple records, the earliest chronologically observed record was retained. Its group is an **earliest-observed assignment proxy**, not a confirmed original assignment.

Consequently:

- The analysis is provisional and cannot be presented as a fully verified intention-to-treat estimate.
- The SRM result assesses allocation balance, not complete randomization validity.
- Group/page mismatches and cross-group assignment flags remain available for later sensitivity analyses.
- Observed conversion differences must not be interpreted as statistically significant without the prespecified hypothesis test.
- The approved hypotheses, significance level, and minimum practical effect remain unchanged.

## 7. Reproducibility

The SQL analysis is stored in:

`sql/04_experiment_sql_analysis.sql`

The analysis uses PostgreSQL 18 and the processed user-level CSV generated during Phase 03.

The raw and processed CSV datasets are intentionally excluded from Git. Reproducing the analysis requires obtaining the source data, applying the documented cleaning procedure, and loading the resulting provisional dataset into PostgreSQL.

## 8. Phase 04 Conclusion

The provisional user-level dataset passed the performed PostgreSQL integrity checks. The allocation closely matches the planned 50/50 split, and the SRM test produced no alarm.

The observed treatment conversion rate was lower than the control conversion rate by 0.1587 percentage points.

**No statistical significance conclusion or launch recommendation is made in this phase.**

The verified descriptive results provide the foundation for subsequent statistical analysis, subject to the documented assignment and exposure limitations.