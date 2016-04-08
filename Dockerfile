FROM benfalk/phoenix-elixir

ENV MIX_ENV prod
ENV PORT 80

ADD . /code
RUN mix deps.get
RUN npm install && /code/node_modules/brunch/bin/brunch build /code/
RUN bash -c "mix compile.protocols 2>&1"
RUN mix phoenix.digest
CMD elixir -pa /code/_build/prod/consolidated -S mix phoenix.server
