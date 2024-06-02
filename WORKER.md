# Worker

## Setup

To setup a new worker node:

```console
TARGET=<target> \
CLUSTER_NAME=<cluster_name> \
DD_API_KEY=<dd_api_key> \
MOUNT_POINT=<mount_point> \
RAID_SETUP=<raid_setup> \
RAID_MD_DEVICE=<raid_md_device> \
RAID_LEVEL=<raid_level> \
RAID_DEVICE_COUNT=<raid_device_count> \
RAID_DEVICES="<raid_devices>" \
LAUNCH_DEAMONS=<launch_daemons> \
LAUNCH_THORNODE=<launch_thornode> \
NAMESPACE=<namespace> \
make worker
```

where:

| Param                 | Description                                                                                             | Required |
|-----------------------|---------------------------------------------------------------------------------------------------------|----------|
| `<target>`            | The inventory target.                                                                                   | `true`   |
| `<cluster_name>`      | The name of the cluster.                                                                                | `true`   |
| `<dd_api_key>`        | DataDog API key. Only required if using DataDog.                                                        | `false`  |
| `<mount_point>`       | Where to mount the storage for the worker node.                                                         | `true`   |
| `<raid_setup>`        | Configure software RAID on the worker node.                                                             | `false`  |
| `<raid_md_device>`    | The MD device to use for this RAID setup. Optional; only required if `RAID_SETUP=true`                  | `false`  |
| `<raid_level>`        | The RAID level to use for this RAID setup. Optional; only required if `RAID_SETUP=true`                 | `false`  |
| `<raid_device_count>` | The number of physical devices to use for this RAID setup. Optional; only required if `RAID_SETUP=true` | `false`  |
| `<raid_devices>`      | A list of physical devices to use for this RAID setup. Optional; only required if `RAID_SETUP=true`     | `false`  |
| `<launch_daemons>`    | Launch the chain daemons.                                                                               | `false`  |

e.g.:

```console
TARGET=my-worker-node \
CLUSTER_NAME=my-cluster \
DD_API_KEY=0gdd04PXCn999CYNHd1mJ7lylKs5uMZk \
MOUNT_POINT=/mnt/data \
RAID_SETUP=true \
RAID_MD_DEVICE=/dev/md4 \
RAID_LEVEL=0 \
RAID_DEVICE_COUNT=2 \
RAID_DEVICES="/dev/sda,/dev/sdb" \
LAUNCH_DEAMONS=true \
make worker
```
