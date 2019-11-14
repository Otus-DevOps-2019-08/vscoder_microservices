FROM ruby:2.2

# First, install all necessary packages (fat layer)
RUN apt-get update -qq && apt-get install --no-install-recommends -y \
    build-essential \
    && rm -r /var/lib/apt/lists/*

ENV POST_SERVICE_HOST post
ENV POST_SERVICE_PORT 5000
ENV COMMENT_SERVICE_HOST comment
ENV COMMENT_SERVICE_PORT 9292
ENV APP_HOME /app

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Application requiremets (sometimes changing layer)
COPY Gemfile* $APP_HOME/
RUN bundle install

# Application (frequently changing layer)
COPY . $APP_HOME

CMD ["puma"]
