with import <unstable> {};

python311.withPackages (
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

# $ nix-build env.nix -o venv

# Last version (master)
# $ nix-build -I nixpkgs=https://github.com/NixOS/nixpkgs/archive/master.tar.gz env.nix -o venv
