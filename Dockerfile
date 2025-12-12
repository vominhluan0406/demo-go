# Start from the official Golang image to build the binary.
FROM golang:alpine AS builder

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy go mod file
COPY go.mod ./

# Download all dependencies. Dependencies will be cached if the go.mod file is not changed
# (no dependencies in this simple example, but good practice)
RUN go mod download

# Copy the source from the current directory to the Working Directory inside the container
COPY . .

# Build the Go app
RUN go build -o demo-go .

# Start a new stage from scratch
FROM alpine:latest  

WORKDIR /root/

# Copy the Pre-built binary from the previous stage
COPY --from=builder /app/demo-go .

# Expose port 8080 to the outside world
EXPOSE 8080

# Command to run the executable
CMD ["./demo-go"]
