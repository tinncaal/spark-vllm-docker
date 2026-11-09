#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
recipes=(
    diffusion-gemma-nvfp4-thinking
    openai-gpt-oss-120b
    nemotron-3.5-super-vl-nvfp4
    qwen3.8-flash-next-nvfp4-solo
    qwen3.8-27b-nvfp4-dflash2
    qwen3-coder-next-fp8
)

printf 'Available recipes:\n'
for index in "${!recipes[@]}"; do
    printf '  %d) %s\n' "$((index + 1))" "${recipes[index]}"
done
printf '  ---\n'
printf '  0) Quit\n'

while true; do
    # Read a single character without pressing Enter
    if ! read -n1 -r -p "Select a recipe number (0 to quit): " selection; then
        exit 0
    fi
    echo  # Add newline after single character input

    if [[ "$selection" == "0" ]]; then
        echo "Quitting..."
        exit 0
    fi

    if [[ "$selection" =~ ^[1-6]$ ]]; then
        recipe="${recipes[selection - 1]}"
        exec "$SCRIPT_DIR/run-recipe.sh" "$recipe"
    fi
    echo "Invalid selection. Choose a number from 0 to ${#recipes[@]}."
done
