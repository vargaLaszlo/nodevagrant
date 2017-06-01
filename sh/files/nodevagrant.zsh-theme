# ZSH Theme - Preview:

# Errors
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

# Host
local user_host='%{$fg[green]%}%m%{$reset_color%}'

# Directory
local current_dir='%{$fg[yellow]%}%c%{$reset_color%}' # ~|b|c

# $
local ret_status="%(?:%{$fg_bold[white]%}%B●%b:%{$fg_bold[red]%}%B●%b%s)"

# Promt
PROMPT=" ○ ${user_host} ${current_dir}
 ${ret_status} "

# Aside promt
RPS1="${return_code}"
