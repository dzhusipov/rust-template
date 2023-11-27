# FROM rust:latest as build

# WORKDIR /app

# COPY . .

# RUN cp /app/crt/*.crt /usr/local/share/ca-certificates/
# RUN update-ca-certificates
# RUN rustup target add x86_64-unknown-linux-musl
# RUN apt-get update && apt-get install -y musl-tools
# RUN cargo build --release --target x86_64-unknown-linux-musl

# FROM scratch
# # FROM alpine
# WORKDIR /app
# COPY --from=build /app/target/x86_64-unknown-linux-musl/release/zhus_sip /app/zhus_sip
# COPY --from=build /app/config /app/config
# COPY --from=build /app/.env_docker /app/.env

# EXPOSE 5060
# EXPOSE 8080
# CMD ["/app/zhus_sip"] 


### ARM Docker
FROM rust:latest as build

WORKDIR /app
COPY . .

RUN rustup target add aarch64-unknown-linux-musl 
RUN rustup toolchain install stable-aarch64-unknown-linux-musl
RUN apt-get update && apt-get install -y musl-tools
RUN cargo build --release --target aarch64-unknown-linux-musl

FROM scratch

WORKDIR /app

COPY --from=build /app/target/aarch64-unknown-linux-musl/release/app /app/app
COPY --from=build /app/config /app/config
COPY --from=build /app/.env_docker /app/.env

EXPOSE 5060
EXPOSE 8080

CMD ["/app/app"]
