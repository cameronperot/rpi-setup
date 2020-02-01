#!/bin/bash
set -e

# Ensure script is run with root permissions
if [ "$USER" != 'root' ]; then
	echo "You must run this script as root!"
	exit 1;
fi

# Username, SSH keys, and location of the user's home directory for the new user
new_user=cameron
ssh_key1="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKIukxLRRwpbgDxqcsdRY77i7T+Ptsrs8J9tfNrWncHK"
ssh_key2="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO8Nsh7r7SoYZD2JZolMZCJVT9O6OkKlQuQl27YlqQVy"
home_dir=/home/$new_user

# Create the new user and add them to the sudo group
adduser --gecos "" $new_user
usermod -a -G sudo $new_user

# Aliases for the new user
echo "alias ls='ls -lahF --color=always'" >> $home_dir/.bash_aliases
sudo chown $new_user:$new_user $home_dir/.bash_aliases

# Set up the new user's ~/.ssh directory and authorized_keys
mkdir $home_dir/.ssh
chmod 700 $home_dir/.ssh
echo $ssh_key1 >> $home_dir/.ssh/authorized_keys
echo $ssh_key2 >> $home_dir/.ssh/authorized_keys
chmod 600 $home_dir/.ssh/authorized_keys
chown -R $new_user:$new_user $home_dir/.ssh

# Update and install some useful programs
apt-get update
apt-get -y upgrade
apt-get -y install \
	vim \
	tmux \
	nload \
	git \
	ca-certificates

# Disable root and password login for SSH
tee -a /etc/ssh/sshd_config > /dev/null <<EOT
PermitRootLogin no
HostbasedAuthentication no
PermitEmptyPasswords no
PasswordAuthentication no
PubkeyAuthentication yes
EOT
