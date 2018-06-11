#!/usr/bin/env bash

E2E_FOLDER=${E2E_FOLDER:-tests}

cd $E2E_FOLDER/woocommerce
. tests/bin/run-e2e-CI.sh
