function fzf_history
    # history merge incorporates history changes from other fish sessions
    history merge
    history --null \
        | sed "s/__delim__/\\x0/g" \
        | fzf --tiebreak=index --read0 --ansi --query=(commandline) \
        | read -lz cmd

    if test $status -eq 0
        # trim any surrounding white space
        commandline --replace (echo $cmd | sed -zr "s/^\s+|\s+\$//g")
    end
end
