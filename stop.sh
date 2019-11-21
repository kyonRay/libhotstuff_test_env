#!/bin/bash
srv="$1"
cli="${srv}_cli"
./run_ec2_client.sh stop "$cli"
sleep 5
./run_ec2_client.sh fetch "$cli"
./run_ec2.sh stop "$srv"
./run_ec2.sh reset "$srv"
./run_ec2_client.sh reset "$cli"
cat "$cli"/*.log |  python3 exp/thr_hist.py | tee "$cli/results"
