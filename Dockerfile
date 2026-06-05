ARG BASE_IMAGE=ubuntu:22.04
FROM ${BASE_IMAGE}

ARG LLAMA_BACKEND=cpu

RUN apt-get update && apt-get install -y \
    build-essential cmake git python3-pip

# Versión exacta del código
RUN git clone https://github.com/ggerganov/llama.cpp
RUN cd llama.cpp && \
    git checkout b9503 && \
    if [ "$LLAMA_BACKEND" = "gpu" ]; then \
        cmake -B build -DLLAMA_CUDA=ON; \
    else \
        cmake -B build -DLLAMA_CUDA=OFF; \
    fi && \
    cmake --build build -j4

ENV LLAMA_BACKEND=${LLAMA_BACKEND}

COPY models/ /app/models/
COPY run_deterministic.sh /app/

ENTRYPOINT ["/app/run_deterministic.sh"]