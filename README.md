# Raspberry Pi Setup

## Usage
On the raspberry pi run:
```bash
git clone https://github.com/cameronperot/rpi-setup.git
cd rpi-setup
./rpi-setup.sh
```

## Raspbian Image
The latest image can be found [here](https://www.raspberrypi.org/downloads/raspbian/).
The image can be written to the SD card using:
```bash
dd bs=4M status=progress conv=fsync if=<IMAGE> of=<DEVICE>
```

## Remote Access Configuration
After writing the image to the SD card copy the files from the `boot` directory in this repo to the `boot` partition on the SD card.
The `ssh` file enables the `sshd` service, and the `wpa_supplicant.conf` file can be edited with wifi SSID and password so that it auto connects upon boot.
From there you can access the raspberry pi using the default credentials:
```
username: pi
password: raspberry
```

## Install pi-hole
https://github.com/pi-hole/pi-hole/

```bash
git clone --depth 1 https://github.com/pi-hole/pi-hole.git Pi-hole
cd "Pi-hole/automated install/"
sudo bash basic-install.sh
```

## Enable VNC Connect
https://www.raspberrypi.org/documentation/remote-access/vnc/

```bash
sudo apt install realvnc-vnc-server realvnc-vnc-viewer
```
