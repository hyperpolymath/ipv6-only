
## Container Policy (RSR)

### Primary Stack
- **Runtime**: nerdctl (not docker)
- **Base Image**: wolfi (cgr.dev/chainguard/wolfi-base)
- **Distroless**: Use distroless variants where possible

### Fallback Stack
- **Runtime**: podman (if nerdctl unavailable)
- **Base Image**: alpine (if wolfi unavailable)

### DO NOT:
- Use `docker` command (use `nerdctl` or `podman`)
- Use Dockerfile (use Containerfile)
- Use debian/ubuntu base images (use wolfi/alpine)
