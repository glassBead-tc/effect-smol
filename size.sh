#!/bin/bash

# Collective Intelligence Telemetry Integration
# Auto-generated on 2025-06-18 01:24:03 UTC

# Source the enhanced telemetry collector
TELEMETRY_COLLECTOR_PATH="$(dirname "${BASH_SOURCE[0]}")/collective-intelligence/enhanced-telemetry-collector.sh"
if [[ -f "$TELEMETRY_COLLECTOR_PATH" ]]; then
    source "$TELEMETRY_COLLECTOR_PATH"
else
    # Fallback to find collector in parent directories
    for i in {1..5}; do
        TELEMETRY_COLLECTOR_PATH="$(dirname "${BASH_SOURCE[0]}")$(printf '/..'%.0s {1..$i})/collective-intelligence/enhanced-telemetry-collector.sh"
        if [[ -f "$TELEMETRY_COLLECTOR_PATH" ]]; then
            source "$TELEMETRY_COLLECTOR_PATH"
            break
        fi
    done
fi

# Set script name for telemetry
export COLLECTIVE_SCRIPT_NAME="size.sh"

# Original script content below
# ============================================

function compute_bundle_size() {
  local filename="${1}"
  pnpm rollup -c rollup.config.js "${filename}" | gzip | wc -c
}
output="| File Name | Current Size | Previous Size | Difference |"
output+="\n|:----------|:------------:|:-------------:|:----------:|"
for filename in bundle/*.ts; do
  current=$(compute_bundle_size "${filename}")
  previous=$([[ -f "head/bundle/${filename}" ]] && compute_bundle_size "head/bundle/${filename}" || echo "0")
  line=$(awk -v filename=${filename} -v current="${current}" -v previous="${previous}" '
    BEGIN {
      if (previous == 0) previous = current
      diff = current - previous
      diff_pct = (diff / previous) * 100
      current_kb = sprintf("%\047.2f", current / 1000)
      previous_kb = sprintf("%\047.2f", previous / 1000)
      diff_kb = sprintf("%\047.2f", diff / 1000)
      printf "| `%s` | %s KB | %s KB | %s%s KB (%s%.2f%%) |\n",
        filename,
        current_kb,
        previous_kb,
        (diff > 0 ? "+" : ""), diff_kb,
        (diff_pct > 0 ? "+" : ""), diff_pct
  }')
  output+="\n${line}"
done
echo -e $output
