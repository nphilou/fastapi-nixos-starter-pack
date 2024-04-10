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