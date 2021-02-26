# ANDROID DOCKERFILE
FROM alpine:3.12.4

ENV ANDROID_COMPILE_SDK "29"
ENV ANDROID_BUILD_TOOLS "29.0.3"
ENV ANDROID_SDK_TOOLS "4333796"
ENV ANDROID_NDK_TOOLS "21.0.6113669"
ENV ANDROID_HOME "/android-sdk-linux"
ENV CMAKE "3.10.2.4988404"
ENV PATH "$PATH:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools"

RUN apk add libstdc++6 --update-cache --repository http://dl-cdn.alpinelinux.org/alpine/v3.9/community/
RUN apk add openjdk8 --update-cache --repository http://dl-cdn.alpinelinux.org/package/v3.3/community/
RUN apk add libc6-compat --update-cache --repository http://dl-cdn.alpinelinux.org/package/edge/
RUN apk add curl --update-cache --repository http://dl-cdn.alpinelinux.org/package/v3.13/main/
RUN apk add unzip --update-cache --repository http://dl-cdn.alpinelinux.org/package/v3.13/main/
RUN apk add --update ca-certificates tar zip

RUN curl -Lo android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip
RUN unzip -d android-sdk-linux android-sdk.zip && rm -v android-sdk.zip
RUN y | android-sdk-linux/tools/bin/sdkmanager --licenses
RUN y | android-sdk-linux/tools/bin/sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}"
RUN y | android-sdk-linux/tools/bin/sdkmanager "platform-tools"
RUN y | android-sdk-linux/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}"
# RUN y | android-sdk-linux/tools/bin/sdkmanager "ndk;${ANDROID_NDK_TOOLS}"
# RUN y | android-sdk-linux/tools/bin/sdkmanager "cmake;${CMAKE}"
# RUN export ANDROID_HOME=android-sdk-linux/
# RUN export PATH=$PATH:android-sdk-linux/platform-tools/