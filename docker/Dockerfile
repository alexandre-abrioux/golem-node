ARG UBUNTU_VERSION=20.04
ARG YA_CORE_VERSION=0.9.1
ARG YA_WASI_VERSION=0.2.2
ARG YA_VM_VERSION=0.2.10
ARG YA_RESOURCES_VERSION=0.1.9
ARG YA_DIR_BIN=/usr/bin/
ARG YA_DIR_PLUGINS=/lib/yagna/plugins/
ARG YA_DIR_RESOURCES=/usr/lib/yagna/installer/

FROM ubuntu:${UBUNTU_VERSION} as installer
ARG YA_CORE_VERSION
ARG YA_WASI_VERSION
ARG YA_VM_VERSION
ARG YA_RESOURCES_VERSION
WORKDIR /root/golem-setup

RUN apt-get update -q \
&& apt-get install -q -y --no-install-recommends \
    curl \
    ca-certificates \
    xz-utils

RUN mkdir bin \
&& mkdir downloads \
&& mkdir plugins \
&& mkdir resources \
&& curl --proto "=https" --silent --show-error \
    --location "https://github.com/golemfactory/yagna/releases/download/v${YA_CORE_VERSION}/golem-provider-linux-v${YA_CORE_VERSION}.tar.gz" \
    --output "downloads/golem-provider-linux.tar.gz" \
&& curl --proto "=https" --silent --show-error \
    --location "https://github.com/golemfactory/ya-runtime-wasi/releases/download/v${YA_WASI_VERSION}/ya-runtime-wasi-linux-v${YA_WASI_VERSION}.tar.gz" \
    --output "downloads/ya-runtime-wasi-linux.tar.gz" \
&& curl --proto "=https" --silent --show-error \
    --location "https://github.com/golemfactory/ya-runtime-vm/releases/download/v${YA_VM_VERSION}/ya-runtime-vm-linux-v${YA_VM_VERSION}.tar.gz" \
    --output "downloads/ya-runtime-vm-linux.tar.gz" \
&& curl --proto "=https" --silent --show-error \
    --location "https://github.com/golemfactory/ya-installer-resources/releases/download/v${YA_RESOURCES_VERSION}/resources.tar.gz" \
    --output "downloads/ya-resources.tar.gz"

RUN mkdir downloads/golem-provider-linux \
&& mkdir downloads/ya-runtime-wasi-linux \
&& mkdir downloads/ya-runtime-vm-linux \
&& mkdir downloads/ya-resources

RUN tar -zxvf downloads/golem-provider-linux.tar.gz -C downloads/golem-provider-linux \
&& tar -zxvf downloads/ya-runtime-wasi-linux.tar.gz -C downloads/ya-runtime-wasi-linux \
&& tar -zxvf downloads/ya-runtime-vm-linux.tar.gz -C downloads/ya-runtime-vm-linux \
&& tar -zxvf downloads/ya-resources.tar.gz -C downloads/ya-resources

RUN find downloads/golem-provider-linux/golem-provider-linux-v${YA_CORE_VERSION} -executable -type f -exec cp -t bin {} + \
&& cp -R downloads/golem-provider-linux/golem-provider-linux-v${YA_CORE_VERSION}/plugins/* plugins \
&& cp -R downloads/ya-runtime-wasi-linux/ya-runtime-wasi-linux-v${YA_WASI_VERSION}/* plugins \
&& cp -R downloads/ya-runtime-vm-linux/ya-runtime-vm-linux-v${YA_VM_VERSION}/* plugins \
&& cp -R downloads/ya-runtime-vm-linux/ya-runtime-vm-linux-v${YA_VM_VERSION}/* plugins

FROM ubuntu:${UBUNTU_VERSION}
ARG YA_DIR_BIN
ARG YA_DIR_PLUGINS
ARG YA_DIR_RESOURCES
RUN apt-get update -q \
&& apt-get install -q -y --no-install-recommends ca-certificates \
&& apt-get clean -y \
&& rm -rf /var/lib/apt/lists/*
COPY --from=installer /root/golem-setup/plugins/ ${YA_DIR_PLUGINS}
COPY --from=installer /root/golem-setup/bin/ ${YA_DIR_BIN}

CMD ["golemsp", "run"]
VOLUME ["/root/.local/share/ya-provider/", "/root/.local/share/yagna/"]
HEALTHCHECK \
    --interval=1m \
    --timeout=10s \
    CMD golemsp status || exit 1
