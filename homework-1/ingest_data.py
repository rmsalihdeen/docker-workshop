import click
import pandas as pd
from sqlalchemy import create_engine


@click.command()
@click.option('--pg-user', default='root', help='PostgreSQL username')
@click.option('--pg-pass', default='root', help='PostgreSQL password')
@click.option('--pg-host', default='localhost', help='PostgreSQL host')
@click.option('--pg-port', type=int, default=5432, help='PostgreSQL port')
@click.option('--pg-db', default='ny_taxi', help='PostgreSQL database name')
@click.option('--trip-table-name', default='green_trips_data', help='Target table for trips')
@click.option('--zone-table-name', default='zones', help='Target table for zones')
def run(pg_user, pg_pass, pg_host, pg_port, pg_db, trip_table_name, zone_table_name):
    """Ingest NYC taxi data into PostgreSQL database."""
    trips_data = 'green_tripdata_2025-11.parquet'
    zones_data = 'taxi_zone_lookup.csv'

    engine = create_engine(f'postgresql://{pg_user}:{pg_pass}@{pg_host}:{pg_port}/{pg_db}')

    trips_df = pd.read_parquet(trips_data)
    
    trips_df.to_sql(name = trip_table_name, 
                    con = engine, 
                    if_exists = 'replace')
    
    zones_df = pd.read_csv(zones_data)

    zones_df.to_sql(name = zone_table_name,
                    con = engine,
                    if_exists = 'replace')


if __name__ == '__main__':
    run()