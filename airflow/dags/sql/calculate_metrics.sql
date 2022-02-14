-- Total expenditure
SELECT sum(value)
FROM fact_award;

-- Expenditure per year
SELECT dim_date.year, sum(value)
FROM dim_date
INNER JOIN fact_award
ON dim_date.id = fact_award.id_date
GROUP BY dim_date.year;

-- Expenditure per year and month
SELECT dim_date.year, dim_date.month, sum(value)
FROM dim_date
INNER JOIN fact_award
ON dim_date.id = fact_award.id_date
GROUP BY dim_date.year, dim_date.month;

-- Expenditure per platform
SELECT dim_platform.name, sum(value)
FROM dim_platform
INNER JOIN fact_award
ON fact_award.id_platform = dim_platform.id
GROUP BY dim_platform.id;

-- Expenditure per platform per year
SELECT dim_platform.name, dim_date.year, sum(value)
FROM dim_platform
INNER JOIN fact_award
ON fact_award.id_platform = dim_platform.id
INNER JOIN dim_date
ON fact_award.id_date = dim_date.id
GROUP BY dim_platform.id, dim_date.year;

-- Expenditure per platform per year and month
SELECT dim_platform.name, dim_date.year, dim_date.month, sum(value)
FROM dim_platform
INNER JOIN fact_award
ON fact_award.id_platform = dim_platform.id
INNER JOIN dim_date
ON fact_award.id_date = dim_date.id
GROUP BY dim_platform.id, dim_date.year, dim_date.month;

-- Awards per platform
SELECT dim_platform.name, count(dim_platform.id)
FROM dim_platform
INNER JOIN fact_award
ON fact_award.id_platform = dim_platform.id
GROUP BY dim_platform.id;

-- Awards per platform per year
SELECT dim_platform.name, dim_date.year, count(dim_platform.id)
FROM dim_platform
INNER JOIN fact_award
ON fact_award.id_platform = dim_platform.id
INNER JOIN dim_date
ON fact_award.id_date = dim_date.id
GROUP BY dim_platform.id, dim_date.year;

-- Awards per platform per year and month
SELECT dim_platform.name, dim_date.year, dim_date.month, count(dim_platform.id)
FROM dim_platform
INNER JOIN fact_award
ON fact_award.id_platform = dim_platform.id
INNER JOIN dim_date
ON fact_award.id_date = dim_date.id
GROUP BY dim_platform.id, dim_date.year, dim_date.month;
