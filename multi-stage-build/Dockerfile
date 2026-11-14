
# STAGE 1: Build the application dependencies
FROM python:3.8-slim AS builder

WORKDIR /app

# Install tools required to compile mysqlclient
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    libmariadb-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Create an isolated Python environment
RUN python -m venv /opt/venv

# Install Python packages into that environment
RUN /opt/venv/bin/pip install --no-cache-dir flask mysqlclient


# STAGE 2: Run the application
FROM python:3.8-slim AS runtime

WORKDIR /app

# Install only the database library needed at runtime
RUN apt-get update && apt-get install -y --no-install-recommends \
    libmariadb3 \
    && rm -rf /var/lib/apt/lists/*

# Copy the installed Python environment from the builder
COPY --from=builder /opt/venv /opt/venv

# Make the copied Python environment available
ENV PATH="/opt/venv/bin:$PATH"

# Copy application code
COPY app.py .

EXPOSE 5002

CMD ["python", "app.py"]
