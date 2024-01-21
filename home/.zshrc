#  ▄▄▄  ▄▄▄               ▄▄▄▄  
#  ███  ███             ██▀▀▀▀█   Muntazir_Go
#  ████████            ██         https://www.github.com/muntazirgo 
#  ██ ██ ██            ██  ▄▄▄▄ 
#  ██ ▀▀ ██            ██  ▀▀██ 
#  ██    ██             ██▄▄▄██ 
#  ▀▀    ▀▀               ▀▀▀▀  
#                               
#           ▀▀▀▀▀▀▀▀▀▀          
# My zsh config. Not much to see here; just some pretty standard stuff.

# zsh-vi-mode
ZVM_CURSOR_STYLE_ENABLED=true
ZVM_VI_SURROUND_BINDKEY=classic
ZVM_KEYTIMEOUT=0.2
ZVM_VI_ESCAPE_BINDKEY="jj"

# you-should-use
export YSU_MESSAGE_POSITION="after"
export YSU_MODE=ALL # BESTMATCH, ALL
# export YSU_MESSAGE_FORMAT="$(tput setaf 1)Hey! I found this %alias_type for %command: %alias$(tput sgr0)"
# export YSU_HARDCORE=1
# export YSU_IGNORED_ALIASES=("ls")

# zsh-history-substring-search
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'K' history-substring-search-down

# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-history-substring-search"
plug "zap-zsh/supercharge"
plug "zap-zsh/zap-prompt"
plug "zdharma/fast-syntax-highlighting"
plug "zap-zsh/completions"
plug "MichaelAquilina/zsh-you-should-use"
plug "zap-zsh/exa"
plug "jeffreytse/zsh-vi-mode"

# Load and initialise completion system
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# path
if [ ! -d "$HOME/.local/bin" ] ; then
  mkdir $HOME/.local/bin
  PATH="$HOME/.local/bin:$PATH"
else
  PATH="$HOME/.local/bin:$PATH"
fi
PATH="$HOME/go/bin/:$HOME/.local/bin:$PATH"

# exports
export TERM="xterm-256color" # Getting Proper Colors
# export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)" # Commands To Ignore In History
export EDITOR='nvim' # $EDITOR use neovim in terminal
export VISUAL="nvim" # $VISUAL use neovim in GUI mode
export LANG=en_US.UTF-8 # You may need to manually set your language environment
export MANPATH="/usr/local/man:$MANPATH"
export OPENAI_API_KEY="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"

### SET MANPAGER
### Uncomment only one of these!

### "less" as manpager
# export MANPAGER="less"

### "bat" as manpager
# export MANPAGER="sh -c 'col -bx | bat -l man -p'"

## "vim" as manpager
# export MANPAGER="vim +MANPAGER --not-a-term -"

## "neovim" as manpager
export MANPAGER='nvim +Man!'

### SET PAGER
# Uncomment only one of these!

### "bat" as pager
export PAGER="sh -c 'col -bx | bat -l man -p'"

### "less" as pager
# export PAGER=less

### "more" as pager
# export PAGER=more

### SET VI MODE ###
# Comment this line out to enable default emacs-like bindings
# bindkey -v

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

### CHANGE TITLE OF TERMINALS
case ${TERM} in
  xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|alacritty|st|konsole*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
        ;;
  screen*)
    PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
    ;;
esac

### Function extract for common file formats ###
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
 else
    for n in "$@"
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.cbr|*.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.cbz|*.epub|*.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *.cpio)      cpio -id < ./"$n"  ;;
            *.cba|*.ace)      unace x ./"$n"      ;;
            *)
                         echo "extract: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}

IFS=$SAVEIFS

### Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

### ZSH HOME
export ZSH=$HOME/.zsh

# history config
export HISTFILE=$HOME/.zsh_history

# How many commands zsh will load to memory.
export HISTSIZE=10000
# How many commands history will save on file.
export SAVEHIST=10000
# History won't save duplicates.
setopt HIST_IGNORE_ALL_DUPS
# History won't show duplicates on search.
setopt HIST_FIND_NO_DUPS

### ALIASES ###

