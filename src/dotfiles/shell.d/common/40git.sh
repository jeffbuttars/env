#!/usr/bin/env bash

git-wt-switch() {
	HAS_FZF=$(command -v fzf)

	if [[ -z $HAS_FZF ]]; then
		echo "fzf is not installed, fzf is required for this command"
		return 1
	fi

	worktree=$(git-wt list | fzf --color)

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

# declare -a RUN_FILES=("compose.override.yml" ".env" ".env.dev" ".env.prod")
#
# _git_worktree_relisted() {
# 	git worktree list 2>/dev/null | column --table --table-order 3,1,2
# }
#
# _git-wt-get-dir() {
# 	if [[ -z $1 ]]; then
# 		echo ""
# 		return
# 	fi
#
# 	local wt_name="$1"
#
# 	_git_worktree_relisted | while read wt; do
# 		name=$(echo "$wt" | awk '{print $1}')
# 		wtdir=$(echo "$wt" | awk '{print $2}')
# 		# echo "$name $wtdir"
#
# 		if [[ "$name" == "[${wt_name}]" ]]; then
# 			echo "$wtdir"
# 			return
# 		fi
# 	done
#
# 	echo ""
# }
#
# _git-wt-find-main() {
# 	_git_worktree_relisted | while read wt; do
# 		name=$(echo "$wt" | awk '{print $1}')
# 		wtdir=$(echo "$wt" | awk '{print $2}')
#
# 		if [[ "$name" == '[main]' ]]; then
# 			echo "$wtdir"
# 			return
# 		fi
# 	done
# 	echo ""
# }
#
# _git-wt-current() {
# 	local git_dir=""
#
# 	git_dir=$(git rev-parse --git-dir 2>/dev/null)
# 	if [[ "$?" != "0" ]]; then
# 		echo ""
# 		return
# 	fi
#
# 	if [[ "$git_dir" == ".git" ]]; then
# 		echo ""
# 		return
# 	fi
#
# 	basename "$git_dir"
# }
#
# _git-wt-cp-run-files-into-cur-wt() {
# 	local cur_wt_name
# 	local cur_wt_dir
# 	local main_src_dir
#
# 	# If we're in the main/cloned dir or not a worktree, do nothing
# 	cur_wt_name=$(_git-wt-current)
# 	if [[ -z ${cur_wt_name} ]]; then
# 		echo "Not in a worktree"
# 		return
# 	fi
#
# 	cur_wt_dir=$(_git-wt-get-dir "$cur_wt_name")
# 	if [[ -z ${cur_wt_dir} ]]; then
# 		echo "Can't find worktree directory!"
# 		return
# 	fi
#
# 	# Then, are we in a worktree dir?
# 	main_src_dir=$(_git-wt-find-main)
# 	if [[ -z ${main_src_dir} ]]; then
# 		echo "Unable to find main src dir"
# 		return
# 	fi
#
# 	_git-wt-cp-run-files "$main_src_dir" "$cur_wt_dir"
# }
#
# _git-wt-cp-run-files() {
# 	if [[ "$#" != "2" ]]; then
# 		return
# 	fi
#
# 	local src_dir="$1"
# 	local dest_dir="$2"
#
# 	if [[ ! -d "$src_dir" ]]; then
# 		return
# 	fi
#
# 	if [[ ! -d "$dest_dir" ]]; then
# 		return
# 	fi
#
# 	cd "$src_dir" || return
#
# 	for runfile in "${RUN_FILES[@]}"; do
# 		# echo "Looking for $runfile in $src_dir ..."
#
# 		find "." -name "$runfile" | while read -r rfile; do
# 			prefix_dir=$(dirname "$rfile")
# 			fname=$(basename "$rfile")
# 			con_dir=$(readlink -f "${dest_dir}/${prefix_dir}")
# 			dst_file="${con_dir}/${fname}"
#
# 			# echo "SOURCE: $rfile"
# 			if [[ -d "$con_dir" ]]; then
# 				if [[ ! -f "$dst_file" ]]; then
# 					ln -v "$rfile" "$dst_file"
# 				# else
# 				# 	echo "file already exists, not creating link: $rfile -> $dst_file"
# 				fi
# 			# else
# 			# 	echo "Expected destination dir doesn't exist: ${con_dir}/${fname}"
# 			fi
# 		done
# 	done
#
# 	cd - || return
# }
#
# git-wt-switch() {
# }
#
# git-wt() {
# 	if [[ -z $1 ]]; then
# 		_git_worktree_relisted
# 		return 0
# 	fi
#
# 	HAS_FZF=$(command -v fzf)
#
# 	if [ "$1" == "switch" ] || [ "$1" == "sw" ]; then
# 		if [[ -z $HAS_FZF ]]; then
# 			echo "fzf is not installed, fzf is required for this command"
# 			return 1
# 		fi
#
# 		worktree=$(_git_worktree_relisted | fzf --color)
#
# 		if [[ "$worktree" ]]; then
# 			name=$(echo "$worktree" | awk '{print $1}')
# 			wtdir=$(echo "$worktree" | awk '{print $2}')
# 			# hash=$(echo "$worktree" | awk '{print $3}')
#
# 			if [[ -d "$wtdir" ]]; then
# 				echo "Switching to $name"
# 				cd "$wtdir" || return 1
# 			else
# 				echo "Unable to switch to $name : $wtdir"
# 				return 1
# 			fi
# 		fi
#
# 		return 0
# 	fi
#
# 	if [[ "$1" == 'cp' ]]; then
# 		_git-wt-cp-run-files-into-cur-wt
# 		return
# 	fi
#
# 	if [[ "$1" == 'add' ]]; then
# 		args=("$@")
# 		last_arg=${args[${#args[@]}]}
# 		second_last_arg=${args[${#args[@]} - 1]}
#
# 		if [[ "$(git worktree $*)" ]]; then
# 			# Do our best to link over runtime, non git, files into the new workspace
# 			if [[ -d "$last_arg" ]]; then
# 				_git-wt-cp-run-files "$PWD" "$last_arg"
# 			elif [[ -d "$second_last_arg" ]]; then
# 				_git-wt-cp-run-files "$PWD" "$second_last_arg"
# 			fi
# 		fi
#
# 		return
# 	fi
#
# 	git worktree "$*"
# }
