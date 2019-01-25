# extensions-e2e-core-tests
Shell scripts to run WooCommerce end to end tests in Travis for WooCommerce extensions

## Install

Copy `bin/run-e2e-CI.sh` into your tests suite bin folder:

```
wget https://raw.githubusercontent.com/woocommerce/extensions-e2e-core-tests/master/bin/run-e2e-CI.sh -P tests/bin/
```

Update your travis file:

```
addons:
  chrome: stable
  apt:
    packages:
      - nginx

sudo: false

matrix:
  fast_finish: true
  include:
  - php: 7.2
    env: WP_VERSION=latest WP_MULTISITE=0 RUN_PHPCS=1 RUN_E2E=1 E2E_FOLDER='core_e2e_tests'

install:
  - bash tests/bin/run-e2e-CI.sh install

before_script:
  - bash tests/bin/run-e2e-CI.sh before

script:
  - bash tests/bin/run-e2e-CI.sh run
```