# Changing "ls" to "eza"
alias ls='eza --icons' # my preferred listing
alias la='eza -a --color=always --group-directories-first'  # all files and dirs
alias lsa='eza -la --color=always --group-directories-first'  # all files and dirs
alias ll='eza -l --color=always --group-directories-first'  # long format
alias lt='eza -aT --color=always --group-directories-first' # tree listing
alias l.='eza -a | egrep "^\."'

# pacman and yay
alias pacsyu='sudo pacman -Syu'                  # update only standard pkgs
alias pacsyyu='sudo pacman -Syyu'                # Refresh pkglist & update standard pkgs
alias yaysua='yay -Sua --noconfirm'              # update only AUR pkgs (yay)
alias yaysyu='yay -Syu --noconfirm'              # update standard pkgs and AUR pkgs (yay)
alias parsua='paru -Sua --noconfirm'             # update only AUR pkgs (paru)
alias parsyu='paru -Syu --noconfirm'             # update standard pkgs and AUR pkgs (paru)
alias unlock='sudo rm /var/lib/pacman/db.lck'    # remove pacman lock
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)' # remove orphaned packages

# Custom aliases
alias color="colorscript exec print256"
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
alias icat="kitty +kitten icat"
alias reload="source ~/.zshrc"
alias weather="curl wttr.in"

# get fastest mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# adding flags
alias df='df -h'                          # human-readable sizes
alias free='free -mh'                      # show sizes in MB and human-readable sizes
alias ncmpcpp='ncmpcpp ncmpcpp_directory=$HOME/.config/ncmpcpp/'

# ps
alias psa="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"
alias psmem='ps auxf | sort -nr -k 4'
alias pscpu='ps auxf | sort -nr -k 3'

# git
alias addup='git add -u'
alias addall='git add .'
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit -m'
alias fetch='git fetch'
alias pull='git pull origin'
alias push='git push origin'
alias stat='git status'  # 'status' is protected name so using 'stat' instead
alias tag='git tag'
alias newtag='git tag -a'
alias repo='find . -name ".git" | sed "s/.git//g" | sed "s#^./##"'

# get error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# gpg encryption
# verify signature for isos
alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
# receive the key of a developer
alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"

# Play audio files in current dir by type
alias playwav='mpv *.wav'
alias playogg='mpv *.ogg'
alias playmp3='mpv *.mp3'

# Play video files in current dir by type
alias playavi='mpv *.avi'
alias playmov='mpv *.mov'
alias playmp4='mpv *.mp4'

# yt-dlp
alias yta-aac="yt-dlp --extract-audio --audio-format aac "
alias yta-best="yt-dlp --extract-audio --audio-format best "
alias yta-flac="yt-dlp --extract-audio --audio-format flac "
alias yta-m4a="yt-dlp --extract-audio --audio-format m4a "
alias yta-mp3="yt-dlp --extract-audio --audio-format mp3 "
alias yta-opus="yt-dlp --extract-audio --audio-format opus "
alias yta-vorbis="yt-dlp --extract-audio --audio-format vorbis "
alias yta-wav="yt-dlp --extract-audio --audio-format wav "
alias ytv-best="yt-dlp -f bestvideo+bestaudio "

# switch between shells
# I do not recommend switching default SHELL from bash.
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Now log out.'"
alias tofish="sudo chsh $USER -s /bin/fish && echo 'Now log out.'"

# the terminal rickroll
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'

# dotfiles
alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

### RANDOM COLOR SCRIPT ###
# Get this script from my GitLab: gitlab.com/dwt1/shell-color-scripts
# Or install it from the Arch User Repository: shell-color-scripts
# colorscript exec rails

### BASH INSULTER (works in zsh though) ###
if [ -f /etc/bash.command-not-found ]; then
    . /etc/bash.command-not-found
fi

# alias nv="NVIM_APPNAME=nvchad nvim"
# alias nvim-mine="NVIM_APPNAME=nvim_mine nvim"
# alias nv="NVIM_APPNAME=astronvim nvim"

function nvims() {
  items=("default" "nvchad" "nvim_mine")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}

ulimit -n 4096

# Github Token
# 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
# 
# termux-obsidian
# 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
