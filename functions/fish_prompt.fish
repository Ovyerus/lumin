# name: lumin
# A simple and clean fish prompt.

set -g __lumin_symb '▲'
set -g __lumin_leading_brace 0

set -g __lumin_has_launched 0

function _lumin_git_info
    set -l branch (git rev-parse --abbrev-ref HEAD 2> /dev/null)
    printf "%s(%s%s%s)" $c0 $c1 $branch $c0

    set -l changes (git status --porcelain --ignore-submodules 2> /dev/null)

    if test -n "$changes"
        printf '%s*' $c5

        set -l additions (git diff --numstat | awk '{ i += $1 } END { print i }')
        set -l deletions (git diff --numstat | awk '{ i += $2 } END { print i }')

        if test -n $additions
            or test -n $deletions
            printf ' '
        end

        if test -n $additions
            and test $additions -gt 0
            printf '%s+' $c3
        end

        if test -n $deletions
            and test $deletions -gt 0
            printf '%s-' $c4
        end
    end
end

function fish_prompt
    if test $status -eq 0
        set errored (set_color normal)
    else
        set errored (set_color $fish_color_error)
    end

    set -g c0 (set_color blue)
    set -g c1 (set_color magenta)
    set -g c2 (set_color yellow)
    set -g c3 (set_color green)
    set -g c4 (set_color red)
    set -g c5 (set_color brblack)
    set -g c6 (set_color normal)

    # set -l path (string replace $HOME '~' (pwd))
    set -l last_command (history | head -1)

    if test $__lumin_has_launched -eq 0
        set -g __lumin_has_launched 1
    else if test $last_command != "clear"
        printf '\n'
    end

    if set -q our_status
        printf '\n'
    end
    if test $__lumin_leading_brace -eq 1
        printf '%s⌊ ' $c0
    end

    printf '%s%s%s ⌉ ' $c3 (prompt_pwd) $c0
    # printf '%s%s%s ⌉ ' $c3 $path $c0

    git -C . rev-parse 2>/dev/null

    if test $status -eq 0
        _lumin_git_info
    end

    printf '\n'
    if test (id -u) -eq 0
        printf '%s⚡ ' $c2
    end
    printf '%s%s %s' $errored $__lumin_symb $c6
end
