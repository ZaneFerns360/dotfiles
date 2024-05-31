# env variables for better commands
# export FZF_DEFAULT_COMMAND='ag -hidden --ignore={.cache,.cargo,.local,.mozilla} -g ""' 
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude={.git/,.cache/,.cargo/,.local/,.mozilla/,proc/} --strip-cwd-prefix'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

checkError(){
  if [ $? -ne 0 ]; then
    echo "${CError}Error: $1 ${ColorOff}"
    return 1
  fi

}


# cli tools better alternatives
# alias find='fd' # replace find with the faster fd command that is written in rust
# alias grep='rg' # replace grep with the faster counter part rip grep written in rust
alias hg="sed 's/.*;//g' $HISTFILE | fzf | wl-copy"
alias fzfview='fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'
alias fzfv='fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'

# Neovim
alias nv='nvim $(fzfview)'
alias nvd='nvim'
alias vim='nvim'
alias vi='nvim'


#Pacman
alias pacf='pacman -Qi $(pacman -Qq | gum filter) | rg -v "^(Groups|Architecture|Licenses|Conflicts With|Replaces)" | gum pager' # Get all the relevant information about the package
# Unfortunately you need sudo for pacman ;-;
alias paci='sudo pacman -S $(pacman -Ssq | fzf --preview "pacman -Si {} | bat --color=always --style=numbers --line-range=:500")'
alias pacd='sudo pacman -Rns $(pacman -Qeq | gum filter)'
alias pacu='sudo pacman -Syyu'

alias yay='paru'
# Swayimg
alias img='swappy -f'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
# alias rm='rm -i' # way to annoying
#

# ls modification
alias ls='ls --group-directories-first --color'
alias la='ls  -a' # the upper group dir and color will get forwarded to these commands too
alias ll='ls  -l'
alias lal='ls -al'

# alias some="someFnc"
# someFnc() {
# echo "$CProcess Some Function $ColorOff" 2>&1 
# trap cleanup SIGINT
# echo "hi"
# }

#battery 
alias battery='echo -e "Battery Percentage: $(cat /sys/class/power_supply/BAT*/capacity)\nBattery Status: $(cat /sys/class/power_supply/BAT*/status)"'

#kill a program
function killapp(){
  kill $(ps -a | awk '{printf($1 "\t" $4 "\n")}' | rofi -dmenu | awk '{print $1}') 
}

# share files over the internet
alias share='curl -F"file=@$(fd . $HOME -H -E .local -E .cache -E .cargo -E .npm -E .ssh -E .mozilla -t f| rofi -dmenu -i)" -Fexpires=240 0x0.st | wl-copy'

# vscodium
alias code='codium'

# bun
alias bunx='bun x'

#connect an android device
alias connect-android='aft-mtp-mount ~/mnt && cd /mnt/Internal\ shared\ storage'
alias disconnect-android='cd ~ && umount ~/mnt'

# cpp
alias gpp=g++

# neofetch
alias neofetch=fastfetch

#font info
alias fc-info='fc-query $(fc-list | fzf | sed "s/:.*//") | rg "(family|style|fontformat|fullname|file):" | sort'
alias fc-view='view $(fc-list | fzf | sed "s/:.*//")' 
