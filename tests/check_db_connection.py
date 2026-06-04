import os
import psycopg2

# Load environment variables
PG_HOST = os.getenv("PG_HOST", "localhost")  # instead of "postgres"
PG_PORT = os.getenv("PG_PORT", "5432")
PG_DB = os.getenv("PG_DB", "formulavision")
PG_USER = os.getenv("PG_USER", "fv_user")
PG_PASS = os.getenv("PG_PASS", "fv_pass")


try:
    # Connect to Postgres
    conn = psycopg2.connect(
        host=PG_HOST,
        port=PG_PORT,
        dbname=PG_DB,
        user=PG_USER,
        password=PG_PASS
    )
    cursor = conn.cursor()
    print("✅ Connected to Postgres successfully!")

    # List all tables
    cursor.execute(
        """
        SELECT table_schema, table_name
        FROM information_schema.tables
        WHERE table_schema='public'
        ORDER BY table_name;
        """
    )
    tables = cursor.fetchall()
    print("Tables in DB:")
    for schema, table in tables:
        print(f"- {table}")

    cursor.close()
    conn.close()

except Exception as e:
    print("❌ Failed to connect to Postgres:", e)
