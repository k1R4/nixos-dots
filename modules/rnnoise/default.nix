{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.rnnoise;
in {
  options.modules.rnnoise = {enable = mkEnableOption "rnnoise";};

  config = mkIf cfg.enable {
    services.pipewire = {
      extraLv2Packages = [pkgs.rnnoise-plugin];
      configPackages = [
        (pkgs.writeTextDir "share/pipewire/pipewire.conf.d/99-input-denoising.conf" ''
          context.modules = [
            {   name = libpipewire-module-filter-chain
                args = {
                    node.description =  "Noise Canceling source"
                    media.name =  "Noise Canceling source"
                    filter.graph = {
                        nodes = [
                            {
                                type = ladspa
                                name = rnnoise
                                plugin = "${pkgs.rnnoise-plugin}/lib/ladspa/librnnoise_ladspa.so"
                                label = noise_suppressor_mono
                                control = {
                                    "VAD Threshold (%)" = 60.0
                                    "VAD Grace Period (ms)" = 250
                                    "Retroactive VAD Grace (ms)" = 0
                                }
                            }
                        ]
                    }
                    capture.props = {
                        node.name =  "capture.rnnoise_source"
                        node.passive = true
                        audio.rate = 48000
                    }
                    playback.props = {
                        node.name =  "rnnoise_source"
                        media.class = Audio/Source
                        audio.rate = 48000
                    }
                }
            }
          ]
        '')
      ];
    };
  };
}
