# gitlab-ci-android-env

Image for Android build on Gitlab CI/CD.
Aim to use Alpine to create image as small as possible, but ended up with Ubuntu.
In Alpine, all aapt won't work.

Specification:
* Base image **ubuntu:20.04**
* Android Platform **platforms;android-29**
* Build tool version **build-tools;29.0.3**
* SDK tool Version **6858069_latest** 
* Java **openjdk-8-jdk-headless**
* C Libraries **libc6-i386, lib32stdc++6, lib32gcc1, lib32ncurses6, lib32z1**
* Other Libraries **curl, zip, unzip**

Feel free to send me a suggestion or message.
Thanks
