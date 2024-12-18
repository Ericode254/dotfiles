$env.config = {
    show_banner: false # true or false to enable or disable the welcome banner at startup
    edit_mode: "vi"
}

# start tmux on startup
~/.local/bin/tn.sh

# show some cool designs on startup
~/.local/bin/colorscript -r

# aliases
alias v = nvim
alias downloader = VideoDownloader.sh
alias ts = tn.sh
alias brain = brain.sh
alias moveNotes = moveObsidianNotes.sh
alias sortNotes = sortNotesByTags.sh
alias cd2 = cd ../..
alias cd3 = cd ../../..
alias cd4 = cd ../../../..
alias fzf = fzf --tmux=center
alias ll = ls -la
alias lt = eza --tree
alias pydownload = python ~/MyProjects/YoutubeDownloader/pyplayer.py

# my todos aliases
alias todoshow = python ~/MyProjects/ToDoCli/todocli.py show
alias todoadd = python ~/MyProjects/ToDoCli/todocli.py add 
alias tododelete = python ~/MyProjects/ToDoCli/todocli.py delete 
alias todocomplete = python ~/MyProjects/ToDoCli/todocli.py complete 
alias todoupdate = python ~/MyProjects/ToDoCli/todocli.py update 

# initialize zoxide
source ~/.zoxide.nu
alias cd = z
alias cdi = zi

# initialize my starship prompt
use ~/.cache/starship/init.nu

#~/.config/nushell/config.nu
source ~/.cache/carapace/init.nu

# color theme
source ~/nu_scripts/themes/nu-themes/ayu.nu

# setting git aliases
source ~/nu_scripts/aliases/git/git-aliases.nu
