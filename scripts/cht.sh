#!/usr/bin/env bash
languages=$(echo "python javascript typescript cpp c nodejs" | tr ' ' '\n')
core_utils=$(echo "xargs find mv sed awk" | tr ' ' '\n')

selected=$(printf "%s\n%s\n" "$languages" "$core_utils" | fzf)
read -p "query: " query

if printf "$languages" | grep -qs "$selected"; then
  tmux neww bash -c "curl cht.sh/$selected/$(echo $query | tr ' ' '+') & while [ : ]; do sleep 1; done"
else
  curl cht.sh/$selected~$query
fi
