ifdef TARGET
	TARGET_OPTS = '-l $(TARGET)'
endif

ifdef RAID_SETUP
	RAID_OPTS = '-e raid_setup=$(RAID_SETUP) -e raid_md_device=$(RAID_MD_DEVICE) -e raid_level=$(RAID_LEVEL) -e raid_device_count=$(RAID_DEVICE_COUNT) -e raid_devices=$(RAID_DEVICES)'
endif

ifdef LAUNCH_DEAMONS
	LAUNCH_DEAMONS_OPTS = '-e launch_daemons=$(LAUNCH_DEAMONS)'
endif

ifdef LAUNCH_THORNODE
	LAUNCH_THORNODE_OPTS = '-e launch_thornode=$(LAUNCH_THORNODE) -e thornode_namespace=$(THORNODE_NAMESPACE) -e thornode_password=$(THORNODE_PASSWORD)'
endif

worker:
	@ansible-playbook -i inventory/hosts -e target=$(TARGET) -e dd_api_key=$(DD_API_KEY) -e mount_point=$(MOUNT_POINT) $(RAID_OPTS) $(LAUNCH_DEAMONS_OPTS) $(LAUNCH_THORNODE_OPTS) $(TARGET_OPTS) worker.yml
