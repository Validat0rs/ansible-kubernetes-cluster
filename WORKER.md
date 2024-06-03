# Worker

## Setup

Prior to launching your worker, please ensure you configure your drives accordingly. RAID/LVM setup is outside the scope of this README. For reference, please see the below examples of how we have configured our worker nodes.

### RAID 1+0

We've had a lot of success with this setup, which is referred to as a _"stripe of mirrors"_. 

In our setup, we have six (6) physical NVMe drives.

1. Create the Raid 1 (mirror) arrays:

```console
mdadm --create --verbose /dev/md4 --level=1 --raid-devices=2 /dev/nvme0n1 /dev/nvme1n1
mdadm --create --verbose /dev/md5 --level=1 --raid-devices=2 /dev/nvme4n1 /dev/nvme5n1
mdadm --create --verbose /dev/md6 --level=1 --raid-devices=2 /dev/nvme6n1 /dev/nvme7n1
```

2. Create the Raid 0 (stripe) array:

```console
mdadm --create --verbose /dev/md7 --level=0 --raid-devices=3 /dev/md4 /dev/md5 /dev/md6 
```

3. Format the array:

```console
mkfs.btrfs -f /dev/md7
```

4. Obtain the device UUID:

```console
blkid /dev/md7 | awk '{ print $2 }' | sed -e's/UUID=//g' -e's/\"//g'
```

5. Update `/etc/fstab`

```
UUID=<uuid> /mnt/data btrfs defaults 0 0
```

where `<uuid>` is the UUID obtained in step 4, e.g.:

```
UUID=6d4f7cbd-8b8e-4be2-9944-6a9365711439 /mnt/data btrfs defaults 0 0
```

7. Create the mount point:

```console
mkdir /mnt/data
```

8. Reload:

```console
systemctl daemon-reload
```

9. Mount:

```console
mount -a
```

## Launch

To launch a new worker node:

```console
TARGET=<target> \
DD_API_KEY=<dd_api_key> \
DD_CLUSTER_NAME=<dd_cluster_name> \
MOUNT_POINT=<mount_point> \
LAUNCH_DEAMONS=<launch_daemons> \
LAUNCH_THORNODE=<launch_thornode> \
THORNODE_NAMESPACE=<thornode_namespace> \
THORNODE_PASSWORD=<thornode_password> \
make worker
```

where:

| Param                  | Description                                                                                             | Required |
|------------------------|---------------------------------------------------------------------------------------------------------|----------|
| `<target>`             | The inventory target.                                                                                   | `true`   |
| `<dd_api_key>`         | DataDog API key. Only required if using DataDog.                                                        | `false`  |
| `<dd_cluster_name>`    | The name of the cluster. Only required if using DataDog.                                                | `false`  |
| `<mount_point>`        | Where the storage is mounted for the worker node.                                                       | `true`   |
| `<launch_daemons>`     | Launch the chain daemons.                                                                               | `false`  |
| `<launch_thornode>`    | Launch a THORNode.                                                                                      | `false`  |
| `<thornode_namespace>` | THORNode Kubernetes namespace. Optional; only required if `LAUNCH_THORNODE=true`                        | `false`  |
| `<thornode_password>`  | THORNode password. Optional; only required if `LAUNCH_THORNODE=true`                                    | `false`  |

e.g.:

```console
TARGET=my-worker-node \
DD_API_KEY=0gdd04PXCn999CYNHd1mJ7lylKs5uMZk \
DD_CLUSTER_NAME=my-cluster \
MOUNT_POINT=/mnt/data \
LAUNCH_DEAMONS=true \
LAUNCH_THORNODE=true \
THORNODE_NAMESPACE=thornode-1 \
THORNODE_PASSWORD="somepassword" \
make worker
```
