# OpenHermes FastAPI

Dockerised API serving the Mistral-based `mistralai/Mistral-Nemo-Instruct-2407` model using `vLLM`.

## 🧪 Quickstart (Local)

```bash
docker build -t openhermes-fastapi .
docker run --gpus all -p 8000:8000 openhermes-fastapi
