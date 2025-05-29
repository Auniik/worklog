#!/bin/bash

AUTHOR_NAME=$(git config user.name)
TMP_LOG=$(mktemp)
HOLIDAY_FILE="holidays.txt"

# Gather commit logs from all git directories
for dir in */ ; do
    if [ -d "$dir/.git" ]; then
        cd "$dir" || continue
        REPO_NAME=$(basename "$dir")
        git log --since="1 month ago" --author="$AUTHOR_NAME" --no-merges --date=short --pretty=format:"%ad|$REPO_NAME|%s" >> "$TMP_LOG"
        cd ..
    fi
done

# Sort by date (oldest first), group, add day name and optional holiday
sort "$TMP_LOG" | awk -F"|" -v holidays="$HOLIDAY_FILE" '
function get_day_name(date_str,   cmd, day) {
    cmd = "date -jf %Y-%m-%d \"" date_str "\" +%A"
    cmd | getline day
    close(cmd)
    return day
}

function get_holiday(date_str,   hfile, line, d, desc) {
    if (holidays && (getline line < holidays) > 0) {
        while ((getline line < holidays) > 0) {
            split(line, parts, ": ")
            d = parts[1]
            desc = parts[2]
            if (d == date_str) {
                close(holidays)
                return desc
            }
        }
        close(holidays)
    }
    return ""
}

{
    date = $1;
    project = $2;
    msg = $3;
    key = date "|" msg;

    if (!seen[key]++) {
        if (date != last_date) {
            day = get_day_name(date)
            holiday = get_holiday(date)
            if (holiday != "")
                print "\n" date " (" day ", " holiday ")"
            else
                print "\n" date " (" day ")"
            last_date = date
        }
        print " - [" project "] " msg;
    }
}
'

rm "$TMP_LOG"