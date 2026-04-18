# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Finalize Powerlevel10k instant prompt. Should stay at the bottom of ~/.zshrc.
(( ! ${+functions[p10k-instant-prompt-finalize]} )) || p10k-instant-prompt-finalize

# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
source /home/suromih/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#zsh plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-sudo/zsh-sudo.zsh 

# Manual aliases
alias ll='lsd -lh --group-dirs=first'
alias la='lsd -a --group-dirs=first'
alias l='lsd --group-dirs=first'
alias lla='lsd -lha --group-dirs=first'
alias ls='lsd --group-dirs=first'
alias cat='bat'

# Custom aliases to push the the dotfiles and more
alias dotpush="git add -A && git commit -m \"update $(date '+%Y-%m-%d %H:%M')\" && git push"
alias pkg-export="pacman -Qqe > ~/dotfiles/packages/pacman.txt && pacman -Qqem > ~/dotfiles/packages/aur.txt"

# Custom functions
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

function ctrl_c(){
  echo -e "${redColour}[!]${endColour} ${grayColour} exiting${endColour}"
  exit 1
}

trap ctrl_c SIGINT

function update_yp(){

  echo -e "${purpleColour}[+]${endColour} ${greenColour}Updating packages${endColour}"
  if [[ $(which yay >/dev/null | echo $?) -ne 1 ]]; then
    sudo pacman -Syu && yay -Syu
  else
    read -p "${redColour}[!]${endColour} ${grayColour}Do you want to install yay [y/n]${endColour}" answer
    if [[ "$answer" == [yY] || "$answer" == "" ]]; then
      sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
    else
      sudo pacman -Syu
    fi
  fi

  echo -e "${purpleColour}[+]${endColour} ${greenColour}copying packages${endColour}"
  sudo pacman -Q > pacman_packages.txt
  which yay &>/dev/null && yay -Q > yay_packages.txt 
  echo -e "${purpleColour}[+]${endColour} ${greenColour}Have a nice day!${endColour}"
}

function mkt(){
  if [[ -e "nmap" ]] || [[ -e "files" ]]; then
    echo -e "${redColour}\n\t[!]${endColour} ${grayColour}The files are maked${endColour}"
  else
    mkdir {nmap,files}
  fi
}

function set_target(){
  echo $1 > /home/$(whoami)/.config/waybar/scripts/target.txt
}

function clear_target(){
  echo '' > /home/$(whoami)/.config/waybar/scripts/target.txt
}

function py_file(){
  name="$1"
  /usr/bin/bash /home/$(whoami)/.config/zshrc_scripts/py_file.sh $name
}
