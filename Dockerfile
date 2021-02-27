# ANDROID DOCKERFILE
FROM ubuntu:20.04

ENV ANDROID_COMPILE_SDK "29"
ENV ANDROID_BUILD_TOOLS "29.0.3"
ENV ANDROID_SDK_TOOLS "6858069_latest"
ENV ANDROID_HOME "/cmdline-tools"
ENV PATH "$PATH:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools"
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -q update
RUN apt-get install -qqy --no-install-recommends openjdk-8-jdk-headless
RUN apt-get install -qqy --no-install-recommends libc6-i386
RUN apt-get install -qqy --no-install-recommends lib32stdc++6
RUN apt-get install -qqy --no-install-recommends lib32gcc1
RUN apt-get install -qqy --no-install-recommends lib32ncurses6
RUN apt-get install -qqy --no-install-recommends lib32z1
RUN apt-get install -qqy --no-install-recommends curl
RUN apt-get install -qqy --no-install-recommends unzip
RUN apt-get install -qqy --no-install-recommends zip
RUN apt-get install -qqy --no-install-recommends openvpn

RUN curl -Lo android-sdk.zip https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_TOOLS}.zip
RUN unzip android-sdk.zip && rm -v android-sdk.zip

RUN echo y | ${ANDROID_HOME}/bin/sdkmanager --sdk_root=${ANDROID_HOME} "platforms;android-${ANDROID_COMPILE_SDK}"
RUN echo y | ${ANDROID_HOME}/bin/sdkmanager --sdk_root=${ANDROID_HOME} "build-tools;${ANDROID_BUILD_TOOLS}"
RUN echo y | ${ANDROID_HOME}/bin/sdkmanager --sdk_root=${ANDROID_HOME} --licenses