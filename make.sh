#! /usr/local/bin/bash4

# node node_modules/jsdoc/jsdoc.js --verbose --readme "/Users/jhyland/Documents/Projects/personal/sasset/sasset-core-beta/README.md" --template "/Users/jhyland/Documents/Projects/personal/sasset/sasset-core-beta/docs/templates/docdash-custom" --destination "./" --recurse "/Users/jhyland/Documents/Projects/personal/sasset/sasset-core-beta/docs/docs_enabled"

sasset_base="/Users/jhyland/Documents/Projects/personal/sasset"

declare -A hl

hl[reset]="\e[0m"
hl[bold]="\e[1m"
hl[black]="\e[30m"
hl[red]="\e[31m"
hl[green]="\e[32m"
hl[yellow]="\e[33m"
hl[blue]="\e[34m"
hl[magenta]="\e[35m"
hl[cyan]="\e[36m"
hl[white]="\e[37m"

declare -A sasset_core

sasset_core[root]="${sasset_base}/sasset-core-beta"
sasset_core[readme]="${sasset_core[root]}/README.md"


declare -A sasset_docs

sasset_docs[root]="${sasset_base}/sasset-core-docs"
sasset_docs[template]="${sasset_docs[root]}/templates/docdash-custom"
sasset_docs[input]="${sasset_docs[root]}/docs_enabled"
sasset_docs[output]="${sasset_docs[root]}/html"
sasset_docs[jsdocbin]="${sasset_docs[root]}/node_modules/jsdoc/jsdoc.js"

declare -A pattern

pattern[header]="${hl[yellow]}%s:${hl[reset]}\n"
pattern[data]="\t${hl[cyan]}%-10s${hl[reset]} : ${hl[bold]}%s${hl[reset]}\n"


printf "${pattern[header]}" "SASSET Core"

for i in ${!sasset_core[@]}; do
  printf "${pattern[data]}" "${i}" "${sasset_core[$i]}"
  #echo -e "${i}\t: ${sasset_docs[$i]}"
done

echo -en "\n"

printf "${pattern[header]}" "SASSET Documentation"

for i in ${!sasset_docs[@]}; do
  printf "${pattern[data]}" "${i}" "${sasset_docs[$i]}"
  #echo -e "${i}\t: ${sasset_docs[$i]}"
done

echo -en "\n"

#jsdoc_switches=""

cmd="${sasset_docs[jsdocbin]} --readme \"${sasset_core[readme]}\" --template \"${sasset_docs[template]}\" --destination \"${sasset_docs[output]}\" --recurse \"${sasset_docs[input]}\""

printf "${pattern[header]}" "Executing Command"
echo -e "\t${hl[bold]}${cmd}${hl[reset]}\n"

confirm_txt=$(echo "Press ${hl[green]}${hl[bold]}Y${hl[reset]} key to ${hl[bold]}continue${hl[reset]}, or ${hl[red]}${hl[bold]}N${hl[reset]} to ${hl[bold]}abort${hl[reset]}: ")

#read -n 1 -s -p "${confirm_txt}" confirm

echo -ne "Press ${hl[green]}${hl[bold]}Y${hl[reset]} key to ${hl[bold]}continue${hl[reset]}, or ${hl[red]}${hl[bold]}N${hl[reset]} to ${hl[bold]}abort${hl[reset]}: "

read -n 1 -s confirm

echo -e "\n"

confirm=$(echo "${confirm}" | tr '[A-Z]' '[a-z]')


if [[ "${confirm}" != "y" ]]; then
  echo "Confirmation failed - Aborting."
  exit 
fi

echo -e "Resuming documentation generation..\n"
eval "${cmd}"