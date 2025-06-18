#!/usr/bin/env bash

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
export COLLECTIVE_SCRIPT_NAME="no-permissions.sh"

# Original script content below
# ============================================


echo "this should not run because it doesn't have execute permissions"
