#!/bin/sh

BOT_URL="https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendMessage"

PARSE_MODE="Markdown"

if [ "$TRAVIS_TEST_RESULT" -ne 0 ]; then
    build_status="Failed"
else
    build_status="Succeed"
fi

send_msg () {
    curl -s -X POST "${BOT_URL}" -d chat_id="$TELEGRAM_CHAT_ID" \
        -d text="$1" -d parse_mode=${PARSE_MODE} >/dev/null
}
send_msg "
### Travis CI *${build_status}!* **$(date +%Y%m%e%H%M%S)**
Operating system: *${TRAVIS_OS_NAME}*
Build on commit: *${1}*(${2})
[Build Log Here](${TRAVIS_JOB_WEB_URL})
"
