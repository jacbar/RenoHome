# RenoHome

Python API scaffolded with [uv](https://docs.astral.sh/uv/) and [FastAPI](https://fastapi.tiangolo.com/).

## Requirements

- Python 3.12+
- [uv](https://docs.astral.sh/uv/getting-started/installation/)

## Setup

```bash
uv sync
```

## Run the API

```bash
uv run renohome
```

The API starts at `http://localhost:8000`.

- Health check: `GET /health`
- Interactive docs: `http://localhost:8000/docs`
- OpenAPI schema: `http://localhost:8000/openapi.json`

## Project layout

```
src/renohome/
├── api/
│   ├── app.py          # FastAPI application factory
│   └── routes/         # API route modules
├── main.py             # Uvicorn entrypoint
└── __init__.py
```

Add new routers under `src/renohome/api/routes/` and register them in `create_app()`.
