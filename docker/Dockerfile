FROM ubuntu:24.10 AS base
RUN apt-get update -q \
&& apt-get install -q -y --no-install-recommends \
    ca-certificates \
&& apt-get clean -y \
&& rm -rf /var/lib/apt/lists/*

FROM base AS downloader
RUN apt-get update -q \
&& apt-get install -q -y --no-install-recommends \
    curl \
    xz-utils \
&& apt-get clean -y \
&& rm -rf /var/lib/apt/lists/*

FROM downloader AS installer
ARG TARGETPLATFORM
ARG YA_CORE_VERSION=0.16.0
ARG YA_CORE_ARCH
ARG YA_WASI_VERSION=0.2.2
ARG YA_WASI_ARCH=linux
ARG YA_VM_VERSION=0.4.2
ARG YA_VM_ARCH=linux
ARG YA_RESOURCES_VERSION=0.1.19
WORKDIR /root/golem-setup
RUN YA_CORE_ARCH=${YA_CORE_ARCH:-$(if [ ${TARGETPLATFORM} = "linux/arm64" ]; then echo "linux_aarch64"; else echo "linux"; fi)} \
&& mkdir bin \
&& mkdir downloads \
&& mkdir plugins \
&& mkdir resources \
&& curl --proto "=https" --silent --show-error \
    --location "https://github.com/golemfactory/yagna/releases/download/v${YA_CORE_VERSION}/golem-provider-${YA_CORE_ARCH}-v${YA_CORE_VERSION}.tar.gz" \
    --output "downloads/golem-provider.tar.gz" \
&& curl --proto "=https" --silent --show-error \
    --location "https://github.com/golemfactory/ya-runtime-wasi/releases/download/v${YA_WASI_VERSION}/ya-runtime-wasi-${YA_WASI_ARCH}-v${YA_WASI_VERSION}.tar.gz" \
    --output "downloads/ya-runtime-wasi.tar.gz" \
&& curl --proto "=https" --silent --show-error \
    --location "https://github.com/golemfactory/ya-runtime-vm/releases/download/v${YA_VM_VERSION}/ya-runtime-vm-${YA_VM_ARCH}-v${YA_VM_VERSION}.tar.gz" \
    --output "downloads/ya-runtime-vm.tar.gz" \
&& curl --proto "=https" --silent --show-error \
    --location "https://github.com/golemfactory/ya-installer-resources/releases/download/v${YA_RESOURCES_VERSION}/resources.tar.gz" \
    --output "downloads/ya-resources.tar.gz" \
&& mkdir downloads/golem-provider \
&& mkdir downloads/ya-runtime-wasi \
&& mkdir downloads/ya-runtime-vm \
&& mkdir downloads/ya-resources \
&& tar -zxvf downloads/golem-provider.tar.gz -C downloads/golem-provider \
&& tar -zxvf downloads/ya-runtime-wasi.tar.gz -C downloads/ya-runtime-wasi \
&& tar -zxvf downloads/ya-runtime-vm.tar.gz -C downloads/ya-runtime-vm \
&& tar -zxvf downloads/ya-resources.tar.gz -C downloads/ya-resources \
&& find downloads/golem-provider/golem-provider-${YA_CORE_ARCH}-v${YA_CORE_VERSION} -executable -type f -exec cp -t bin {} + \
&& cp -R downloads/golem-provider/golem-provider-${YA_CORE_ARCH}-v${YA_CORE_VERSION}/plugins/* plugins \
&& cp -R downloads/ya-runtime-wasi/ya-runtime-wasi-${YA_WASI_ARCH}-v${YA_WASI_VERSION}/* plugins \
&& cp -R downloads/ya-runtime-vm/ya-runtime-vm-${YA_VM_ARCH}-v${YA_VM_VERSION}/* plugins \
&& cp -R downloads/ya-resources/* resources

FROM base
COPY run.sh /
COPY --from=installer /root/golem-setup/plugins/ /lib/yagna/plugins/
COPY --from=installer /root/golem-setup/bin/ /usr/bin/
COPY --from=installer /root/golem-setup/resources/ /usr/lib/yagna/installer/
CMD ["/run.sh"]
VOLUME ["/root/.local/share/ya-provider/", "/root/.local/share/yagna/"]
HEALTHCHECK \
    --interval=1m \
    --timeout=10s \
    CMD golemsp status || exit 1
