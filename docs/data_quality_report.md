
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



---

## Phase 03 — Approved Provisional Cleaning Policy

### Policy Status

**Status:** Approved before cleaning implementation and before treatment-effect analysis.

This policy governs the preparation of the provisional
user-level analysis dataset.

### 1. Raw Data Preservation

The original `data/ab_data.csv` must remain unchanged.

All cleaning operations must be performed on separate
DataFrame copies.

### 2. Analysis Unit

The approved experiment design specifies the user as
the analysis unit.

The provisional analysis dataset will contain exactly
one observation per unique `user_id`.

### 3. Repeated-User Handling

For users with multiple observations, retain the
earliest recorded observation by timestamp.

This is a documented proxy for initial assignment,
not proof of the original randomized assignment.

Users with conflicting recorded group assignments
must be flagged.

### 4. Group and Landing-Page Mismatches

Do not automatically exclude users whose recorded
group and landing page disagree.

Preserve the recorded `group` and `landing_page`
values separately.

Create a flag identifying group-page mismatches.

### 5. Provisional Population

The provisional user-level population contains
290,584 unique users.

The earliest-observation audit identified:

- Control: 145,294 users
- Treatment: 145,290 users
- Matching group-page observations: 288,635 users
- Mismatching group-page observations: 1,949 users

These are pre-implementation audit results,
not final cleaned-dataset validation results.

### 6. Assignment Ambiguity

The dataset does not establish that the earliest
recorded group is the true original randomized
assignment.

Users observed in both groups must be flagged.

The provisional dataset must not be described as
a verified intention-to-treat population.

### 7. Sensitivity Analysis

Plan sensitivity analyses addressing:

- Users with conflicting group assignments
- Users with group-page mismatches

Sensitivity analyses must be clearly distinguished
from the primary provisional analysis.

No analysis population may be selected based on
observed conversion effects.

### 8. Sample-Ratio Mismatch

The approved expected allocation is 50/50.

The approved SRM alarm threshold is p < 0.001.

The pre-cleaning raw-record SRM diagnostic found:

- Control records: 147,202
- Treatment records: 147,276
- Chi-square statistic: 0.018596
- SRM p-value: 0.891532
- Status: No alarm

This raw-record diagnostic is not a substitute
for the post-cleaning user-level SRM check.

### 9. Implementation Safeguards

Before treatment-effect analysis:

- Preserve the original dataset.
- Create a separate provisional cleaned dataset.
- Retain one earliest observation per user.
- Preserve assignment and exposure fields.
- Retain and document ambiguity flags.
- Validate user uniqueness and row counts.
- Perform the post-cleaning user-level SRM check.
- Document all implemented transformations.

### 10. Interpretation Limitations

The earliest recorded observation may not represent
the original randomized assignment.

Any resulting treatment-effect estimate must be
interpreted with this limitation explicitly stated.

No conversion-rate comparison, statistical
significance test, or treatment-effect conclusion
has been performed in Phase 03.


---

## Phase 03 — Cleaning Implementation and Validation Results

### Implementation Status

**Status:** Provisional user-level dataset created,
exported, and validated successfully.

The approved provisional cleaning policy was
implemented without modifying the original dataset.

### 1. Input Dataset

Source file: `data/ab_data.csv`

- Original observations: 294,478
- Original columns: 5
- Unique users: 290,584

The raw source file was preserved unchanged.

### 2. User-Level Deduplication

The earliest recorded observation was retained
for each unique `user_id`.

- Original observations: 294,478
- Provisional user-level observations: 290,584
- Observations not retained: 3,894
- Unique users excluded: 0

The retained observation is used as a proxy for
initial assignment, not as verified evidence of
the original randomized assignment.

### 3. Data-Quality Flags

Three Boolean flags were added:

| Flag | Users Flagged |
|---|---:|
| `was_repeated_user` | 3,894 |
| `had_cross_group_assignment` | 1,895 |
| `page_mismatch` | 1,949 |

The flags can overlap.

The `page_mismatch` flag describes the retained
earliest observation, not every observation
originally recorded for that user.

### 4. Final Provisional Dataset

Output file:
`data/processed/ab_data_provisional_user_level.csv`

- Rows: 290,584
- Columns: 8
- Unique users: 290,584
- Duplicate user IDs: 0
- Missing values: 0

Retained group counts:

| Group | Users |
|---|---:|
| Control | 145,294 |
| Treatment | 145,290 |
| Total | 290,584 |

All structural and categorical validations passed.

### 5. Sample-Ratio Mismatch Validation

Expected allocation: 50% control / 50% treatment.

Approved SRM alarm threshold: p < 0.001.

| Metric | Raw Records | Provisional Users |
|---|---:|---:|
| Control | 147,202 | 145,294 |
| Treatment | 147,276 | 145,290 |
| Chi-square statistic | 0.018596 | 0.000055 |
| SRM p-value | 0.891532 | 0.994079 |
| SRM status | No alarm | No alarm |

Neither diagnostic crossed the approved SRM
alarm threshold.

These results do not prove that original
randomization assignments were correctly recorded.

### 6. Export Verification

The exported CSV was reloaded using pandas.

The reloaded dataset was compared with the
provisional DataFrame after normalizing
DataFrame indexes for comparison.

Validation confirmed:

- Identical row and column counts
- Identical column names and ordering
- Identical values across all columns
- Identical data types
- Unique user identifiers
- No missing values
- Correct data-quality flag counts

The exported dataset passed read-back validation.

### 7. Statistical Interpretation

The dataset remains provisional because the
true original randomized assignment cannot be
verified from the available records.

The earliest recorded group is an assignment proxy.

Users with conflicting recorded assignments
and group-page mismatches remain flagged.

Sensitivity analyses must address these
ambiguities in later phases.

No treatment-effect estimate, conversion-rate
comparison, or statistical significance test
was performed during Phase 03.

### 8. Reproducibility

The cleaning and validation workflow is
documented in:

`notebooks/03_data_cleaning_validation.ipynb`

The provisional CSV is a derived artifact.

Its creation is reproducible from the raw
dataset using the documented notebook.
