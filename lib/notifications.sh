#!/usr/bin/env bash

send_slack() {
    echo "Lol"
    # curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"$1\"}" "$SLACK_BOT_HOOK_URL"
}