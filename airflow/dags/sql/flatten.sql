INSERT INTO tenders
    SELECT
    dim_purchaser.id,
    dim_tender.id,
    dim_platform.id,

    dim_tender.title,
    dim_purchaser.name,

    dim_tender.file_number,
    dim_tender.source,
    dim_platform.name,
    json_agg(json_build_object(
            'id_supplier', dim_supplier.id,
            'name', dim_supplier.name,
            'value', fact_award.value,
            'date', dim_date.date)
    )

    FROM fact_award

    INNER JOIN dim_supplier
    ON fact_award.id_supplier = dim_supplier.id

    INNER JOIN dim_purchaser
    ON fact_award.id_purchaser = dim_purchaser.id

    INNER JOIN dim_tender
    ON fact_award.id_tender = dim_tender.id

    INNER JOIN dim_date
    ON fact_award.id_date = dim_date.id

    INNER JOIN dim_platform
    ON fact_award.id_platform = dim_platform.id

    GROUP BY 
    dim_purchaser.id,
    dim_tender.id,
    dim_platform.id;
