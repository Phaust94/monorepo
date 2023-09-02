docker build -t bot_monorepo  -t us-east1-docker.pkg.dev/bots-397520/bots/bot_monorepo:latest -f docker/Dockerfile .
docker run -it -v $(pwd)/qeng_news_bot/data:/home/ec2-user/bots/qeng_news_bot/data:rw -t bot_monorepo bash
docker push us-east1-docker.pkg.dev/bots-397520/bots/bot_monorepo:latest