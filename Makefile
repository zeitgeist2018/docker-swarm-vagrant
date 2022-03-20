redeploy:
	@vagrant halt -f
	@vagrant destroy -f
	@vagrant up

configure-nodes:
	ansible-playbook host-ansible/main.yml -i host-ansible/inventory
