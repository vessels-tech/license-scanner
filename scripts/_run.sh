#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROOT_DIR=${DIR}/..
LIB_DIR=${ROOT_DIR}/lib

# Allow users to override variables with an env variable
env | grep "pathToRepo" > /tmp/ls_env_override

source .env
eval $(${LIB_DIR}/toml-to-env/bin/toml-to-env.js ${ROOT_DIR}/config.toml)

eval `cat /tmp/ls_env_override`
rm -rf ls_env_override


echo "Path to repo is: ${pathToRepo}"

case ${mode} in
  ci)
    ${DIR}/_run_ci.sh
    ;;
  standalone)
    ${DIR}/_run_standalone.sh
    ;;
  *)
    echo "unsupported mode: ${mode}"
    echo "check your config.toml and try again."
    ;;
esac