#!/usr/bin/env bash

if [[ ${RUN_E2E} != 1 ]]; then
        exit 0
fi

E2E_FOLDER=${E2E_FOLDER:-tests}

cd $E2E_FOLDER/woocommerce
. tests/bin/run-e2e-CI.sh
