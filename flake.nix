{
  description = "qFioofa LazyGit config — Home Manager module";

  outputs = { self }: {
    homeManagerModules.default = { config, lib, pkgs, ... }:
      let
        pyEnv = pkgs.python3.withPackages (ps: [ ps.pyyaml ]);

        mergedConfig = pkgs.runCommand "lazygit-config.yml" {
          buildInputs = [ pyEnv ];
          src = ./src;
        } ''
          python3 -c "
          import sys, glob, os, yaml

          src = '$src'
          out = '$out'

          def merge(a, b):
              for k, v in b.items():
                  if isinstance(v, dict) and isinstance(a.get(k), dict):
                      merge(a[k], v)
                  else:
                      a[k] = v
              return a

          files = [os.path.join(src, 'config.yml')]
          files += sorted(
              f for f in glob.glob(os.path.join(src, 'themes', '*.yml'))
              if not f.endswith('palette.yml')
          )

          result = {}
          for f in files:
              with open(f) as fh:
                  merge(result, yaml.safe_load(fh) or {})

          with open(out, 'w') as fh:
              yaml.safe_dump(result, fh, sort_keys=False, allow_unicode=True)
          "
        '';
      in
      {
        home.packages = with pkgs; [
          lazygit
          delta
          difftastic
          bat
          gitflow
          gh
          wl-clipboard
          xdg-utils
        ];

        xdg.configFile."lazygit/config.yml".source = mergedConfig;
      };
  };
}
