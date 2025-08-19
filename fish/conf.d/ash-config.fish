## Source from conf.d before our fish config
source ~/.config/fish/conf.d/done.fish

## Set values
## Run fastfetch as welcome message
function fish_greeting
export NIX_PATH=nixpkgs=https://github.com/NixOS/nixpkgs/archive/74e2faf5965a12e8fa5cff799b1b19c6cd26b0e3.tar.gz
end

# Format man pages
set -x MANROFFOPT "-c"
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

# Set settings for https://github.com/franciscolourenco/done
set -U __done_min_cmd_duration 10000
set -U __done_notification_urgency_level low

## Environment setup
# Apply .profile: use this to put fish compatible .profile stuff in
if test -f ~/.fish_profile
  source ~/.fish_profile
end

# Append common directories for executable files to $PATH
fish_add_path ~/.local/bin ~/.cargo/bin ~/Applications/depot_tools

## Functions
# Functions needed for !! and !$ https://github.com/oh-my-fish/plugin-bang-bang
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

if [ "$fish_key_bindings" = fish_vi_key_bindings ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

# Fish command history
function history
    builtin history --show-time='%F %T '
end

function backup --argument filename
    cp $filename $filename.bak
end

# Copy DIR1 DIR2
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
        set from (echo $argv[1] | trim-right /)
        set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end

## Useful aliases
alias sys-update="sudo dnf update"
alias nix-update="nix flake update --flake ~/.config/home-manager && nix run home-manager/release-24.05 -- switch --flake ~/.config/home-manager"
alias nix-clean="nix-collect-garbage -d"
alias nix-config="nano ~/.config/home-manager/home.nix"
