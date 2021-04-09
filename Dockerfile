FROM rust:1.48

RUN cargo install mdbook --version 0.4.7

COPY . .

RUN mdbook build

CMD ["mdbook", "serve", "-p", "3000"]
