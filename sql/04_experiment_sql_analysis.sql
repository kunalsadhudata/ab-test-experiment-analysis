
-- ============================================================
-- PROJECT: A/B Test and Experiment Analysis
-- PHASE 04: Randomisation Check and SQL Summary
-- DATABASE: ab_test_analysis
-- TABLE: public.ab_experiment_users
-- ============================================================

-- DATASET:
-- Provisional user-level experiment dataset.
-- Expected records: 290,584 unique users.
--
-- IMPORTANT LIMITATION:
-- The retained experiment group is based on the earliest
-- observed record per user.
-- Original randomisation assignments cannot be independently
-- verified because an assignment log is unavailable.
--
-- This analysis includes allocation checks, SRM validation,
-- descriptive conversion summaries, and data-quality checks.
--
-- Statistical hypothesis testing and launch recommendations
-- are outside the scope of Phase 04.
-- ============================================================

-- ============================================================
-- SECTION 1: DATASET VALIDATION
-- ============================================================

-- 1.1 Verify total records and unique users
-- Expected: 290,584 rows and 290,584 unique users

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT user_id) AS unique_users
FROM public.ab_experiment_users;


-- 1.2 Check missing values across all eight columns
-- Expected: Zero missing values in every column

SELECT
    COUNT(*) FILTER (WHERE user_id IS NULL)
        AS missing_user_id,

    COUNT(*) FILTER (WHERE "timestamp" IS NULL)
        AS missing_timestamp,

    COUNT(*) FILTER (WHERE "group" IS NULL)
        AS missing_group,

    COUNT(*) FILTER (WHERE landing_page IS NULL)
        AS missing_landing_page,

    COUNT(*) FILTER (WHERE converted IS NULL)
        AS missing_converted,

    COUNT(*) FILTER (WHERE was_repeated_user IS NULL)
        AS missing_repeated_flag,

    COUNT(*) FILTER (
        WHERE had_cross_group_assignment IS NULL
    ) AS missing_cross_group_flag,

    COUNT(*) FILTER (WHERE page_mismatch IS NULL)
        AS missing_page_mismatch_flag

FROM public.ab_experiment_users;


-- ============================================================
-- SECTION 2: EXPERIMENT ALLOCATION
-- ============================================================

-- 2.1 Count users by experiment group
-- Previously verified:
-- Control:   145,294 users
-- Treatment: 145,290 users

SELECT
    "group" AS experiment_group,
    COUNT(*) AS total_users
FROM public.ab_experiment_users
GROUP BY "group"
ORDER BY "group";


-- 2.2 Calculate allocation percentages
-- Planned allocation: 50% control / 50% treatment
-- Previously verified:
-- Control:   50.0007%
-- Treatment: 49.9993%

SELECT
    "group" AS experiment_group,
    COUNT(*) AS total_users,

    ROUND(
        100.0 * COUNT(*) /
        SUM(COUNT(*)) OVER (),
        4
    ) AS allocation_percentage

FROM public.ab_experiment_users
GROUP BY "group"
ORDER BY "group";


-- ============================================================
-- SECTION 3: SAMPLE RATIO MISMATCH (SRM) TEST
-- ============================================================

-- Planned allocation: 50% control / 50% treatment
-- SRM alarm threshold: p-value < 0.001
--
-- Previously verified:
-- Chi-square statistic: 0.00005506
-- SRM p-value: 0.994079
-- Result: No SRM alarm
--
-- IMPORTANT:
-- No SRM alarm does not prove that randomisation was valid.
-- The earliest-observed assignment remains provisional.

WITH observed AS (
    SELECT
        COUNT(*) FILTER (
            WHERE "group" = 'control'
        )::DOUBLE PRECISION AS control_users,

        COUNT(*) FILTER (
            WHERE "group" = 'treatment'
        )::DOUBLE PRECISION AS treatment_users

    FROM public.ab_experiment_users
),
srm AS (
    SELECT
        POWER(control_users - treatment_users, 2)
        / (control_users + treatment_users)
        AS chi_square_statistic
    FROM observed
)
SELECT
    ROUND(chi_square_statistic::NUMERIC, 8)
        AS chi_square_statistic,

    ROUND(
        (
            2.0 * (
                1.0 - (
                    0.5 * (
                        1.0 + ERF(
                            SQRT(chi_square_statistic) / SQRT(2.0)
                        )
                    )
                )
            )
        )::NUMERIC,
        6
    ) AS srm_p_value

FROM srm;

-- ============================================================
-- SECTION 4: DESCRIPTIVE CONVERSION ANALYSIS
-- ============================================================

-- 4.1 Conversion counts by experiment group
-- Previously verified:
-- Control:   145,294 users, 17,496 converted
-- Treatment: 145,290 users, 17,265 converted

