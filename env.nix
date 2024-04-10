with import <unstable> {
  config.allowUnfree = true;
};
python310.withPackages (
  ps: with ps; [
      numpy
      scikitlearn
      pandas
      jupyter
      django
      jinja2
      matplotlib
      pillow
      # onnx
      wheel

      alembic
      # jupyterlab
      pydantic
      fastapi

      tenacity
      pymysql
      python-jose
      passlib
      python-dotenv
      uvicorn
      (callPackage ./nixpkgs/emails.nix {})
      psycopg2
      celery
      sentry-sdk
      email-validator
      pydantic-settings
      python-multipart
  ]
)

# $ nix-build env.nix -o venv

# Last version (master)
# $ nix-build -I nixpkgs=https://github.com/NixOS/nixpkgs/archive/master.tar.gz env.nix -o env
