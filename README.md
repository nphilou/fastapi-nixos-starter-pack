# FastAPI NixOS Starter Pack

## Implementing the API

### 1. Install direnv

Add to your `/etc/nixos/confirguration.nix`

```nix
  environment.systemPackages = with pkgs; [
    direnv
  ];
```

### 2. Clone this repo

```shell
git clone git@github.com:nphilou/fastapi-nixos-starter-pack.git
```

### 3. Allow direnv

You'll probably get something like
```shell
direnv: error /home/.../fastapi-nixos-starter-pack/.envrc is blocked. Run `direnv allow` to approve its content 
```

So you just have to run:

```shell
direnv allow
```

### 4. Run the API

```shell
uvicorn main:app --reload
```

or using Python:

```python
import uvicorn

if __name__ == '__main__':
    uvicorn.run("main:app", port=8000, log_level="info", reload=True)
```

The reload param is optional. If everything is working correctly, you can go to the next step.

## Deploy the API on a NixOS system

1. Import `myproject.nix` into your system:

```nix
{ config, pkgs, ... }:

{
  imports =
    [
      /home/.../myproject.nix
    ];
}
```

and `nixos-rebuild switch`.