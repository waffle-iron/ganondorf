FROM ubuntu:latest

MAINTAINER Ben Falk <benjamin.falk@yahoo.com>

# Elixir requires UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# update and install some software requirements
RUN apt-get update && apt-get upgrade -y && apt-get install -y curl wget git make

# For some reason, installing Elixir tries to remove this file
# and if it doesn't exist, Elixir won't install. So, we create it.
# Thanks Daniel Berkompas for this tip.
# http://blog.danielberkompas.com
RUN touch /etc/init.d/couchdb

# download and install Erlang package
RUN wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb \
    && dpkg -i erlang-solutions_1.0_all.deb \
    && apt-get update

# install latest elixir and erlang package
RUN apt-get install -y elixir erlang \
    && rm erlang-solutions_1.0_all.deb

ENV PHOENIX_VERSION 1.1.4

# install the Phoenix Mix archive
RUN mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phoenix_new-$PHOENIX_VERSION.ez

# install Node.js (>= 5.0.0) and NPM in order to satisfy brunch.io dependencies
# See http://www.phoenixframework.org/docs/installation#section-node-js-5-0-0-
RUN curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash - && apt-get install -y nodejs

# Install hex and rebar, they are needed to compile a
# phoenix application
RUN mix local.hex --force
RUN mix hex.info
RUN mix local.rebar --force

RUN apt-get install postgresql-client -y
RUN apt-get install postgresql-9.3 -y \
    && /etc/init.d/postgresql start \
    && su postgres -c "echo alter user postgres with password \'postgres\' | psql" \
    && /etc/init.d/postgresql stop

WORKDIR /code
