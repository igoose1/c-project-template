FROM alpine:3.15
RUN apk add --no-cache gcc make musl-dev clang-extra-tools

COPY . /app/data-compression
WORKDIR /app/data-compression

RUN make isformatted
RUN make
