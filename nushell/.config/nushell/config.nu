$env.config = {
    show_banner: false # true or false to enable or disable the welcome banner at startup
    edit_mode: "vi"
    keybindings: [
      {
        name: change_dir_with_fzf
        modifier: control
        keycode: char_y
        mode: vi_normal
        event: {
          send: executehostcommand,
          cmd: "cd (ls | where type == dir | each { |row| $row.name} | str join (char nl) | fzf | decode utf-8 | str trim)"
      }
    }
  ]
}

# initialize zoxide
source ~/.zoxide.nu

# initialize my starship prompt
use ~/.cache/starship/init.nu

#~/.config/nushell/config.nu
source ~/.cache/carapace/init.nu

# color theme
source ~/nu_scripts/themes/nu-themes/catppuccin-mocha.nu

# setting git aliases
source ~/nu_scripts/aliases/git/git-aliases.nu

# my custom config
source ~/.config/nushell/custom-config.nu


