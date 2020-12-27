FROM alpine:latest

COPY . ./
ENTRYPOINT [".", "./init.sh", "test-user"]
