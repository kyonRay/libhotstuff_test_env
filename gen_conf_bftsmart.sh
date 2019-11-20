#!/bin/bash
mkdir -p config
../bft-smart/runscripts/gen_sys.sh "$1"
../bft-smart/runscripts/gen_host.sh
