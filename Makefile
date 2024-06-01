ifdef TARGET
	TARGET_OPTS = '-l $(TARGET)'
endif

ifdef RAID_SETUP
	RAID_OPTS = 'raid_setup=$(RAID_SETUP) raid_md_device=$(RAID_MD_DEVICE) raid_level=$(RAID_LEVEL) raid_device_count=$(RAID_DEVICE_COUNT) raid_devices=$(RAID_DEVICES)'
endif

ifdef LAUNCH_DEAMONS
	LAUNCH_DEAMONS_OPTS = 'launch_daemons=$(LAUNCH_DEAMONS)'
endif

ifdef LAUNCH_THORNODE
	LAUNCH_THORNODE_OPTS = 'launch_thornode=$(LAUNCH_THORNODE)'
endif

worker:
	@ansible-playbook -i inventory/hosts -e "target=$(TARGET) dd_api_key=$(DD_API_KEY) mount_point=$(MOUNT_POINT) $(RAID_OPTS) $(LAUNCH_DEAMONS_OPTS) $(LAUNCH_THORNODE_OPTS)" $(TARGET_OPTS) worker.yml
