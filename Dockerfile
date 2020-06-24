FROM golang:1.14-alpine AS build

RUN apk add --no-cache git

WORKDIR /tmp/app

COPY . .

# Build the Go app
RUN go build -o ./out/app .

# Start fresh from a smaller image
FROM alpine:3.12

COPY --from=build /tmp/app/out/app /app/app

# This container exposes port 8080 to the outside world
EXPOSE 8080

CMD ["/app/app"]
