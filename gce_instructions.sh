# Restart docker pull
sudo systemctl start konlet-startup

# If instance dies
# Mount disk
sudo mount -o discard,defaults /dev/sdb /mnt/disks/disk-bots
# Fix permissions
sudo chown -R 1000:1000 /mnt/disks/disk-bots/
# Restart docker container
sudo systemctl start konlet-startup
