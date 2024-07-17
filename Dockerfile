# ANDROID DOCKERFILE
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive
ENV SDK_TOOLS_VERSION "11076708"
ENV ANDROID_SDK_ROOT "/sdk"
ENV PATH "$PATH:${ANDROID_SDK_ROOT}/tools:${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin:${ANDROID_SDK_ROOT}/platform-tools"
ENV ANDROID_COMPILE_SDK "33"
ENV ANDROID_BUILD_TOOLS "33.0.0"

RUN apt-get -qq update && \
    apt-get install -qqy --no-install-recommends \
    curl \
    openjdk-17-jdk-headless \
    # libc6-i386 \
    # lib32stdc++6 \
    # lib32gcc1 \
    # lib32ncurses6 \
    # lib32z1 \
    zip \
    unzip \
    openvpn \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -s https://dl.google.com/android/repository/commandlinetools-linux-${SDK_TOOLS_VERSION}_latest.zip > /tools.zip \
    && mkdir -p ${ANDROID_SDK_ROOT}/cmdline-tools \
    && unzip /tools.zip -d ${ANDROID_SDK_ROOT}/cmdline-tools \
    && mv ${ANDROID_SDK_ROOT}/cmdline-tools/cmdline-tools ${ANDROID_SDK_ROOT}/cmdline-tools/latest \
    && rm -v /tools.zip

RUN mkdir -p $ANDROID_SDK_ROOT/licenses/ && \
    echo "8933bad161af4178b1185d1a37fbf41ea5269c55\nd56f5187479451eabf01fb78af6dfcb131a6481e\n24333f8a63b6825ea9c5514f83c2829b004d1fee" > $ANDROID_SDK_ROOT/licenses/android-sdk-license && \
    echo "84831b9409646a918e30573bab4c9c91346d8abd\n504667f4c0de7af1a06de9f4b1727b84351f2910" > $ANDROID_SDK_ROOT/licenses/android-sdk-preview-license && \
    yes | sdkmanager --licenses

RUN mkdir -p /root/.android \
    && touch /root/.android/repositories.cfg \
    && sdkmanager --update

RUN sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}"
RUN sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}"


