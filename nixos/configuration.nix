# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

let
  unstable = import <unstable> { config.allowUnfree = true; };
in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./keybase.nix
    ];

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?

  nix = {
    binaryCaches = [
      https://pact.cachix.org
      https://nixcache.reflex-frp.org
      https://cache.nixos.org
    ];
    binaryCachePublicKeys = [
      "pact.cachix.org-1:cg1bsryGrHnQzqEp52NcHq4mBBL+R25XbR2Q/I/vQ8Y="
      "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };

  hardware = {
    opengl.driSupport32Bit = true;
    bluetooth.enable = true;
    pulseaudio = {
      enable = true;
      support32Bit = true;
    };
  };
  hardware.nvidia.modesetting.enable = true;
  # = {
  #     enable = true;
  #     nvidiaBusId = "PCI:8:0:0";
  #   };

  sound.enable = true;

  # re nvidia stuff (`modeset=0` in particular):
  # I'm trying to fix the freezes that sometimes happen.
  # Message "NVRM: GPU at 0000:08:00.0 has fallen off the bus."
  #
  # Fix via:
  # * https://bbs.archlinux.org/viewtopic.php?pid=1743442#p1743442
  # * and partially https://github.com/NixOS/nixpkgs/issues/29514#issuecomment-330130281

  # re `pcie_aspm=off`:
  # I see a lot of bus errors like
  # "AER: Corrected error received: id=0000 type=data link layer"
  # consistent with what's reported at this forum:
  # https://forum.level1techs.com/t/threadripper-pcie-bus-errors/118977/65

  boot = {
    # note currently failing to build due to https://www.mail-archive.com/debian-bugs-dist@lists.debian.org/msg1651523.html
    # kernelPackages = unstable.linuxPackages_4_20;

    kernelModules = [
      "kvm-amd"
      "coretemp"
      "amd_iommu_v2"
    ];
    extraModprobeConfig = "options modeset=0";
    kernelParams = [
      "amd_iommu=on"
      "iommu=soft"
      "pcie_aspm=off"
    ];

    # Use the systemd-boot EFI boot loader.
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  nixpkgs.config = {
    allowUnfree = true;
    pulseaudio = true;
  };
  # virtualisation.virtualbox.host.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  services = {
    locate.enable = true;

    # thinkfan.enable = true;
    acpid.enable = true;

    # Enable the OpenSSH daemon.
    openssh.enable = true;

    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
      layout = "us";
      xkbModel = "kinesis";
      xkbOptions = "caps:escape";

      # # Enable touchpad support.
      # libinput = {
      #   enable = true;
      #   # not sure if working: check after reboot
      #   buttonMapping = "1 2 3 5 4 6 7 8";
      # };
      # # not sure if working: check after reboot
      # multitouch.invertScroll = true;

      # TODO: figure out how to use
      # * github.com/adi1090x/slim_themes
      # * github.com/MarianArlt/nixos-sddm-theme
      displayManager = {
        slim = {
          enable = true;
          defaultUser = "joel";
        };
      };

      windowManager.bspwm.enable = true;
    };

    compton = {
      enable = true;
      fade = true;
      shadow = true;
      shadowOpacity = "0.25";
      shadowExclude = [ "polybar" ];
    };

    redshift = {
      enable = true;
      latitude = "33.9915";
      longitude = "-118.4656";
      temperature.day = 6500;
      temperature.night = 2700;
    };
  };

  users.extraUsers.joel = {
    name = "joel";
    description = "Joel Burget";
    group = "users";
    extraGroups = [ "wheel" "audio" ];
    isNormalUser = true;
    uid = 1000;
    createHome = true;
    home = "/home/joel";
    shell = "/run/current-system/sw/bin/fish";
  };

  security.sudo.wheelNeedsPassword = false;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; with pkgs.haskellPackages; [
    wget neovim gitFull
    fish rxvt_unicode tree firefox chromium feh unzip
    bspwm sxhkd
    z3 file emacs ranger
    exfat
    stow hub htop rofi
    s-tui
    ripgrep silver-searcher
    keybase kbfs
    unstable.stack
    cudatoolkit

    # haskell.compiler.ghc7103
    # haskell.compiler.ghc802
    haskell.compiler.ghc822
    unstable.haskell.compiler.ghc844
    unstable.haskell.compiler.ghc863

    ghcid cabal-install happy
    tint2 compton lxappearance obconf polybar
    materia-theme
    gtk-engine-murrine
    paper-icon-theme
    gnome3.adwaita-icon-theme
    dropbox
    # bluez5_28 # for hcitool (can remove)
    m4
    xsel xclip
    peco
    fd
  ];

  environment.variables = rec {
    XDG_DATA_DIRS = lib.mkForce "${pkgs.materia-theme}/share:$XDG_DATA_DIRS";
    GTK2_RC_FILES = "${pkgs.materia-theme}/share/themes/Materia-dark/gtk-2.0/gtkrc";
  };

  environment.etc."xdg/gtk-3.0/settings.ini" = {
    mode = "444";
    text = ''
      [Settings]
      gtk-theme-name=Materia-light-compact
      gtk-icon-theme-name=Paper
      gtk-font-name=Noto Sans 12
    '';
  };

  environment.etc."X11/xorg.conf.d/90-magictrackpad.conf" = {
    text = ''
      Section "InputClass"
        Identifier      "Touchpads"
        Driver          "mtrack"
        MatchProduct    "Trackpad"
        MatchDevicePath "/dev/input/event*"
        # options...
          Option "Sensitivity" "0.55"
          Option "FingerHigh" "10"
          Option "FingerLow" "10"
          Option "TapButton1" "1"
          Option "TapButton2" "3"
          Option "TapButton3" "2"
          Option "TapButton4" "0"
          Option "ButtonIntegrated" "true"
          Option "ClickTime" "25"
          Option "ScrollDistance" "75"
          Option "ScrollSmooth" "1"
          Option "TapDragEnable" "false"

      # natural scroll
          Option "ScrollDownButton" "4"
          Option "ScrollUpButton" "5"
          Option "ScrollLeftButton" "7"
          Option "ScrollRightButton" "6"

      # three finger drag:
          Option "SwipeDistance" "1"
          Option "SwipeLeftButton" "1"
          Option "SwipeRightButton" "1"
          Option "SwipeUpButton" "1"
          Option "SwipeDownButton" "1"
          Option "SwipeClickTime" "0"
          Option "SwipeSensitivity" "1000"
      EndSection
    '';
  };

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      anonymousPro
      corefonts
      dejavu_fonts
      # font-droid
      freefont_ttf
      google-fonts
      inconsolata
      liberation_ttf
      powerline-fonts
      terminus_font
      ttf_bitstream_vera
      ubuntu_font_family
      font-awesome-ttf
      siji
      material-icons
      input-fonts
    ];
  };

  systemd.user.services = {
    # udiskie = {
    #   enable = true;
    #   description = "udiskie to automount removable media";
    #   wantedBy = [ "default.target" ];
    #   path = with pkgs; [
    #     gnome3.defaultIconTheme
    #     gnome3.gnome_themes_standard
    #     pythonPackages.udiskie
    #   ];
    #   environment.XDG_DATA_DIRS="${pkgs.gnome3.defaultIconTheme}/share:${pkgs.gnome3.gnome_themes_standard}/share";
    #   serviceConfig = {
    #     Restart = "always";
    #     RestartSec = 2;
    #     ExecStart = "${pkgs.python27Packages.udiskie}/bin/udiskie -a -t -n -F ";
    #   };
    # };

    autocutsel = {
      enable = true;
      description = "AutoCutSel";
      wantedBy = [ "default.target" ];
      serviceConfig = {
        Type = "forking";
        Restart = "always";
        RestartSec = 2;
        ExecStartPre = "${pkgs.autocutsel}/bin/autocutsel -fork";
        ExecStart = "${pkgs.autocutsel}/bin/autocutsel -selection PRIMARY -fork";
      };
    };

    dunst = {
      enable = true;
      description = "";
      wantedBy = [ "default.target" ];
      serviceConfig = {
        Restart = "always";
        RestartSec = 2;
        ExecStart = "${pkgs.dunst}/bin/dunst";
      };
    };

    unclutter = {
      enable = true;
      description = "hide cursor after X seconds idle";
      wantedBy = [ "default.target" ];
      serviceConfig = {
        Restart = "always";
        RestartSec = 2;
        ExecStart = "${pkgs.unclutter}/bin/unclutter";
      };
    };

    urxvtd = {
      enable = true;
      description = "rxvt unicode daemon";
      wantedBy = [ "default.target" ];
      path = [ pkgs.rxvt_unicode ];
      serviceConfig = {
        Restart = "always";
        RestartSec = 2;
        ExecStart = "${pkgs.rxvt_unicode}/bin/urxvtd -q -o";
      };
    };
  };

}
