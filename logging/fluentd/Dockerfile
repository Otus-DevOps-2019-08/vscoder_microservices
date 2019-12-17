FROM fluent/fluentd:v1.8
USER root
RUN fluent-gem install fluent-plugin-elasticsearch --no-rdoc --no-ri --version 3.7.1
RUN fluent-gem install fluent-plugin-grok-parser --no-rdoc --no-ri --version 2.6.1
ADD fluent.conf /fluentd/etc
USER fluent
