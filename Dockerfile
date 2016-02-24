FROM ubuntu:15.10

# Install basics
RUN apt-get update 
RUN apt-get install -y git-core subversion build-essential gcc-multilib sudo \
                       libncurses5-dev zlib1g-dev gawk flex gettext wget unzip python
RUN apt-get clean
RUN useradd -m openwrt
RUN echo 'openwrt ALL=NOPASSWD: ALL' > /etc/sudoers.d/openwrt
USER openwrt
WORKDIR /home/openwrt
RUN git clone git://git.openwrt.org/14.07/openwrt.git
RUN openwrt/scripts/feeds update

WORKDIR /home/openwrt/openwrt
COPY vocore.config /tmp
RUN cp /tmp/vocore.config .config
RUN make defconfig
RUN make toolchain

