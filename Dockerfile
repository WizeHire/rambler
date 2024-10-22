FROM golang:1.23 AS builder
COPY . /go/src/github.com/wizehire/rambler
WORKDIR /go/src/github.com/wizehire/rambler
RUN go get ./... \
  && go build -ldflags="-s -linkmode external -extldflags -static -w"

FROM scratch
COPY --from=builder /go/src/github.com/wizehire/rambler/rambler /
CMD ["/rambler", "apply", "-a"]
