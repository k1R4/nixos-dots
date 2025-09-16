{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.python;
  isString = x: builtins.typeOf x == "string";
in {
  options.modules.python = {
    enable = lib.mkEnableOption "python";
    base = lib.mkOption {
      type = lib.types.package;
      default = pkgs.python313;
    };
    pythonPackages = lib.mkOption {
      type = lib.types.listOf lib.types.unspecified;
      default = [];
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.k1r4 = {
      home.packages = [
        (cfg.base.withPackages (
          ps:
            builtins.map (
              pkg:
                if isString pkg
                then ps.${pkg}
                else pkg
            )
            cfg.pythonPackages
        ))
      ];
    };
  };
}
