FROM alpine:3.15
RUN apk add --no-cache gcc make musl-dev clang-extra-tools

COPY . /app/project
WORKDIR /app/project

RUN make isformatted
RUN make
