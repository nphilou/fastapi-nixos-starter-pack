with import <unstable> {};

(python311.withPackages (
    ps: with ps; [
      # FastAPI stuff
      fastapi
      uvicorn
      sqlalchemy
      email-validator
      python-jose
      passlib
      pydantic-settings
      psycopg2
      (callPackage ./nixpkgs/emails.nix {})
      python-multipart
      celery

      # DB Migrations
      alembic

      # Implicit stuff
      pydantic
      tenacity
      python-dotenv

      # sentry-sdk
    ]
  )
).env
