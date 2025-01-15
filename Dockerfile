# Stage 1: Generate a recipe for the dependencies

#   1. Use the official Rust image from Docker Hub as the base image
FROM rust:latest AS planner 

#   2. Create a new directory to copy the source code into
WORKDIR /app

#   3. Install the cargo-chef tool
RUN cargo install cargo-chef

#   4. Copy the source code into the working directory
COPY . .

#   5. Generate a recipe for the dependencies
RUN cargo chef prepare --recipe-path recipe.json

# Stage 2: Build the dependencies
FROM rust:latest AS cacher

#   1. Create a new directory to copy the source code into
WORKDIR /app

#   2. Install the cargo-chef tool
RUN cargo install cargo-chef

#   3. Copy the recipe for the dependencies from the previous stage
COPY --from=planner /app/recipe.json recipe.json

#   4. Generate the dependencies
RUN cargo chef cook --release --recipe-path recipe.json

# Stage 3: Build the application

#   1. Use the official Rust image from Docker Hub as the base image
FROM rust:latest AS builder

#   2. Create a new directory to copy the source code into
COPY . /app

#   3. Set the working directory
WORKDIR /app

#   4. Copy the dependencies from the previous stage
COPY --from=cacher /app/target target
COPY --from=cacher /usr/local/cargo /usr/local/cargo

#   5. Build the application
RUN cargo build --release


# Stage 4: Run the application
FROM gcr.io/distroless/cc-debian12

#   1. Copy the built application from the previous stage
COPY --from=builder /app/target/release/actix-web-1 /app/actix-web-1

#   2. Set the working directory
WORKDIR /app

#   3. Run the application
CMD ["./actix-web-1"]

