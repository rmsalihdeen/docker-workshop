# base Docker image that we will build on
FROM python:3.13.11-slim

# Copy from a specific image the uv folder and put it in bin
COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/

# Set working directory
WORKDIR /code

# Set environment variable to not need uv run in the entry point below
ENV PATH="/code/.venv/bin:$PATH"

# Copy the files needed for UV
COPY pyproject.toml .python-version uv.lock ./

# Copy the data needed to ingest
COPY green_tripdata_2025-11.parquet taxi_zone_lookup.csv ./

# Sync the UV environment as it was in codespace
RUN uv sync --locked

# copy the script to the container. 1st name is source file, 2nd is destination
COPY ingest_data.py .

# define what to do first when the container runs
# in this example, we will just run the script
ENTRYPOINT ["python", "ingest_data.py"]