# Stage 1: Build the application
FROM rust:latest AS builder

COPY . /app

WORKDIR /app

RUN cargo build --release

CMD ["./actix-web-1"]

