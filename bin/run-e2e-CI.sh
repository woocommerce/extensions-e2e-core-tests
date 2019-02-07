#!/usr/bin/env bash

if [[ ${RUN_E2E} != 1 ]]; then
        exit 0
fi

E2E_FOLDER=${E2E_FOLDER:-tests}

ADMIN_USERNAME=${ADMIN_USERNAME:-admin}
ADMIN_PASSWORD=${ADMIN_PASSWORD:-password}
CUSTOMER_USERNAME=${CUSTOMER_USERNAME:-customer}
CUSTOMER_PASSWORD=${CUSTOMER_PASSWORD:-password}


#!/bin/bash

case $1 in
  install)
    git clone --branch=e2e-suite git@github.com:woocommerce/extensions-e2e-core-tests.git $E2E_FOLDER
  ;;
  before)
    export PATH="$HOME/.composer/vendor/bin:$PATH"
    export NODE_CONFIG="{\"users\":{\"admin\":{\"username\":$ADMIN_USERNAME,\"password\":$ADMIN_PASSWORD},\"customer\":{\"username\":$CUSTOMER_USERNAME,\"password\":$CUSTOMER_PASSWORD}}}"
    $E2E_FOLDER/bin/install.sh woocommerce_test root '' localhost $WP_VERSION
    $E2E_FOLDER/bin/travis.sh before
  ;;
  run)
    cd $E2E_FOLDER/woocommerce
    . tests/bin/run-e2e-CI.sh
  ;;
esac
