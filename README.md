# 🔄 Data Automation (ELT) Project

Hi, I’m Noshik — I built this end-to-end ELT pipeline to automate data workflows using PostgreSQL, Apache Airflow, dbt, and Docker. It simulates a real-world data engineering setup and is fully containerized for portability.

## 🚀 What This Project Does

### ELT Script  
A custom Python script extracts data from a source PostgreSQL database, transforms it, and loads it into a destination PostgreSQL instance.

### Apache Airflow DAG  
Airflow orchestrates the workflow by running two main tasks:

| Task Name       | Description                                         |
| --------------- | ------------------------------------------------- |
| `run_elt_script` | Executes the ELT script to move and transform data |
| `dbt_run`        | Runs dbt inside a Docker container to model and clean the data |

### dbt (Data Build Tool)  
The dbt project, located in `custom_postgres/`, contains:  
- Models that transform raw data  
- Configurations for sources, targets, and tests  

This turns raw, messy data into clean, analytics-ready tables 📊

### Docker & Docker Compose  
The entire setup is containerized for consistency and ease of deployment, including:  
- **PostgreSQL Containers:** One for source DB, one for destination DB  
- **Airflow Services:** Webserver (UI), scheduler, Postgres metadata DB, and init service  
- **Docker Compose:** `docker-compose.yml` spins up all containers and networks with one command:
```
docker-compose up --build
```
## 🛠 Technologies Used

- Python  
- PostgreSQL  
- Apache Airflow  
- dbt  
- Docker & Docker Compose
---------

## 📂 Folder Structure
```plaintext
├── elt/                       # ELT Python script  
├── custom_postgres/           # dbt project files  
├── dags/                      # Airflow DAGs  
├── docker-compose.yml         # Multi-container setup  
└── README.md                  # Project documentation (this file!)
```

📚 References

Chau, J. (n.d.). The all-in-one workspace for your notes, tasks, wikis, and databases. Notion.
https://transparent-trout-f2f.notion.site/FreeCodeCamp-Data-Engineering-Course-Resources-e9d2b97aed5b4d4a922257d953c4e759

 
