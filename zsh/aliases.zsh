alias ls="eza --all --icons --no-permissions --git --header --no-user --classify --group-directories-first"
alias ll="ls -lh"
alias lt='ls --tree'
alias lart='ll --sort=mod'
alias md='mkdir -p'
alias rd='rmdir'
alias tree='eza -T --level=5'
alias cl='clear'

alias cat='bat'
alias baty='bat -l yaml'

# copy the last zsh command to clipboard
alias clc='echo !! | pbcopy'

# needed for ranger to run in tmux
alias ranger='TERM=xterm-256color ranger'

#vim
alias vi='nvim'
alias vim='nvim'
alias nvim='nvim'
alias n='nvim'
alias nn='nvim --cmd "let g:auto_session_enabled = v:false"'
alias nm='nvim -u ~/.config/nvim/mini.vim'
alias no='nvim -u NONE' # no config
alias nowr="nvim -u NONE -c 'set nowrap'" # no config, no wrap
alias np='nvim --noplugin' # no plugins
alias nv='nvim -u ~/.config/nvim/init-nvim-lsp.vim'
alias ndebug='nvim -V9myVim.log' # debug authcommands and move
alias nvim-startuptime='rm /tmp/vim.log; nvim "+let g:auto_session_enabled = v:false" --startuptime /tmp/vim.log -c "quit" && cat /tmp/vim.log'
alias :e="nvim"

# edit zsh history
alias zedit='fc -W; nvim "$HISTFILE"; fc -R'

alias wl='watchman watch-list'
alias wda='watchman watch-del-all'

# tmux
alias tmn='tmux new -s'
alias tma='tmux attach -t'
alias tms='tmux switch-client -t'
alias tmls='tmux ls'
alias tag='ta ~/code/brandfolder'
alias tkill="for s in \$(tmux list-sessions | awk '{print \$1}' | rg ':' -r '' | fzf); do tmux kill-session -t \$s; done;"
# alias tkill=tmux display-popup -E "for s in \$(tmux list-sessions | awk '{print \$1}' | rg ':' -r '' | fzf); do tmux kill-session -t \$s; done;"

# rails
alias be="bundle exec"
alias rs='bundle exec rails s'
# alias rc='bundle exec rails c --nomultiline'
alias rc='bundle exec rails c'
alias wds='./bin/webpack-dev-server'
alias sk='./bin/sidekiq.sh'
alias ng='/ngrok.sh'

# docker
alias dc='docker compose'
# alias dcu='dc up'
alias dcu='dc up -d'
alias dcd='dc down'
alias dcps='dc ps'
alias kt='kubetail'
alias ks='stern -l'
alias k='kubectl'
alias kctx='kubectx'
alias kc="kubecolor"
alias kns='kubens'

# chezmoi
alias chez_diff="chezmoi diff"
alias chez_apply="chezmoi -v apply"
alias chez_add="chezmoi add"
alias chez_remove="chezmoi remove"
alias chez_unmanaged="chezmoi unmanaged"

#worktrees
alias gw="git worktree"
alias gwa="git worktree add"
alias gwl="git worktree list"
alias gwr="git worktree remove"
alias gwp="git worktree prune"

# kitty ssh: skitty hostname
# to copy files on connect, edit: ~/.config/kitty/ssh.conf
alias skitty=kitty +kitten ssh

# python
alias pactivate='source $(poetry env info --path)/bin/activate'

# https://qmacro.org/autodidactics/2021/08/06/tmux-output-formatting/
# 1. Open a popup
# 2. Show you all the docker images on your system in an FZF menu
# 3. Select your choice
# 4. A split pane (from target pane) will run docker run --rm -it <chosen_image>
alias dselect='tmux display-popup -E "docker image ls --format '{{.Repository}}' | fzf | xargs tmux split-window -h docker run --rm -it"'

# another option: https://github.com/natkuhn/Chrome-debug
alias chrome-debug='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --remote-debugging-port=9222&'

