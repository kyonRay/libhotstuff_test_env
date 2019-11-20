#!/bin/bash

base="$(dirname ${BASH_SOURCE[0]})"
keyscan="$base/ec2_keyscan.txt"

source "$base/conf.sh"

peer_list="./nodes.txt"
server_map="$base/ec2_server_map.txt"
copy_to_remote_pat="rsync -e 'ssh -o UserKnownHostsFile=$keyscan -i $ec2_pem' -avz <local_path> <remote_user>@<remote_ip>:<remote_path>"
copy_from_remote_pat="rsync -e 'ssh -o UserKnownHostsFile=$keyscan -i $ec2_pem' -avz <remote_user>@<remote_ip>:<remote_path> <local_path>"
run_remote_pat="$run_server_remote_pat"
exe_remote_pat="ssh -o UserKnownHostsFile=$keyscan -i '$ec2_pem' <remote_user>@<remote_ip> bash"

run="$scripts_base/run.sh"

$run --peer-list "$peer_list" --server-map "$server_map" --remote-user "$ec2_user" \
    --copy-to-remote-pat "$copy_to_remote_pat" --copy-from-remote-pat "$copy_from_remote_pat" \
    --exe-remote-pat "$exe_remote_pat" --run-remote-pat "$run_remote_pat" --remote-base "$remote_base" "$@"
