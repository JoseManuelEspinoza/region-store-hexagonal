# syntax = docker/dockerfile:1

# Base image
ARG RUBY_VERSION=3.2.3
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim AS base

WORKDIR /rails
ENV RAILS_ENV="development" \
    BUNDLE_PATH="/usr/local/bundle"

# Build stage
FROM base AS build

# Install dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libpq-dev libvips pkg-config

# Install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

# Copy application
COPY . .

# Precompile assets and adjust bin files
RUN bundle exec bootsnap precompile app/ lib/ && \
    chmod +x bin/* && \
    sed -i "s/\r$//g" bin/* && \
    sed -i 's/ruby\.exe$/ruby/' bin/* && \
    SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

# Final stage
FROM base

# Install runtime dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libvips postgresql-client && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Copy built artifacts
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

# Setup runtime environment
RUN useradd rails --create-home --shell /bin/bash && \
    mkdir -p db log storage tmp && \
    chown -R rails:rails db log storage tmp
USER rails:rails

# Entrypoint and default command
EXPOSE 3000
CMD ["bash", "-c", "rm -f tmp/pids/server.pid && bundle exec rails server -b '0.0.0.0' -p 3000"]
