FROM rust:1.48

RUN cargo install mdbook --no-default-features --features output --vers "^0.4.7"

CMD ["mdbook", "build"]
