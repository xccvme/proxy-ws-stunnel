clear
ip a
cat /etc/netplan/50-cloud-init.yaml 
clear
sudo nano /etc/netplan/60-extra-interfaces.yaml
sudo netplan apply
ip a
clear
apt-get update && apt-get upgrade -y
clear
ip a
dhclient -v ens20
clear
sudo nano /etc/netplan/60-extra-interfaces.yaml
rm /etc/netplan/60-extra-interfaces.yaml
sudo nano /etc/netplan/60-extra-interfaces.yaml
sudo netplan apply
ip a
clear
apt-get install neofetch
apt-get install curl
curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash
sudo apt-get install speedtest
speedtest
shutdown now
clear
ping google.com
clear
rm -f /etc/resolv.conf
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 1.1.1.1" >> /etc/resolv.conf
systemctl restart systemd-resolved 2>/dev/null || systemctl restart networking 2>/dev/null
nano /etc/netplan/60-extra-interfaces.yaml 
clear
ip a
cat /etc/netplan/60-extra-interfaces.yaml 
rm /etc/netplan/60-extra-interfaces.yaml
nano /etc/netplan/60-extra-interfaces.yaml
netplan apply
cat /etc/netplan/60-extra-interfaces.yaml 
ip a
clear
rm /etc/netplan/60-extra-interfaces.yaml
nano /etc/netplan/60-extra-interfaces.yaml
chmod 600 /etc/netplan/60-extra-interfaces.yaml
netplan generate
netplan try
netplan apply
clear
ip a
ping 1.1.1.1
ping google.com
clear
ip a
curl -sSL https://raw.githubusercontent.com/ica4me/configure-new-server/main/setup_ssh_remote.sh | bash
curl -sSL https://raw.githubusercontent.com/ica4me/configure-new-server/main/setup_time.sh | bash 
clear
date
ip a
systemctl status ssh
clear
systemctl status ssh
ip a
ping 172.16.3.60
clear
journalctl -u ssh -n 50 --no-pager
sshd -t
apt update
apt install --reinstall -y openssh-server
sshd -t
systemctl status ssh
ssh-keygen -A
ls -l /etc/ssh/ssh_host_*
sshd -t
systemctl restart ssh
systemctl status ssh --no-pager
ss -tulpn | grep :22
clear
systemctl status ssh --no-pager
nano /etc/ssh/sshd_config
systemctl restart ssh
systemctl restart sshd
cler
clear
df -a
df -ah
df -h
clear
shutdown now
clear
ip a
date
clear
ip a
clear
hostsnamectl set-ubuntu22.04
hostnamectl set-ubuntu22.04
hostnamectl set-hostname ubuntu22.04
clear
ip a
sudo - ubuntu
su - ubuntu
su -ubuntu
cat /etc/passwds
cat /etc/passwd
clear
hostnamectl set-hostname ubuntu2204
exit
apt-get update
hostnamectl
# 1. Mengatur Timezone
sudo timedatectl set-timezone Asia/Jakarta
# 2. Konfigurasi User: ubuntu
# Mengecek apakah user ubuntu sudah ada, jika belum maka dibuat
getent passwd ubuntu >/dev/null || sudo useradd -m -s /bin/bash -G sudo ubuntu
# Memberikan akses sudo tanpa password untuk user ubuntu
echo "ubuntu ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/90-cloud-init-ubuntu >/dev/null
sudo chmod 0440 /etc/sudoers.d/90-cloud-init-ubuntu
# Menetapkan password
echo 'ubuntu:This_2me@oke' | sudo chpasswd
# 3. Konfigurasi User Tambahan: xccvme
# Mengecek apakah user xccvme sudah ada, jika belum maka dibuat (termasuk grup sudo)
getent passwd xccvme >/dev/null || sudo useradd -m -s /bin/bash -G sudo xccvme
# Menetapkan password
echo 'xccvme:This_2me@oke' | sudo chpasswd
# 4. Konfigurasi User: root
# Menetapkan password root dan membuka kunci (unlock) akun root
echo 'root:xccvme' | sudo chpasswd
sudo passwd -u root 2>/dev/null || true
# 5. Menulis Konfigurasi Custom SSH
cat << 'EOF' | sudo tee /etc/ssh/sshd_config.d/00-custom-password-auth.conf >/dev/null
Port 22
Port 2026
PasswordAuthentication yes
KbdInteractiveAuthentication no
ChallengeResponseAuthentication no
UsePAM yes
PermitRootLogin yes
EOF

# Menyesuaikan hak akses berkas konfigurasi SSH
sudo chmod 0644 /etc/ssh/sshd_config.d/00-custom-password-auth.conf
# 6. Validasi dan Terapkan Aturan SSH
# Mengecek apakah ada sintaks yang salah di konfigurasi SSH
sudo sshd -t
# Merestart layanan SSH agar port 2026 dan password authentication aktif
sudo systemctl restart ssh
clear
cat /etc/ssh/sshd_config.d/00-custom-password-auth.conf
cat /etc/passwd
clear
exit
clear
ip a
ip -br a
ip link set ens21 up
ip link set ens22 up
ip -br a
nano /etc/netplan/60-extra-interfaces.yaml 
netplan apply
clear
ip a
ping google.com
ip -br a
clear
shutdown now
ip a
nano /etc/netplan/50-cloud-init.yaml 
nano /etc/netplan/60-extra-interfaces.yaml 
rm /etc/netplan/60-extra-interfaces.yaml 
netplan apply
ip a
exit
