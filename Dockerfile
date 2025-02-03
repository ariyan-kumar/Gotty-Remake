# Use a minimal Alpine-based Go image
FROM golang:1.20-alpine

# Set the working directory inside the container
WORKDIR /app

# Install dependencies and build GoTTY
RUN apk add --no-cache git make gcc libc-dev \
    && git clone https://github.com/yudai/gotty.git /app/gotty \
    && cd /app/gotty \
    && make build

# Create a non-root user with a UID in the range 10000-20000
RUN addgroup -S gottygroup && adduser -S -u 10014 gottyuser -G gottygroup

# Change ownership and switch to the new user
RUN chown -R gottyuser:gottygroup /app
USER 10014

# Expose port 8080
EXPOSE 8080

# Run GoTTY securely as a non-root user
CMD ["/app/gotty/gotty", "-w", "-p", "8080", "--address", "0.0.0.0", "bash"]
