# ANDROID DOCKERFILE
FROM alpine:3.12.4

ENV ANDROID_COMPILE_SDK "29"
ENV ANDROID_BUILD_TOOLS "29.0.3"
ENV ANDROID_SDK_TOOLS "6858069_latest"
ENV ANDROID_NDK_TOOLS "21.0.6113669"
ENV ANDROID_HOME "/android-sdk-linux/cmdline-tools"
ENV CMAKE "3.10.2.4988404"
ENV PATH "$PATH:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools"

RUN apk update
RUN apk add libstdc++6 --repository http://dl-cdn.alpinelinux.org/alpine/v3.9/community/
RUN apk add openjdk8 --repository http://dl-cdn.alpinelinux.org/package/v3.3/community/
RUN apk add libc6-compat --repository http://dl-cdn.alpinelinux.org/package/edge/
RUN apk add curl --repository http://dl-cdn.alpinelinux.org/package/v3.13/main/
RUN apk add unzip --repository http://dl-cdn.alpinelinux.org/package/v3.13/main/
RUN apk add --update ca-certificates tar zip

RUN curl -Lo android-sdk.zip https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_TOOLS}.zip
RUN unzip -d android-sdk-linux android-sdk.zip && rm -v android-sdk.zip

RUN mkdir -p ${ANDROID_HOME}/licenses/
RUN echo "8933bad161af4178b1185d1a37fbf41ea5269c55\nd56f5187479451eabf01fb78af6dfcb131a6481e" > $ANDROID_HOME/licenses/android-sdk-license
RUN echo "84831b9409646a918e30573bab4c9c91346d8abd" > $ANDROID_HOME/licenses/android-sdk-preview-license

RUN y | ${ANDROID_HOME}/bin/sdkmanager --sdk_root=${ANDROID_HOME} "platforms;android-${ANDROID_COMPILE_SDK}"
RUN y | ${ANDROID_HOME}/bin/sdkmanager --sdk_root=${ANDROID_HOME} "platform-tools"
RUN y | ${ANDROID_HOME}/bin/sdkmanager --sdk_root=${ANDROID_HOME} "build-tools;${ANDROID_BUILD_TOOLS}"

RUN set +o pipefail
RUN y | ${ANDROID_HOME}/bin/sdkmanager --sdk_root=${ANDROID_HOME} --licenses
RUN set -o pipefail

# RUN y | android-sdk-linux/tools/bin/sdkmanager "ndk;${ANDROID_NDK_TOOLS}"
# RUN y | android-sdk-linux/tools/bin/sdkmanager "cmake;${CMAKE}"
# RUN export ANDROID_HOME=android-sdk-linux/
# RUN export PATH=$PATH:android-sdk-linux/platform-tools/