FROM ruby:2.6.1

RUN gem update bundler \
    && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install --no-install-recommends -y \
       nodejs \
       yarn \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
