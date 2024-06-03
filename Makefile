ifdef TARGET
	TARGET_OPTS = '-l $(TARGET)'
endif

ifdef DD_API_KEY
	DD_OPTS = '-e dd_api_key=$(DD_API_KEY) -e dd_cluster_name=$(DD_CLUSTER_NAME)'
endif

ifdef LAUNCH_DEAMONS
	LAUNCH_DEAMONS_OPTS = '-e launch_daemons=$(LAUNCH_DEAMONS)'
endif

ifdef LAUNCH_THORNODE
	LAUNCH_THORNODE_OPTS = '-e launch_thornode=$(LAUNCH_THORNODE) -e thornode_namespace=$(THORNODE_NAMESPACE) -e thornode_password=$(THORNODE_PASSWORD)'
endif

worker:
	@ansible-playbook -i inventory/hosts -e target=$(TARGET) $(DD_OPTS) -e mount_point=$(MOUNT_POINT) $(LAUNCH_DEAMONS_OPTS) $(LAUNCH_THORNODE_OPTS) $(TARGET_OPTS) worker.yml
