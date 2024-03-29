# Tmux
alias tm="tmux"
alias tmkses="tmux kill-session"
alias tmkser="tmux kill-server"
alias tmls="tmux ls"

# Docker
alias d='docker'
alias dco='docker-compose'
jupyter() {
    CONFIG_VOLUME=jupyter-config
    IMAGE=jupyter/tensorflow-notebook
    IMAGE_VERSION=2023-01-09

    docker run --rm -p 8888:8888 \
        -v $HOME/.ssh:/home/jovyan/.ssh \
        --mount type=bind,source=$HOME/.gitconfig,target=/home/jovyan/.gitconfig \
        -v $CONFIG_VOLUME:/home/jovyan/.jupyter \
        -v $(pwd):/home/jovyan/work \
        $@ $IMAGE:$IMAGE_VERSION
}
alias jupyter-here='jupyter -v $(pwd):/home/jovyan/work'
ngx() {
    [ -z $1 ] && port="8080:80" || port="$1:80"
    docker run \
        --rm \
        -v $(pwd):/usr/share/nginx/html:ro \
        -p $port \
        nginx:mainline-alpine
}

# Pandocpdf
pandocpdf() {
    pandoc --pdf-engine=xelatex -V mainfont=FreeSerif $1 -o ${1/.md/.pdf}
}

# Kubernetes
alias k='kubectl'

# misc
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ccat="highlight --out-format=ansi --force"
alias cls='clear'
alias sorc='source $HOME/.bashrc'
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
