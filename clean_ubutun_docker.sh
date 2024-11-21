#!/bin/bash

echo "Cleaning temporary files, caches and containers..."

# Clean apt cache (Debian/Ubuntu)
echo "Cleaning apt cache..."
sudo apt autoclean -y
sudo apt autoremove -y

# Remove temporary files
echo "Removing temporary files..."
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*
sudo rm -rf ~/.cache/*
# Clear journal logs (optional

# Clear journal logs (optional)
echo "Clearing journal logs...
sudo journalctl --vacuum-time=1s

# Clear System Logs
echo "Clear System Logs"
sudo find /var/log -type f -exec truncate -s 0 {} \;
sudo find /var/log -type f \( -name "*.gz" -o -name "*.1" \) -delete


# Clean Up Exited Containers, Unused Images, and Volumes
echo "Clean Up Exited Containers, Unused Images, and Volumes..."
sudo docker system prune -a -f

# Truncate Docker logs on the host
echo "Truncate Docker logs on the host..."
for container in $(sudo docker ps -q); do
  log_path=$(sudo docker inspect --format='{{.LogPath}}' "$container")
  echo "Truncating Docker log: $log_path"
  sudo truncate -s 0 "$log_path"
done