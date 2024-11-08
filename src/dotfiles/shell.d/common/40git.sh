#!/usr/bin/env bash

# _short_path() {
# 	if [[ -z $1 ]]; then
# 		echo ""
# 	fi
#
# 	local path=$1
# 	local spath
#
# 	spath=${path/#$HOME/\~}
# 	spath=${spath/main\/.worktrees/wt}
# 	spath=${spath/.worktrees/wt}
#
# 	echo "${spath}"
# }

git-wt-switch() {
	HAS_FZF=$(command -v fzf)

	if [[ -z $HAS_FZF ]]; then
		echo "fzf is not installed, fzf is required for this command"
		return 1
	fi

	# local spath=""
	# local wt_list=""
	# ODIFS=$IFS
	# IFS=$'\n'
	# for line in $(git-wt list); do
	# 	spath=$(_short_path $(echo "$line" | awk '{print $2}'))
	# 	wt_list+="$(echo $line | awk '{print $1}') ${spath}\n"
	# done
	# IFS=$ODIFS

	# worktree=$(echo $wt_list | column --table | fzf --color)
	worktree=$(git-wt | fzf --color)

	if [[ "$worktree" ]]; then
		name=$(echo "$worktree" | awk '{print $1}')
		wtdir=$(echo "$worktree" | awk '{print $2}')
		# hash=$(echo "$worktree" | awk '{print $3}')

		if [[ -d "$wtdir" ]]; then
			echo "Switching to $name"
			cd "$wtdir" || return 1
		else
			echo "Unable to switch to $name : $wtdir"
			return 1
		fi
	fi

	return 0
}
