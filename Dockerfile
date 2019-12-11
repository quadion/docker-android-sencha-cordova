FROM maven:3.6.2-jdk-8

ENV SENCHA_CMD_3_0_0 /root/bin/Sencha/Cmd/5.0.2.270
ENV ANDROID_SDK_ROOT /android-sdk
ENV PATH $PATH:$ANDROID_SDK_ROOT/tools
ENV PATH $PATH:$ANDROID_SDK_ROOT/platform-tools
ENV PATH $PATH:$ANDROID_SDK_ROOT/platforms
ENV PATH $PATH:$ANDROID_SDK_ROOT/build-tools
ENV PATH $PATH:$SENCHA_CMD_3_0_0
ENV PATH $PATH:/gradle-4.4/bin

RUN apt-get install curl -y && \
    curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh && \
    bash nodesource_setup.sh && \
    apt-get install build-essential -y && \
    apt-get install nodejs -y && \
    npm install -g cordova@7.0.1 && \
    apt-get install ruby-full -y && \
    gem install sass && \
    gem install compass && \
    npm install -g gulp-cli@2.2.0 && \
    npm install -g bower@1.8.8 --allow-root

COPY SenchaCmd-5.0.2.270-linux-x64.run .

RUN chmod +x SenchaCmd-5.0.2.270-linux-x64.run && \
    ./SenchaCmd-5.0.2.270-linux-x64.run --mode unattended

COPY android-sdk /android-sdk
COPY gradle-4.4 /gradle-4.4

RUN apt-get install zipalign -y