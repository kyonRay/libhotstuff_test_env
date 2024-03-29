base="$(dirname ${BASH_SOURCE[0]})"
scripts_base="$base/exp"
src="./libhotstuff" # the source code directory (local)
proj_path="/libhotstuff_test_env/libhotstuff" # the source code directory (remote)
proj_server_bin="examples/hotstuff-app"
proj_server_path="$proj_path/$proj_server_bin"
proj_client_bin="examples/hotstuff-client"
proj_client_path="$proj_path/$proj_client_bin"
proj_conf_name="hotstuff.conf"
remote_base="/libhotstuff_test_env"
ec2_user=root
#ec2_profile=ia
#ec2_keyid="ted-aws-key"
#ec2_ami="ami-03a29238640f23d42"
#ec2_sg="sg-0b48e8635d7894784"
ec2_pem="$base/VMware1ware.pem"

run_server_remote_pat="cd \"<rworkdir>\"; '$proj_server_path' --conf \"hotstuff.gen-sec<node_id>.conf\" --notls"
run_client_remote_pat="cd \"<rworkdir>\"; '$proj_client_path' --idx 1 --cid <node_id> --iter -1 --max-async 200"
