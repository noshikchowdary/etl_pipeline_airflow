import subprocess
import time

# Simple helper to wait until PostgreSQL is ready on a host
def wait_for_postgres(host, retries=5, delay=5):
    for attempt in range(1, retries + 1):
        try:
            result = subprocess.run(
                ["pg_isready", "-h", host],
                check=True,
                capture_output=True,
                text=True
            )
            if "accepting connections" in result.stdout:
                print(f"[✓] PostgreSQL is up on {host}")
                return True
        except subprocess.CalledProcessError:
            print(f"[!] PostgreSQL not ready yet (Attempt {attempt}/{retries}), waiting {delay}s...")
            time.sleep(delay)
    print("[x] PostgreSQL never became ready. Exiting.")
    return False

# Wait for the source Postgres to be ready before starting ELT
if not wait_for_postgres("source_postgres"):
    exit(1)

print("[>] Starting ELT process...")

# Connection details — customize if you want
source = {
    'dbname': 'source_db',
    'user': 'postgres',
    'password': 'secret',
    'host': 'source_postgres'
}

destination = {
    'dbname': 'destination_db',
    'user': 'postgres',
    'password': 'secret',
    'host': 'destination_postgres'
}

# Dump data from source DB into SQL file
dump_cmd = [
    "pg_dump",
    "-h", source["host"],
    "-U", source["user"],
    "-d", source["dbname"],
    "-f", "data_dump.sql",
    "-w"  # no password prompt, use PGPASSWORD env
]

print(f"[>] Dumping data from source DB '{source['dbname']}'...")
subprocess.run(dump_cmd, env={"PGPASSWORD": source["password"]}, check=True)

# Load dumped data into destination DB
load_cmd = [
    "psql",
    "-h", destination["host"],
    "-U", destination["user"],
    "-d", destination["dbname"],
    "-a", "-f", "data_dump.sql"
]

print(f"[>] Loading data into destination DB '{destination['dbname']}'...")
subprocess.run(load_cmd, env={"PGPASSWORD": destination["password"]}, check=True)

print("[✓] ELT process completed successfully.")
