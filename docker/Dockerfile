FROM python:3.8
RUN useradd -m ec2-user
WORKDIR /home/ec2-user/bots
RUN apt-get -yq update && apt-get install git
COPY docker/gcp_key /home/ec2-user/.ssh/git
COPY bot_manager_manager/REQUIRE.txt ./bot_manager_manager/REQUIRE.txt
COPY liked-copier-bot/REQUIRE.txt ./liked-copier-bot/REQUIRE.txt
COPY location_bot/REQUIRE.txt ./location_bot/REQUIRE.txt
COPY qeng_news_bot/REQUIRE.txt ./qeng_news_bot/REQUIRE.txt
COPY tg_userbot/REQUIRE.txt ./tg_userbot/REQUIRE.txt
RUN python -m pip install -r bot_manager_manager/REQUIRE.txt -r liked-copier-bot/REQUIRE.txt -r location_bot/REQUIRE.txt -r qeng_news_bot/REQUIRE.txt -r tg_userbot/REQUIRE.txt
COPY . /home/ec2-user/bots/
WORKDIR /home/ec2-user/bots/bot_manager_manager
RUN chown -R ec2-user:ec2-user /home/ec2-user/
EXPOSE 5070
USER ec2-user
CMD ["python3.8", "bot_manager.py"]
