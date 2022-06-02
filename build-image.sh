#!/bin/bash -eu

cd `dirname $0`

: ${UID:=$(id -u)}
: ${GID:=$(id -g)}
: ${USER_NAME:=$(whoami)}
: ${GROUP_NAME:=${USER_NAME}}
: ${PASSWORD:=${USER_NAME}}
ENV_FILE=".env"

while getopts u:g:n:p:h OPT
do
    case ${OPT} in
    u) UID=${OPTARG};;
    g) GID=${OPTARG};;
    n) USER_NAME=${OPTARG};;
    p) PASSWORD=${OPTARG}; echo "password changed";;
    h) echo "Usage: $(basename $0) [OPTIONS]"
           echo "Options:"
           echo " -u UID       set user id"
           echo " -g GID       set group id"
           echo " -n USER_NAME set user name"
           echo ' -p PASSWORD  set user password(default is ${USER_NAME})'
           exit 1
           ;;
    esac
done

SED_PATTERN="s/./*/g"

SPLIT_LINE=""
SPLIT_CHAR="-"

for x in {1..30}; do
    SPLIT_LINE="${SPLIT_LINE}${SPLIT_CHAR}"
done

echo ""
echo "Container Environment"
echo "${SPLIT_LINE}"
echo "    UID:          ${UID}"
echo "    GID:          ${GID}"
echo "    USER_NAME:    ${USER_NAME}"
echo "    GROUP_NAME:   ${GROUP_NAME}"
echo "    PASSWORD:     $(echo $PASSWORD | sed ${SED_PATTERN})"

echo -e "${SPLIT_LINE}\n"

echo -n "" > $ENV_FILE
echo "UID=${UID}" >> $ENV_FILE
echo "GID=${GID}" >> $ENV_FILE
echo "USER_NAME=${USER_NAME}" >> $ENV_FILE
echo "GROUP_NAME=${GROUP_NAME}" >> $ENV_FILE


CONTEXT="."
IMAGE="${USER_NAME}/markdown"
DOCKER_FILE="./Dockerfile"

docker image build \
    -t $IMAGE \
    -f $DOCKER_FILE \
    --build-arg UID=${UID} \
    --build-arg GID=${GID} \
    --build-arg USER_NAME=${USER_NAME} \
    --build-arg GROUP_NAME=${GROUP_NAME} \
    --build-arg PASSWORD=${PASSWORD} \
    $CONTEXT
