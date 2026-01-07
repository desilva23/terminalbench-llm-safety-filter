#!/bin/bash
set -e

TEXT=$(cat llm_output.txt)
TERMS=$(yq -r '.blocked_terms[]' blocked_terms.yaml)

BLOCKED_COUNT=0
SANITIZED="$TEXT"

for TERM in $TERMS; do
  MATCHES=$(echo "$SANITIZED" | grep -oi "$TERM" | wc -l || true)
  if [ "$MATCHES" -gt 0 ]; then
    BLOCKED_COUNT=$((BLOCKED_COUNT + MATCHES))
    SANITIZED=$(echo "$SANITIZED" | sed -E "s/$TERM/***/Ig")
  fi
done

echo "$SANITIZED" > sanitized_output.txt

if [ "$BLOCKED_COUNT" -gt 0 ]; then
  STATUS="unsafe"
else
  STATUS="safe"
fi

echo "$STATUS" > status.txt
echo "status=$STATUS;blocked_count=$BLOCKED_COUNT" >> audit.log
