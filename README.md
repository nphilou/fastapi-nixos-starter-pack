# FastAPI NixOS Starter Pack

This tutorial shows how to deploy an API on the Web using FastAPI on a NixOS system.

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

### 4. Create a virtual env (could be useful if you are using Pycharm)

```shell
nix-build env.nix -o venv
```

Then tell PyCharm to use this venv

### 5. Run the API

```shell
uvicorn main:app --reload
```

or using Python:

```shell
python main.py
```

The reload param is optional. If everything is working correctly, you can go to the next step.

## Deploy the API on a NixOS system

1. Use a DNS Service (like https://dns.he.net/) to link the domain name to your server

yourdomainname.com -> your_ip_address (A record)

2. Create some port forwarding on your router

your_ip_address -> your_local_ip_address (on ports 80 and 443 for example)

3. Import `myproject.nix` into your system:

This file contains the backend service, the reverse proxy and the SSL certification system

```nix
{ config, pkgs, ... }:

{
  imports =
    [
      /home/.../myproject.nix
    ];
}
```

and `sudo nixos-rebuild switch`.