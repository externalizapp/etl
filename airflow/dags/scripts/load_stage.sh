psql -c "DELETE FROM stg_awards;"
psql -c "\COPY stg_awards FROM '/home/contratos/data/awards-clean.csv' delimiter ',' csv header"
