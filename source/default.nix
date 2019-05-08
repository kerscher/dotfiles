{
  packageOverrides = pkgs: rec {
    yghor-default = pkgs.buildEnv {
      name = "yghor-default";
      paths = [
        chromium
        exa
        firefox
        go
        gotools-unstable
        jq
        ripgrep
        stack
        tree
      ];
    };
  };
}
