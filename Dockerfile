# ANDROID DOCKERFILE
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive
ENV SDK_TOOLS_VERSION "6858069"
ENV ANDROID_HOME "/sdk"
ENV PATH "$PATH:${ANDROID_HOME}/tools:${ANDROID_HOME}/cmdline-tools/latest/bin:${ANDROID_HOME}/platform-tools"
ENV ANDROID_COMPILE_SDK "29"
ENV ANDROID_BUILD_TOOLS "29.0.3"

RUN apt-get -qq update && \
    apt-get install -qqy --no-install-recommends \
    curl \
    html2text \
    openjdk-8-jdk-headless \
    libc6-i386 \
    lib32stdc++6 \
    lib32gcc1 \
    lib32ncurses6 \
    lib32z1 \
    zip \
    unzip \
    openvpn \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -s https://dl.google.com/android/repository/commandlinetools-linux-${SDK_TOOLS_VERSION}_latest.zip > /tools.zip \
    && mkdir -p ${ANDROID_HOME}/cmdline-tools \
    && unzip /tools.zip -d ${ANDROID_HOME}/cmdline-tools \
    && mv ${ANDROID_HOME}/cmdline-tools/cmdline-tools ${ANDROID_HOME}/cmdline-tools/latest \
    && rm -v /tools.zip

RUN sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}"
RUN sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}"
RUN echo yes | sdkmanager --licenses