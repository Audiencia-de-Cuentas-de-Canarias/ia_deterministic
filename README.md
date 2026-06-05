# IA Determinista con Mistral 7B Instruct v0.3

Con este proyecto, vamos a ejecutar un modelo de lenguaje de manera determinista utilizando el modelo Mistral 7B Instruct v0.3 en formato GGUF. Para ello, utilizaremos la biblioteca `llama.cpp` y Docker para facilitar la ejecución.

## Requisitos
- Docker
- Python 3.10 o superior 

## Instrucciones

1. Crear un entorno de trabajo:

```sh
python -m venv ./.venv
source .venv/bin/activate
pip install -r requirements.txt
```

2. Descargar el modelo Mistral 7B Instruct v0.3 en formato GGUF:

```sh
mkdir models
hf download bartowski/Mistral-7B-Instruct-v0.3-GGUF Mistral-7B-Instruct-v0.3-Q4_K_M.gguf --local-dir ./models
```

3. Construir la imagen de Docker.

Versión CPU:

```sh
docker build -t llama-determinista-cpu --build-arg LLAMA_BACKEND=cpu .
```

Versión GPU:

```sh
docker build -t llama-determinista-gpu \
	--build-arg BASE_IMAGE=nvidia/cuda:12.4.1-devel-ubuntu22.04 \
	--build-arg LLAMA_BACKEND=gpu .
```

4. Ejecutar el contenedor.

CPU:

```sh
docker run -e LLAMA_BACKEND=cpu -it --rm llama-determinista-cpu "¿Cuántos planetas hay en el sistema solar?"
```

GPU:

```sh
docker run --gpus all -e LLAMA_BACKEND=gpu -it --rm llama-determinista-gpu "¿Cuántos planetas hay en el sistema solar?"
```

> Después de la ejecución, se queda el modo consola para introducir otro prompt.
> Para salir de la ejecución pulsar `Ctrl + C`.

## Uso con GPU

La versión GPU compila `llama.cpp` con soporte CUDA. Para que realmente use la GPU necesitas:

1. Tener instalado el driver de NVIDIA en el host.
2. Tener instalado y configurado `nvidia-container-toolkit`.
3. Lanzar el contenedor con `--gpus all`.

Si quieres ajustar cuántas capas del modelo se envían a la GPU, define `LLAMA_GPU_LAYERS`. Por ejemplo:

```sh
docker run --gpus all -e LLAMA_GPU_LAYERS=40 -it --rm llama-determinista-gpu "Hola"
```

Si pones `LLAMA_BACKEND=cpu` o `LLAMA_GPU_LAYERS=0`, la ejecución quedará en CPU.