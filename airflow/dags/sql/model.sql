INSERT INTO dim_purchaser (name)
    SELECT DISTINCT purchaser
    FROM stg_awards
ON CONFLICT (name) DO NOTHING;

INSERT INTO dim_supplier (name)
    SELECT DISTINCT supplier
    FROM stg_awards
ON CONFLICT (name) DO NOTHING;

INSERT INTO dim_tender (file_number, title, source)
    SELECT DISTINCT file_number, title, source
    FROM stg_awards
ON CONFLICT (file_number) DO NOTHING;

INSERT INTO dim_platform (name)
    SELECT DISTINCT platform
    FROM stg_awards
ON CONFLICT (name) DO NOTHING;

INSERT INTO dim_date (year, month, day, date)
    SELECT DISTINCT extract(YEAR FROM date) as year,
                    extract(MONTH FROM date) as month,
                    extract(DAY FROM date) as day,
                    date
    FROM stg_awards
ON CONFLICT (date) DO NOTHING;

INSERT INTO fact_award (id_purchaser,
                        id_supplier,
                        id_tender,
                        id_platform,
                        id_date,
                        value)
    SELECT
        p.id,
        s.id,
        t.id,
        pl.id,
        d.id,
        stg.value
    FROM
        stg_awards stg
        JOIN dim_purchaser AS p ON stg.purchaser = p.name
        JOIN dim_supplier AS s ON stg.supplier = s.name
        JOIN dim_tender as t ON stg.file_number = t.file_number
        JOIN dim_platform AS pl ON stg.platform = pl.name
        JOIN dim_date AS d ON stg.date = d.date;
