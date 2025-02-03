# Use a minimal Alpine-based Go image
FROM golang:1.20-alpine

# Set the working directory inside the container
WORKDIR /app

# Install dependencies and build GoTTY
RUN apk add --no-cache git make gcc libc-dev \
    && git clone https://github.com/yudai/gotty.git /app/gotty \
    && cd /app/gotty \
    && make build

# Create a non-root user
RUN addgroup -S gottygroup && adduser -S gottyuser -G gottygroup

# Change ownership and set user
RUN chown -R gottyuser:gottygroup /app
USER gottyuser

# Expose port 8080
EXPOSE 8080

# Run GoTTY securely as non-root user
CMD ["/app/gotty/gotty", "-w", "-p", "8080", "--address", "0.0.0.0", "bash"]
