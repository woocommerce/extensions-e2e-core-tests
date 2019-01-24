#!/usr/bin/env bash

if [ $# -lt 3 ]; then
	echo "usage: $0 <db-name> <db-user> <db-pass> [db-host] [wp-version] [skip-database-creation]"
	exit 1
fi

if [[ ${RUN_E2E} != 1 ]]; then
	exit 0
fi

DB_NAME=$1
DB_USER=$2
DB_PASS=$3
DB_HOST=${4-localhost}
WP_VERSION=${5-latest}
SKIP_DB_CREATE=${6-false}

WP_TESTS_DIR=${WP_TESTS_DIR-/tmp/wordpress-tests-lib}
WP_CORE_DIR=${WP_CORE_DIR-/tmp/wordpress/}

CURRENTR_SCRIPT_FOLDER="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

E2E_FOLDER=${E2E_FOLDER:-tests}

#clone woocommerce
WOOCOMMERCE_LOCATION=$CURRENTR_SCRIPT_FOLDER/../woocommerce
if [ ! -d "$WOOCOMMERCE_LOCATION" ]; then
  mkdir -p $WOOCOMMERCE_LOCATION
  git clone --depth=50 --branch=master https://github.com/woocommerce/woocommerce.git $WOOCOMMERCE_LOCATION
fi

# Copy execution variables that identify this plugin
REPO_E2E=$TRAVIS_REPO_SLUG
BRANCH_E2E=$TRAVIS_BRANCH

# we need cd because some paths in install.sh are relative and assume this folder
export TRAVIS_REPO_SLUG="$TRAVIS_REPO_SLUG/$E2E_FOLDER/woocommerce"
export TRAVIS_PULL_REQUEST_BRANCH="master"
export TRAVIS_PULL_REQUEST_SLUG="woocommerce/woocommerce"

cd $WOOCOMMERCE_LOCATION
. tests/bin/install.sh "$@"

# E2E plugin install on top of the E2E wordpress core installation.
echo "Adding plugin to the E2E tests"
WP_CORE_DIR_E2E="$HOME/wordpress"
WP_E2E_PLUGINS_FOLDER="$WP_CORE_DIR_E2E/wp-content/plugins"

# clone plugin
cd "$WP_E2E_PLUGINS_FOLDER"
ls -s $TRAVIS_BUILD_DIR $WP_E2E_PLUGINS_FOLDER

WOOCOMMERCE_PREFIX="woocommerce/"

PLUGIN_NAME=${REPO_E2E#$WOOCOMMERCE_PREFIX}

cd "$WP_CORE_DIR_E2E"
php wp-cli.phar plugin activate $PLUGIN_NAME

