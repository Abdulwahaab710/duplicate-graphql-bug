FROM ruby:2.5.3

RUN apt-get update -yqq \
  && apt-get install -yqq --no-install-recommends \
      postgresql-client \
      nodejs \
  && apt-get -q clean \
  && rm -rf /var/lib/apt/lists
ENV RAILS_ENV=production

WORKDIR /usr/src/app
COPY Gemfile* ./
COPY . .
RUN bundle install

CMD rake assets:precompile && bundle exec puma -C config/puma.rb
