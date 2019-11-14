FROM python:3.6.0-alpine

ENV POST_DATABASE_HOST post_db
ENV POST_DATABASE posts
ENV APP_HOME /app

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Install requiremets (fat layer)
COPY requirements.txt $APP_HOME
RUN pip install -r $APP_HOME/requirements.txt

# Application (frequently changing layer)
COPY . $APP_HOME

CMD ["python3", "post_app.py"]
