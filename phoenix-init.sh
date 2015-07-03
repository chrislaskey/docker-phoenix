#!/bin/bash

if [ -z "$PHOENIX_VERSION" ]; then
  PHOENIX_VERSION="0.14.0"
fi

if [ ! -d app ]; then
  yes | mix local.hex
  yes | mix archive.install "https://github.com/phoenixframework/phoenix/releases/download/v${PHOENIX_VERSION}/phoenix_new-${PHOENIX_VERSION}.ez"
  yes | mix phoenix.new app .
fi

cd app && npm install
