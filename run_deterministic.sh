#!/bin/bash

PROMPT="${1:-¿Cuál es la capital de Francia?}"

/llama.cpp/build/bin/llama-cli \
  --model /app/models/Mistral-7B-Instruct-v0.3-Q4_K_M.gguf \
  --prompt "[INST] $PROMPT [/INST]" \
  --temp 0.0 \
  --seed 42 \
  --top-k 1 \
  --top-p 1.0 \
  --threads 4 \
  --n-predict 150 \
  --no-mmap \
  --log-disable \
  --no-display-prompt \
  -e 2>/dev/null | sed '/^$/d' | head -20