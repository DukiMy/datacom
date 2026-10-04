#!/usr/bin/env bash

set -euo pipefail

page="https://hkr.instructure.com/courses/9446/modules#module_66212"
lab="$HOME/Education/hkr-uni/datacom/labs/labs_1_to_3.odt"
shark="$HOME/Education/hkr-uni/datacom/labs/lab1-task1.pcap"

echo "Opening page: $page"
echo "Opening lab report: $lab"
echo "Preparing workspace: $shark"

firefox "$page" &
xdg-open "$lab" &
sudo -v
sudo xdg-open "$shark" &

