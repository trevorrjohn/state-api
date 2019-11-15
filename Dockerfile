FROM ruby:2.6.3

WORKDIR /app
COPY Gemfile Gemfile.lock ./

RUN apt-get update -qq \
      && apt-get install -y \
      postgresql-client \
      libpq-dev \
      libxml2-dev \
      libxslt1-dev \
      && gem install bundler:2.0.1 \
      && bundle install --jobs=4

COPY . ./

EXPOSE 3000
ENTRYPOINT ["bundle", "exec"]
CMD ["rails", "server", "-b", "0.0.0.0"]
