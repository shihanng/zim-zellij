() {
  builtin emulate -L zsh
  local -r target_dir=${1}
  shift

  (( ${+commands[${1}]} )) || return 1

  local compfile=$target_dir/functions/_${1}
  if [[ ! -e $compfile || $compfile -ot ${1} ]]; then
    "${@}" >| $compfile
    print -u2 -PR "* Detected a new version '${1}'. Regenerated completions."
  fi
} ${0:h} zellij setup --generate-completion zsh
