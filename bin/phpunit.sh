#!/usr/bin/env bash
E2E_FOLDER=${E2E_FOLDER:-tests}
phpunit -c '$E2E_FOLDER/woocommerce/phpunit.xml --bootstrap tests/bootstrap.php'
