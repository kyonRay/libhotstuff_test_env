#!/bin/bash -e

base="$(dirname ${BASH_SOURCE[0]})"
keyscan="$base/ec2_keyscan.txt"

source "$base/conf.sh"

function myssh {
    h="$1"
    shift 1
    ssh -o UserKnownHostsFile="$keyscan" -i "$ec2_pem" "$h" "$@"
}

function myrsync {
    rsync -avP -e "ssh -o UserKnownHostsFile=$keyscan -i '$ec2_pem'" "$@"
}

rm -rf ec2_batch_log
mkdir ec2_batch_log
for host in $(cat ec2_pub_ips.txt); do
    (
        myssh "${ec2_user}@${host}" "bash -c \"mkdir -p "$proj_path" "$remote_base"\""
        myrsync "$src/" "${ec2_user}@${host}:$proj_path/" --delete
        myssh "${ec2_user}@${host}" "bash -c \"cd '$proj_path'; cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED=ON -DHOTSTUFF_PROTO_LOG=OFF -DCMAKE_CXX_FLAGS='-g -DHOTSTUFF_ENABLE_BENCHMARK' .; make -j4\""
    ) > "ec2_batch_log/${host}"  2>&1  &
done
wait
