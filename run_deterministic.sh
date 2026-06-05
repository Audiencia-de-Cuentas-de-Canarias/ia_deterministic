#!/bin/bash

PROMPT="${1:-¿Cuál es la capital de Francia?}"
BACKEND="${LLAMA_BACKEND:-cpu}"
GPU_LAYERS="${LLAMA_GPU_LAYERS:-999}"

if [[ "$BACKEND" == "cpu" ]]; then
  GPU_LAYERS=0
fi

/llama.cpp/build/bin/llama-cli \
  --model /app/models/Mistral-7B-Instruct-v0.3-Q4_K_M.gguf \
  --prompt "[INST] $PROMPT [/INST]" \
  --temp 0.0 \
  --seed 42 \
  --top-k 1 \
  --top-p 1.0 \
  --n-gpu-layers "$GPU_LAYERS" \
  --threads 4 \
  --n-predict 150 \
  --no-mmap \
  --log-disable \
  --no-display-prompt \
  -e 2>/dev/null | sed '/^$/d' | head -20