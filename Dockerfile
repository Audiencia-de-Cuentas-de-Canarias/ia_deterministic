FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    build-essential cmake git python3-pip

# Versión exacta del código
RUN git clone https://github.com/ggerganov/llama.cpp
RUN cd llama.cpp && \
    git checkout b9503 && \
    cmake -B build -DLLAMA_CUDA=OFF && \
    cmake --build build -j4

COPY models/ /app/models/
COPY run_deterministic.sh /app/

ENTRYPOINT ["/app/run_deterministic.sh"]