
# A/B Test and Experiment Analysis — Data Quality Report

## 1. Report Overview

**Project:** A/B Test and Experiment Analysis  
**Phase:** 02 — Data Acquisition and First Look  
**Dataset:** `data/ab_data.csv`  
**Audit notebook:** `notebooks/02_data_first_look.ipynb`  
**Status:** Initial data-quality audit completed; cleaning decisions pending.

This report documents observed dataset characteristics and data-quality findings before any cleaning, exclusion, or statistical hypothesis testing.

## 2. Dataset Structure

| Metric | Verified result |
|---|---:|
| Total records | 294,478 |
| Total columns | 5 |
| Unique users | 290,584 |
| Repeated user IDs (additional rows) | 3,894 |
| Exact duplicate rows | 0 |
| Missing cells | 0 |
| Invalid timestamps | 0 |

### Dataset Columns

| Column | Initial data type |
|---|---|
| user_id | int64 |
| timestamp | str |
| group | str |
| landing_page | str |
| converted | int64 |

Timestamp parsing was validated separately and produced `datetime64[us]` values.

## 3. Experiment Categories

The observed experiment groups are:

- `control`
- `treatment`

The observed landing pages are:

- `old_page`
- `new_page`

The conversion indicator contains only:

- `0`
- `1`

## 4. Experiment Date Range

**Earliest timestamp:** 2017-01-02 13:42:05.378582

**Latest timestamp:** 2017-01-24 13:41:54.460509

**Observed time span:** 21 days 23:59:49.081927

All 294,478 timestamps were successfully parsed.

## 5. Original Group Distribution

| Group | Records | Percentage |
|---|---:|---:|
| Control | 147,202 | 49.9874% |
| Treatment | 147,276 | 50.0126% |
| Total | 294,478 | 100% |

These are raw record-level distributions, not final eligible user-level sample sizes.

## 6. Repeated User Audit

The dataset contains 290,584 distinct user IDs.

| Observation frequency | Users |
|---|---:|
| One observation | 286,690 |
| Two observations | 3,894 |

Among the 3,894 repeated users:

- 1,895 appeared in both experiment groups.
- 1,999 had repeated observations within one group.
- All 3,894 had different timestamps across their observations.
- 864 had different conversion outcomes.

Repeated observations require an explicit user-level handling rule before inferential analysis.

## 7. Group–Landing Page Consistency

| Experiment group | New page | Old page |
|---|---:|---:|
| Control | 1,928 | 145,274 |
| Treatment | 145,311 | 1,965 |

Expected assignment mapping:

- Control → old page
- Treatment → new page

**Mismatched assignment rows:** 3,893

**Distinct users affected by mismatches:** 3,893

Of the mismatch-affected users, 1,895 also appeared across both experiment groups.

These mismatches are potential assignment or exposure-consistency problems and must be addressed before calculating final experimental outcomes.

## 8. Data Quality Issue Overlap

| Category | Distinct users |
|---|---:|
| Cross-group users | 1,895 |
| Within-group repeated users | 1,999 |
| Group–page mismatch-affected users | 3,893 |
| Total distinct users with identified issues | 3,894 |
| Users without identified issues | 286,690 |

The issue categories overlap and must not be added together as independent exclusion counts.

The 286,690 users without identified issues comprise:

| Group | Users |
|---|---:|
| Control | 143,293 |
| Treatment | 143,397 |
| Total | 286,690 |

This is a descriptive unaffected-user population, not yet an approved final analysis population.

## 9. Original Dataset Integrity

The notebook confirmed:

- Original row count preserved.
- Original column structure preserved.
- No missing values.
- No exact duplicate records.

No rows were deleted or modified during the initial first-look audit.

## 10. Outstanding Decisions

Before hypothesis testing, the project must:

1. Confirm the user-level experimental analysis unit and eligibility rules.
2. Establish and document the handling of repeated users and cross-group assignments.
3. Establish and document the handling of group–landing page mismatches.
4. Produce a reproducible analysis-ready dataset.
5. Reconcile all retained and excluded records.
6. Evaluate sample ratio mismatch using the approved experiment design.
7. Apply the pre-approved statistical analysis and decision framework.

No conversion-rate comparison, hypothesis test, p-value, confidence interval, or experiment recommendation is reported in this initial data-quality report.

## 11. Audit Conclusion

The original dataset is readable and structurally complete, with no missing values, invalid timestamps, or exact duplicate records.

However, repeated users, cross-group assignments, and group–landing page inconsistencies have been identified.

These findings require documented handling before the experiment can be analysed reliably.

**Phase 02 status:** Data acquisition and initial data-quality inspection performed. Documentation and subsequent verification remain in progress.
