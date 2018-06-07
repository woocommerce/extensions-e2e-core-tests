#!/usr/bin/env bash

if [ $1 == 'before' ]; then
		phpenv config-rm xdebug.ini
		composer global require "phpunit/phpunit=6.*"
		composer install
fi
