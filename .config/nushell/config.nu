# scripts to be executed during start up
~/.local/bin/tn.sh
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
alias ltree = eza --tree

# my todos aliases
alias todoshow = python ~/MyProjects/ToDoCli/todocli.py show
alias todoadd = python ~/MyProjects/ToDoCli/todocli.py add 
alias tododelete = python ~/MyProjects/ToDoCli/todocli.py delete 
alias todocomplete = python ~/MyProjects/ToDoCli/todocli.py complete 
alias todoupdate = python ~/MyProjects/ToDoCli/todocli.py update 

# initialize my starship prompt
use ~/.cache/starship/init.nu

#~/.config/nushell/config.nu
source ~/.cache/carapace/init.nu

# initialize zoxide
source ~/.zoxide.nu

# color theme
source ~/nu_scripts/themes/nu-themes/ayu.nu

# setting git aliases
source ~/nu_scripts/aliases/git/git-aliases.nu
