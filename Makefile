redeploy:
	@vagrant halt -f
	@vagrant destroy -f
	@vagrant up

bootstrap-cluster:
	ansible-playbook host-ansible/main.yml -i host-ansible/inventory
