# ubuntu-gdm
A Script to change GDM login background to Image or Color on Ubuntu 20.04 LTS (focal fossa) and above.

# Caution
This script works only on Ubuntu 20.04 and above.
It also won't work if your system is set to a custom gdm3 theme. You will have to reset to the default configuration of gdm3 before using the script.
A Reboot is adviced after first use of the Script.

# Requirements
This Script requires *libglib2.0-dev-bin* which can be installed while running the script.

# How to Install
Clone this Directory with ollowing Command :

```git clone https://github.com/SirParmar/ubuntu-gdm.git && cd ubuntu-gdm```

And set the 'ubuntu-gdm.sh' as executable :

```chmod +x ubuntu-gdm```


# Using the Script
1. Run the script with root privileges such as ```sudo ./ubuntu-gdm.sh --set```

2. Choose What you want to set. i.e, - 1. Image  OR  2. Colour

3. Input the path of the Image OR the HEX Code of the Colour.

2. If you see a confirmation message specifying image sucessfully changed, then you need to restart your shell or reboot your device.

3. In case you want the default login screen, you can revert to the original gdm theme with  ```sudo ./ubuntu-gdm.sh --reset.```

# Thanking Me
To support or thank, kindly ping at ManishOnLinux@gmail.com. 
To Donate via UPI : manishonlinux@okicici
