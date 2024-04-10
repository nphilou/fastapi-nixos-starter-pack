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

1. Create the config `myproject.nix`

```nix
{ config, pkgs, ... }:

let
  unstable = import <unstable> {};
in
{
  # Add the service to systemd
  systemd.services.myproject =
  let
    projectDir = "/home/.../fastapi-nixos-starter-pack";
  in
  {
    enable = true;
    description = "My API";
    serviceConfig = {
      User = "...";
      WorkingDirectory = projectDir;
      Restart = "always";
      ExecStart = let
        python = unstable.pkgs.python311.withPackages (ps: with ps; [
          fastapi
          uvicorn
        ]);
      in
        "${python.interpreter} main.py";
    };
  };

  # SSL certificate
  security.acme = {
    acceptTerms = true;
    defaults.email = "youremailaddress";
  };

  # Reverse Proxy
  services.nginx = {
    enable = true;
    recommendedTlsSettings = true;
    virtualHosts = {
      "yourdomainname.com" = {
         locations."/".proxyPass = "http://localhost:8000";
         forceSSL = true;
         enableACME = true;
      };
    };
  };
}
```