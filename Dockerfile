FROM maven:3.6.2-jdk-8

ENV SENCHA_CMD_3_0_0 /root/bin/Sencha/Cmd/5.0.2.270
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

# Download and install Sencha
RUN curl -sL https://cdn.sencha.com/cmd/5.0.2.270/SenchaCmd-5.0.2.270-linux-x64.run.zip -o SenchaCmd-5.0.2.270-linux-x64.run.zip && \
    unzip SenchaCmd-5.0.2.270-linux-x64.run.zip && \
    chmod +x SenchaCmd-5.0.2.270-linux-x64.run && \
    rm -f SenchaCmd-5.0.2.270-linux-x64.run.zip && \
    ./SenchaCmd-5.0.2.270-linux-x64.run --mode unattended

# Download and unzip gradle
RUN curl -sL https://services.gradle.org/distributions/gradle-4.4-bin.zip -o gradle-4.4-bin.zip && \
    unzip gradle-4.4-bin.zip

# Download and install Android SDK
RUN mkdir -p /usr/local/android-sdk-linux && \
    wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip -O tools.zip && \
    unzip tools.zip -d /usr/local/android-sdk-linux && \
    rm tools.zip

# Set environment variable
ENV ANDROID_SDK_ROOT /usr/local/android-sdk-linux
ENV PATH ${ANDROID_SDK_ROOT}/tools:$ANDROID_SDK_ROOT/platform-tools:$PATH

RUN (/usr/bin/yes | $ANDROID_SDK_ROOT/tools/bin/sdkmanager "tools" "platform-tools") && \
    (/usr/bin/yes | $ANDROID_SDK_ROOT/tools/bin/sdkmanager "build-tools;27.0.3" "platforms;android-26")
