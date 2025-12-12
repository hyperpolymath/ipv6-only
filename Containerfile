FROM python:3.11-slim

LABEL maintainer="IPv6-Only Project"
LABEL description="IPv6-only networking tools and utilities"

# Install system dependencies
RUN apt-get update && apk add --no-cache -y \
    iproute2 \
    iputils-ping \
    traceroute \
    dnsutils \
    tcpdump \
    net-tools \
    curl \
    wget \
    git \
    golang-go \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy Python package
COPY setup.py requirements.txt README.md CLAUDE.md ./
COPY src/ ./src/
COPY tests/ ./tests/

# Install Python package
RUN pip install --no-cache-dir -e ".[dev]"

# Build Go tools
WORKDIR /app/src/go
RUN go build -o /usr/local/bin/ipv6-ping ./cmd/ipv6-ping && \
    go build -o /usr/local/bin/ipv6-scan ./cmd/ipv6-scan

# Copy scripts and make executable
WORKDIR /app
RUN cp src/scripts/*.sh /usr/local/bin/ && \
    chmod +x /usr/local/bin/*.sh

# Enable IPv6 in container
RUN echo "net.ipv6.conf.all.disable_ipv6 = 0" >> /etc/sysctl.conf && \
    echo "net.ipv6.conf.default.disable_ipv6 = 0" >> /etc/sysctl.conf

# Create directories for data
RUN mkdir -p /data /config

# Set environment variables
ENV PYTHONUNBUFFERED=1
ENV PATH="/usr/local/bin:${PATH}"

# Default command
CMD ["/bin/bash"]

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD python -c "import ipv6tools; print('OK')" || exit 1

# Expose web interface (if serving)
EXPOSE 8080

# Volume for persistent data
VOLUME ["/data", "/config"]

# Labels for metadata
LABEL version="0.1.0"
LABEL org.opencontainers.image.source="https://github.com/Hyperpolymath/ipv6-only"
LABEL org.opencontainers.image.description="Comprehensive IPv6-only networking tools"
LABEL org.opencontainers.image.licenses="MIT"
