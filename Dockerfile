FROM --platform=linux/arm64 ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y build-essential git curl libevent-dev zlib1g-dev \
    ca-certificates && \
    update-ca-certificates

WORKDIR /build

# Clone repo và sửa Makefile trước khi build
RUN git clone https://github.com/TelegramMessenger/MTProxy.git . && \
    sed -i 's/-mpclmul//g; s/-mfpmath=sse//g; s/-mssse3//g' Makefile && \
    make

CMD ["objs/bin/mtproto-proxy"]
