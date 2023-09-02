FROM python:3.8
RUN useradd -m ec2-user
WORKDIR /home/ec2-user/bots
RUN apt-get -yq update && apt-get -yq install git cron systemd
COPY docker/gcp_key /home/ec2-user/.ssh/git
COPY bot_manager_manager/REQUIRE.txt ./bot_manager_manager/REQUIRE.txt
COPY liked-copier-bot/REQUIRE.txt ./liked-copier-bot/REQUIRE.txt
COPY location_bot/REQUIRE.txt ./location_bot/REQUIRE.txt
COPY qeng_news_bot/REQUIRE.txt ./qeng_news_bot/REQUIRE.txt
COPY tg_userbot/REQUIRE.txt ./tg_userbot/REQUIRE.txt
RUN python -m pip install -r bot_manager_manager/REQUIRE.txt -r liked-copier-bot/REQUIRE.txt -r location_bot/REQUIRE.txt -r qeng_news_bot/REQUIRE.txt -r tg_userbot/REQUIRE.txt

# Crontab stuff
COPY docker/crontab /etc/crontab
RUN crontab -u ec2-user /etc/crontab
RUN chmod u+s /usr/sbin/cron
RUN mkdir /home/ec2-user/log/

# Chrome and chromedriver stuff
RUN curl https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/116.0.5845.96/linux64/chrome-linux64.zip --output /home/ec2-user/bots/chrome.zip
RUN cd /home/ec2-user/bots/ && unzip chrome.zip
RUN curl https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/116.0.5845.96/linux64/chromedriver-linux64.zip --output /home/ec2-user/bots/chromedriver.zip
RUN cd /home/ec2-user/bots/ && unzip chromedriver.zip
RUN wget https://dl-ssl.google.com/linux/linux_signing_key.pub -O /tmp/google.pub
RUN gpg --no-default-keyring --keyring /etc/apt/keyrings/google-chrome.gpg --import /tmp/google.pub
RUN echo 'deb [arch=amd64 signed-by=/etc/apt/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main' | tee /etc/apt/sources.list.d/google-chrome.list
RUN apt-get -y update && apt-get install -y libnss3 google-chrome-stable
RUN rm /opt/google/chrome/chrome && mv /home/ec2-user/bots/chrome-linux64/chrome /home/ec2-user/bots/chrome-linux64/chrome-exec
COPY docker/chrome /home/ec2-user/bots/chrome-linux64/chrome
RUN chmod +x /home/ec2-user/bots/chrome-linux64/chrome

# Moving to custom user
COPY . /home/ec2-user/bots/
RUN chown -R ec2-user:ec2-user /home/ec2-user/
COPY docker/start.sh /home/ec2-user/start.sh
RUN chmod +x /home/ec2-user/start.sh
WORKDIR /home/ec2-user/bots/bot_manager_manager
EXPOSE 5070
USER ec2-user
ENV PATH="${PATH}:/home/ec2-user/bots/chromedriver-linux64:/home/ec2-user/bots/chrome-linux64"
CMD ["/home/ec2-user/start.sh"]