SELECT
    "group" AS experiment_group,
    COUNT(*) AS total_users,

    COUNT(*) FILTER (
        WHERE converted = 1
    ) AS converted_users,

    COUNT(*) FILTER (
        WHERE converted = 0
    ) AS non_converted_users

FROM public.ab_experiment_users
GROUP BY "group"
ORDER BY "group";


-- 4.2 Conversion rates by experiment group
-- Previously verified:
-- Control:   12.0418%
-- Treatment: 11.8831%

SELECT
    "group" AS experiment_group,
    COUNT(*) AS total_users,
    SUM(converted) AS converted_users,

    ROUND(
        100.0 * SUM(converted) / COUNT(*),
        4
    ) AS conversion_rate_pct

FROM public.ab_experiment_users
GROUP BY "group"
ORDER BY "group";


-- 4.3 Absolute conversion-rate difference
-- Formula: Treatment rate - Control rate
-- Previously verified: -0.1587 percentage points
--
-- This is descriptive, not a statistical significance test.

WITH conversion_rates AS (
    SELECT
        "group" AS experiment_group,
        AVG(converted::NUMERIC) AS conversion_rate
    FROM public.ab_experiment_users
    GROUP BY "group"
)
SELECT
    ROUND(
        100 * MAX(conversion_rate) FILTER (
            WHERE experiment_group = 'control'
        ),
        4
    ) AS control_conversion_pct,

    ROUND(
        100 * MAX(conversion_rate) FILTER (
            WHERE experiment_group = 'treatment'
        ),
        4
    ) AS treatment_conversion_pct,

    ROUND(
        100 * (
            MAX(conversion_rate) FILTER (
                WHERE experiment_group = 'treatment'
            )
            -
            MAX(conversion_rate) FILTER (
                WHERE experiment_group = 'control'
            )
        ),
        4
    ) AS absolute_difference_pp

FROM conversion_rates;

-- ============================================================
-- SECTION 5: DATA-QUALITY VALIDATION
-- ============================================================

-- 5.1 Overall data-quality flag counts
-- Previously verified:
-- Repeated users:    3,894
-- Cross-group users: 1,895
-- Page mismatches:   1,949
--
-- Flags can overlap; do not sum them as unique users.

SELECT
    COUNT(*) FILTER (
        WHERE was_repeated_user = TRUE
    ) AS repeated_users,

    COUNT(*) FILTER (
        WHERE had_cross_group_assignment = TRUE
    ) AS cross_group_users,

    COUNT(*) FILTER (
        WHERE page_mismatch = TRUE
    ) AS page_mismatch_users

FROM public.ab_experiment_users;


-- 5.2 Group and landing-page combinations
-- Previously verified:
-- Control / old_page:     144,319
-- Control / new_page:         975
-- Treatment / new_page:  144,316
-- Treatment / old_page:      974

SELECT
    "group" AS experiment_group,
    landing_page,
    page_mismatch,
    COUNT(*) AS total_users

FROM public.ab_experiment_users

GROUP BY
    "group",
    landing_page,
    page_mismatch

ORDER BY
    "group",
    landing_page,
    page_mismatch;


-- 5.3 Data-quality flags by experiment group
-- Previously verified:
-- Control:   2,001 repeated, 994 cross-group, 975 mismatch
-- Treatment: 1,893 repeated, 901 cross-group, 974 mismatch

SELECT
    "group" AS experiment_group,
    COUNT(*) AS total_users,

    COUNT(*) FILTER (
        WHERE was_repeated_user = TRUE
    ) AS repeated_users,

    COUNT(*) FILTER (
        WHERE had_cross_group_assignment = TRUE
    ) AS cross_group_users,

    COUNT(*) FILTER (
        WHERE page_mismatch = TRUE
    ) AS page_mismatch_users

FROM public.ab_experiment_users

GROUP BY "group"
ORDER BY "group";

-- ============================================================
-- SECTION 6: FINAL DATA INTEGRITY CHECK
-- ============================================================

-- Previously verified:
-- Total users: 290,584
-- Invalid group values: 0
-- Invalid page values: 0
-- Invalid conversion values: 0
-- Inconsistent mismatch flags: 0

SELECT
    COUNT(*) AS total_users,

    COUNT(*) FILTER (
        WHERE "group" NOT IN ('control', 'treatment')
    ) AS invalid_group_values,

    COUNT(*) FILTER (
        WHERE landing_page NOT IN ('old_page', 'new_page')
    ) AS invalid_page_values,

    COUNT(*) FILTER (
        WHERE converted NOT IN (0, 1)
    ) AS invalid_conversion_values,

    COUNT(*) FILTER (
        WHERE page_mismatch IS DISTINCT FROM
            CASE
                WHEN "group" = 'control'
                    THEN landing_page <> 'old_page'
                WHEN "group" = 'treatment'
                    THEN landing_page <> 'new_page'
                ELSE TRUE
            END
    ) AS inconsistent_mismatch_flags

FROM public.ab_experiment_users;

