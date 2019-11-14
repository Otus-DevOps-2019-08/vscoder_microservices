FROM ruby:2.2

# First, install all necessary packages (fat layer)
RUN apt-get update -qq && apt-get install --no-install-recommends -y \
    build-essential \
    && rm -r /var/lib/apt/lists/*

ENV COMMENT_DATABASE_HOST comment_db
ENV COMMENT_DATABASE comments
ENV APP_HOME /app

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Application requiremets (sometimes changing layer)
COPY Gemfile* $APP_HOME/
RUN bundle install

# Application (frequently changing layer)
COPY . $APP_HOME

CMD ["puma"]
