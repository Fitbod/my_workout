FROM ruby:2.7.5
# as build



ENV BUILD_ENV production
ENV RAILS_ENV production
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true
ENV GEM_HOME="/usr/local/bundle"
ENV PATH $GEM_HOME/bin:$GEM_HOME/gems/bin:$PATH

WORKDIR /app

COPY ./scripts/dependencies.sh /scripts/dependencies.sh
RUN /scripts/dependencies.sh

COPY Gemfile Gemfile.lock /app/
COPY ./scripts/bundle.sh /scripts/bundle.sh
RUN /scripts/bundle.sh

# FROM ruby:2.7.5

#COPY --from=build /usr/local/bundle/ /usr/local/bundle/
#COPY --from=build /app/vendor/bundle/ /app/vendor/bundle/
#COPY --from=build /scripts/ /scripts/


#WORKDIR /app

COPY . /app


EXPOSE 3000
ENTRYPOINT /scripts/entrypoint.sh

CMD ["/bin/bash"]
