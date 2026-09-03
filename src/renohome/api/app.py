from fastapi import FastAPI

from renohome.api.routes import health


def create_app() -> FastAPI:
    app = FastAPI(
        title="RenoHome API",
        version="0.1.0",
        description="RenoHome backend API",
    )

    app.include_router(health.router)

    return app
