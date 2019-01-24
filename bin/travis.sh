#!/usr/bin/env bash

if [[ ${RUN_E2E} != 1 ]]; then
        exit 0
fi

if [ $1 == 'before' ]; then
		phpenv config-rm xdebug.ini
		composer global require "phpunit/phpunit=6.*"
		composer install
fi
