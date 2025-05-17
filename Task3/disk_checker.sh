#!/bin/bash
source .env || { echo ".env не найден"; exit 1; }

USAGE=$(df -h "${DISK_PATH:-/}" | awk 'NR==2 {gsub(/%/,"",$5); print $5}')
THRESHOLD=${THRESHOLD:-85}

if (( USAGE >= THRESHOLD )); then
  {
    echo "From: $SMTP_USER"
    echo "To: $TO_EMAIL"
    echo "Subject: иск почти заполнен ($USAGE%)"
    echo
    echo "Оповещение: использование диска на ${DISK_PATH:-/} достигло ${USAGE}%."
  } | curl --url "smtp://${SMTP_SERVER}:${SMTP_PORT}" --ssl-reqd --mail-from "$SMTP_USER" --mail-rcpt "$TO_EMAIL" --upload-file - --user "$SMTP_USER:$SMTP_PASS"
fi
