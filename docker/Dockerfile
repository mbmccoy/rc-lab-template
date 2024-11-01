FROM nvcr.io/nvidia/pytorch:24.05-py3

# Install Node.js and npm
RUN apt-get update && \
    apt-get install -y curl && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /workspace
WORKDIR /workspace
COPY requirements.txt /tmp/
RUN pip install --no-cache-dir -r /tmp/requirements.txt

# Copy the entrypoint script
COPY docker/entrypoint.sh /usr/local/bin/

ENTRYPOINT [ "entrypoint.sh" ]
