#!/bin/bash

SOURCES=(
    "/opt/adstxt-sync-bash/ads-local.txt"
    "https://tag.md-nx.com/config/site/8aae9f0c-34ca-4b18-856c-d7bae02bc257/ads.txt"
)
ADSTXT="/opt/drupal/ads.txt"

LINES=()
for ix in ${!SOURCES[*]}; do
    SOURCE=${SOURCES[$ix]}
    if [[ $SOURCE =~ ^https?: ]]; then
        TMPFILE=$(mktemp -u /tmp/ads.txt.XXXXXXXXX)
        echo "WGET  $SOURCE => $TMPFILE"
        wget --quiet --no-cache --user-agent="$0" --no-clobber --output-document="$TMPFILE" "$SOURCE"
        #curl --silent --output "$TMPFILE" "$SOURCE"
        while IFS= read -r LINE || [[ "$LINE" ]]; do LINES+=("$LINE"); done < $TMPFILE
        rm -f "$TMPFILE"
    elif [ -f "$SOURCE" ] && [ -r "$SOURCE" ]; then
        echo "USE   $SOURCE"
        while IFS= read -r LINE || [[ "$LINE" ]]; do LINES+=("$LINE"); done < $SOURCE
    else
        echo "SKIP  $SOURCE"
    fi
done

echo "WRITE $ADSTXT"
printf '%s\n' "${LINES[@]}" > "$ADSTXT"
