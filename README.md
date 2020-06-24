# ubuntu-gdm
A Script to change GDM login background on Ubuntu 20.04 LTS (focal fossa) and above.

# Caution
This script works only on Ubuntu 20.04 and above.
It also won't work if your system is set to a custom gdm3 theme. You will have to reset to the default configuration of gdm3 before using the script.

# Requirements
This Script requires libglib2.0-dev-bin which can be installed via :  sudo apt install libglib2.0-dev-bin

# How to Install
Download the Script with following command :

wget github.com/manishonlinux/ubuntu-gdm/raw/master/ubuntu-gdm
And set it as an executable with chmod +x gdm-change-login-background

# Using the Script
1. Run the script with root privileges such as sudo ./ubuntu-gdm- /path/to/image

2. If you see a confirmation message specifying image sucessfully changed, then you need to restart your shell or reboot your device.

3. In case you want the default login screen, you can revert to the original gdm theme with sudo ./ubuntu-gdm --restore.

# Thanking Me
To support or thank, kindly ping at ManishOnLinux@gmail.com. 
To Donate via UPI : manishonlinux@okicici