# git aliases
# also check https://github.com/tj/git-extras/blob/main/Commands.md
alias g='git'
alias ga='git add'
alias gap='git add -p'
alias gnap='git add -N --ignore-removal . && gap && gref'
alias gabsorb='git absorb --and-rebase' # https://github.com/tummychow/git-absorb
# alias gnap='git add $(git ls-files -N -add -o --exclude-standard) || git add -N --ignore-removal . && gap && gref'
alias gb="git branch --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) %(color:green)(%(committerdate:relative)) [%(authorname)]' --sort=-committerdate"
alias gc='git commit -v'
alias gca='git commit -a -v'
alias gce='git commit -m "This is a blank commit" --allow-empty'
alias gcb='git commit --allow-empty'
alias gcf='git commit --fixup'
alias gcl='git clean -f -d'
alias gd='git diff'
alias gds='git diff --staged'
alias gdc='git diff --cached'
alias glod='git log --oneline --decorate'
alias glola='git log --graph --decorate --pretty=oneline --abbrev-commit --all'
alias gpush='git push'
alias gpu='git push'
alias gpf='git pushf'
alias gp='git pull'
alias gput='git fetch --tags -f && git pull'
alias gpr='git pull --rebase'
alias pulls='git browse -- pulls'
alias branches='git browse -- branches'
alias gbranch='git branch --sort=-committerdate| fzf --height=20% |xargs git checkout'
alias gst='git status -sb'
alias gsta='git status'
alias ghst='gh pr status'
alias ghpr='gh pr list | fzf-tmux -p 90%,90% --preview "gh pr diff --color=always {+1}" |  { read first rest ; echo $first ; } | xargs gh pr checkout'
alias ghd='gh pr list | fzf-tmux -p 90%,90% --preview "gh pr diff --color=always {+1}" |  { read first rest ; echo $first ; } | xargs gh pr diff'
alias gs='fbr'
alias gr='git rebase'
alias grc='git rebase --continue'
alias gra='git rebase --abort'
alias grs='git rebase --skip'
alias gmc='git merge --continue'
alias gma='git merge --abort'
alias gms='git merge --skip'
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcps='git cherry-pick --skip'
alias gcpc='git cherry-pick --continue'
alias gco='git checkout'
# alias gcob='git checkout -b'
alias gcop='git checkout -p' # interactive hunk revert
alias gres='git restore --staged .'
alias gappend='git add . && git commit --amend -C HEAD'
alias gcappend='git add . && git commit --amend'
alias gamend='git commit --amend -C HEAD'
alias gcamend='git commit --amend'
alias gappendyolo='git add . && git commit --amend -C HEAD --no-verify'
alias gclean='git clean -fd'
alias unstage='git restore --staged .'
alias grestore="git restore --staged . && git restore ."
alias reset_authors='git commit --amend --reset-author -C HEAD'
alias grhr="git_reset_hard_remote"
alias grhl="git_reset_hard_local"
alias stash="git stash -u"
alias wip="git add . && gc -m 'wip [ci skip]' --no-verify"
# wtc = !sh -c 'git add -A && git commit $@ -m \""`curl -s https://whatthecommit.com/index.txt`"\"' -
alias undo="git reset HEAD~1 --mixed"
alias unwip="undo"
# alias unwip="git reset --soft 'HEAD^' && git restore --staged ."
alias nuke="unwip && grestore"
alias pokey="gco main && gpr && gco - && gr -"
alias gup="git up"
alias hokey="pokey"
alias sha="git rev-parse HEAD"
alias cannonball="git add . && git commit --amend -C HEAD && git push --force-with-lease"
alias cannonballyolo="git add . && HUSKY=0 git commit --amend -C HEAD && git push --force-with-lease"
alias fix='nvim +/HEAD `git diff --name-only | uniq`'

# https://github.com/gennaro-tedesco/gh-f
alias ghf='gh f'
alias ghfp='gh f prs'
alias ghfb='gh f branches'
alias ghfk='gh f pick'
alias ghfr='gh f runs'

# https://github.com/rnorth/gh-combine-prs
alias ghpr_combine='gh combine-prs --query "author:app/dependabot"'
alias ghpr_combineyolo='gh combine-prs --query "author:app/dependabot" --skip-pr-check'

# tmux alias
alias tmux_plugins_install="~/.tmux/plugins/tpm/bin/install_plugins"
alias tmux_plugins_update="~/.tmux/plugins/tpm/bin/update_plugins all"
alias tmux_plugins_clean="~/.tmux/plugins/tpm/bin/clean_plugins"

alias tig="TERM=xterm-256color tig"

# frum
alias rbl="frum local"
alias rbg="frum global"
alias rbu="frum uninstall"
alias rbv="frum versions"

alias tf="terraform"
alias tg="terragrunt"

# random alias
alias nvm="fnm"
alias strat="start"
alias ns="npm start"
alias barf="rm -rf node_modules && npm i"
alias rimraf="rm -rf node_modules"
alias ya="yarn auth"
alias yay="yarn auth && yarn"
alias yayb="yarn auth && yarn && bundle"
alias nan="npm run auth && npm i"

# brew tap jason0x43/homebrew-neovim-nightly
# brew cask install neovim-nightly
alias install-neovim-nightly-intel="brew install --cask neovim-nightly"
alias update-neovim-nightly-intel="brew reinstall neovim-nightly"
alias install-neovim-nightly="brew install --HEAD neovim"
alias update-neovim-nightly="brew reinstall neovim"
alias brew-tmux-head="brew reinstall tmux"
alias brew-install="brew bundle install --global"
alias brew-outdated="kill $(lsof -t +d $(brew --prefix)/var/homebrew/locks) >/dev/null 2>&1 || brew outdated"
alias brewup="brew upgrade; brew cleanup"
alias ghup="gh extension upgrade --all"
alias zshup="zcomet self-update && zcomet update"
# alias cargoup="cargo install $(cargo install --list | egrep '^[a-z0-9_-]+ v[0-9.]+:$' | cut -f1 -d' ')"

alias reload='source ~/.zshrc; echo -e "\n\u2699  \e[33mZSH config reloaded\e[0m \u2699"'

# alias curltime="curl -w \"@$HOME/.curl-format.txt\" -o /dev/null -s "
alias curltime="curl -o /dev/null -s -w 'Total: %{time_total}s\n' "
