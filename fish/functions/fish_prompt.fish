# vim: set noet:

function fish_prompt --description "Write out the prompt"
    echo

    echo -n -s (set_color cyan) (pwd | sed "s=$HOME=~=") (set_color normal) (__fish_git_prompt)

    set_color normal

    echo

    echo -n -s (set_color red) '-> '

    set_color normal
end
