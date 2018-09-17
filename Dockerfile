FROM ruby:2.5.1

RUN gem install bundler -v 1.16.2

ENV APP_ROOT /app

WORKDIR $APP_ROOT

RUN apt-get update && \
    apt-get install -y mysql-client \
                       --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

COPY Gemfile $APP_ROOT
COPY Gemfile.lock $APP_ROOT

RUN \
  echo 'gem: --no-document' >> ~/.gemrc && \
  cp ~/.gemrc /etc/gemrc && \
  chmod uog+r /etc/gemrc && \
  bundle config --global build.nokogiri --use-system-libraries && \
  bundle config --global jobs 4 && \
  bundle install && \
  rm -rf ~/.gem
