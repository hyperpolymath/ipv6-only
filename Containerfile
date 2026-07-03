# SPDX-License-Identifier: MPL-2.0
# Containerfile for ipv6-only tools
# Base: Wolfi (cgr.dev/chainguard/wolfi-base)
# RSR Compliant: Rust-only implementation

# Build stage for Rust binaries
FROM cgr.dev/chainguard/wolfi-base:latest AS builder

# Install Rust and build dependencies. On the Chainguard wolfi apk repo the
# `cargo` binary ships inside the `rust` package (there is no standalone
# `cargo` package — `apk add cargo` fails with "no such package"), so it is
# not listed separately here.
RUN apk add --no-cache \
    rust \
    build-base

WORKDIR /build

# Copy Rust project files
COPY Cargo.toml Cargo.lock ./
COPY crates/ ./crates/
COPY src/ ./src/

# Build release binaries
RUN cargo build --release

# Runtime stage - minimal distroless-like image
FROM cgr.dev/chainguard/wolfi-base:latest

LABEL maintainer="Jonathan D.A. Jewell <jonathan@hyperpolymath.org>"
LABEL description="IPv6-only networking tools and utilities"

# Install runtime network tools
RUN apk add --no-cache \
    iproute2 \
    iputils \
    bind-tools \
    tcpdump \
    curl \
    ca-certificates \
    bash

# Copy Rust binaries from builder
COPY --from=builder /build/target/release/ipv6 /usr/local/bin/

# Copy shell scripts
COPY src/scripts/*.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/*.sh

# Set working directory
WORKDIR /app

# Create directories for data
RUN mkdir -p /data /config

# Set environment variables
ENV PATH="/usr/local/bin:${PATH}"
ENV IPV6_TOOLS_CONFIG="/config/ipv6-tools.ncl"
ENV IPV6_TOOLS_DATA="/data"

# Default command
CMD ["/bin/bash"]

# Health check using Rust binary
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD ipv6 validate ::1 || exit 1

# Expose web interface (if serving)
EXPOSE 8080

# Volume for persistent data
VOLUME ["/data", "/config"]

# Labels for metadata (OCI standard)
LABEL version="0.1.0"
LABEL org.opencontainers.image.source="https://github.com/hyperpolymath/ipv6-only"
LABEL org.opencontainers.image.description="Comprehensive IPv6-only networking tools (Rust)"
LABEL org.opencontainers.image.licenses="MPL-2.0"
LABEL org.opencontainers.image.vendor="hyperpolymath"
