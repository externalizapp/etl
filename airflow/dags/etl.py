#!/usr/bin/env python

from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from airflow.operators.postgres_operator import PostgresOperator
from airflow.utils.dates import days_ago

dag = DAG(
    'etl',
    description='Tenders ETL DAG',
    start_date = days_ago(1),
)

create_db_schema = PostgresOperator(
    task_id='create_db_schema',
    postgres_conn_id='postgres_contratos',
    sql='sql/create_db_schema.sql',
    dag=dag,
)

scrap_bopv = BashOperator(
    task_id='scrap_bopv',
    bash_command='sleep 0',
    dag=dag,
)

scrap_boe = BashOperator(
    task_id='scrap_boe',
    bash_command='sleep 0',
    dag=dag,
)

merge = BashOperator(
    task_id='merge',
    bash_command='sleep 0',
    dag=dag,
)

transform = BashOperator(
    task_id='transform',
    bash_command='sleep 0',
    dag=dag,
)

load_stage = BashOperator(
    task_id='load_stage',
    bash_command='scripts/load_stage.sh',
    dag=dag,
)

model = PostgresOperator(
    task_id='model',
    postgres_conn_id='postgres_contratos',
    sql='sql/model.sql',
    dag=dag,
)

flatten = PostgresOperator(
    task_id='flatten',
    postgres_conn_id='postgres_contratos',
    sql='sql/flatten.sql',
    dag=dag,
)

create_db_schema >> [scrap_bopv, scrap_boe]
[scrap_bopv, scrap_boe] >> merge
merge >> transform
transform >> load_stage
load_stage >> model
model >> flatten
