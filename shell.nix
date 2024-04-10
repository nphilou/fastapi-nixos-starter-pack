with import <unstable> {};

(python311.withPackages (
    ps: with ps; [
      # Minimal libs to run FastAPI
      fastapi
      uvicorn

      # Extras libs that could be useful
      # sqlalchemy
      # email-validator
      # python-jose
      # passlib
      # pydantic-settings
      # psycopg2
      # (callPackage ./nixpkgs/emails.nix {})
      # python-multipart
      # celery
      # alembic
      # pydantic
      # tenacity
      # python-dotenv
    ]
  )
).env
