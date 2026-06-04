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

3. Construir la imagen de Docker:

```sh
docker build -t llama-determinista .
```

4. Ejecutar el contenedor:

```sh
docker run -it --rm llama-determinista "¿Cuántos planetas hay en el sistema solar?"
```

> Después de la ejecución, se queda el modo consola para introducir otro prompt.
> Para salir de la ejecución pulsar `Ctrl + C`.