FROM rust:1.48

RUN cargo install mdbook --no-default-features --features output --vers "^0.4.7"

COPY . .

RUN mdbook build

CMD ["mdbook", "serve", "-p", "3000"]
