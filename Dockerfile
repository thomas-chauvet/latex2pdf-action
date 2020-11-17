FROM ubuntu:bionic

WORKDIR /var/local

# combine into one run command to reduce image size
RUN apt-get update && apt-get install -y perl wget libfontconfig1 && \
    wget -qO- "https://yihui.org/tinytex/install-bin-unix.sh" | sh  && \
    apt-get clean
ENV PATH="${PATH}:/root/bin"

WORKDIR /

COPY . /

ENTRYPOINT ["/entrypoint.sh"]
