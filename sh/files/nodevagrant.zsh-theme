# ZSH Theme - Preview:

# Errors
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

# Host
local user_host='%{$fg[green]%}%m%{$reset_color%}'

# Directory
local current_dir='%{$fg[yellow]%}%c%{$reset_color%}' # ~|b|c

# Git
local git_branch='$(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[yellow]%}◎"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}●"
ZSH_THEME_GIT_PROMPT_ADDED=" %{$fg[yellow]%}●"
ZSH_THEME_GIT_PROMPT_MODIFIED=" %{$fg[yellow]%}◎"
ZSH_THEME_GIT_PROMPT_DELETED=" %{$fg[yellow]%}⊗"
ZSH_THEME_GIT_PROMPT_RENAMED=" %{$fg[yellow]%}○"
ZSH_THEME_GIT_PROMPT_UNMERGED=" %{$fg[red]%}◍"
ZSH_THEME_GIT_PROMPT_UNTRACKED=" %{$fg[yellow]%}◌"
ZSH_THEME_GIT_PROMPT_REMOTE_MISSING=" %{$fg[blue]%}◒"
ZSH_THEME_GIT_PROMPT_AHEAD=" %{$fg[blue]%}▶"
ZSH_THEME_GIT_PROMPT_BEHIND=" %{$fg[blue]%}◁"

# Time
local current_time='%{$fg[grey]%}%*%{$reset_color%}'

# $
local ret_status="%(?:%{$fg_bold[white]%}%B$%b:%{$fg_bold[red]%}%B$%b%s)"

# Promt
PROMPT="○ ${user_host} ${current_dir} ${git_branch}
● ${ret_status} "

# Aside promt
RPS1="${return_code}"
