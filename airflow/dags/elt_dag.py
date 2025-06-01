# dags/elt_and_dbt.py

from datetime import datetime
from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.providers.docker.operators.docker import DockerOperator
from docker.types import Mount
import subprocess

# Default DAG arguments
default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
}


# Python function to run local ELT script
def run_elt_script():
    script_path = "/opt/airflow/elt/elt_script.py"  # Path inside container or volume
    result = subprocess.run(["python", script_path], capture_output=True, text=True)
    if result.returncode != 0:
        raise Exception(f"Script failed with error: {result.stderr}")
    else:
        print(result.stdout)

# Define DAG
with DAG(
    dag_id='elt_and_dbt',
    default_args=default_args,
    description='Run ELT pipeline followed by dbt transformations',
    schedule_interval=None,
    start_date=datetime(2024, 2, 25),
    catchup=False,
    tags=['elt', 'dbt'],
) as dag:

    # Task 1: Run ELT script (PythonOperator)
    run_elt = PythonOperator(
        task_id='run_elt_script',
        python_callable=run_elt_script
    )

    # Task 2: Run dbt inside Docker (DockerOperator)
    run_dbt = DockerOperator(
        task_id='dbt_run',
        image='ghcr.io/dbt-labs/dbt-postgres:1.4.7',
        command=[
            "dbt", "run",
            "--profiles-dir", "/root",
            "--project-dir", "/opt/dbt",
            "--full-refresh"
        ],
        docker_url="unix://var/run/docker.sock",
        network_mode="bridge",
        auto_remove=True,
        mounts=[
            Mount(
                source='/Users/noshik/Data-Engineering-main/custom_postgres',
                target='/opt/dbt',
                type='bind'
            ),
            Mount(
                source='/Users/noshik/.dbt',
                target='/root',
                type='bind'
            )
        ]
    )

    # Task sequence
    run_elt >> run_dbt
