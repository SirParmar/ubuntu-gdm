#!/bin/bash
# Change GDM Background on Ubuntu 20.04 and above.
# By Manish Singh Parmar © 2020
# Contact: ManishOnLinux@gmail.com
# GitHub : SirParmar
# 
# =================================================================== #

# Check if script is run by root.
if [ "$(id -u)" -ne 0 ] ; then
    echo "You need to be an Administrator to run this Script.
    Use :  sudo ./ubuntu-gdm.sh --set
    
    Script by : Manish Singh Parmar (github.com/SirParmar)"
    exit 1
fi

if [ ! "$(lsb_release -c | cut -f 2)" == focal ]; then
    echo "This script only works with Ubuntu 20.04 (focal fossa) and above....Exiting.
    Script by : Manish Singh Parmar (github.com/SirParmar)"
    exit 1
fi

#Assigning Default GDM theme file path.
source="/usr/share/gnome-shell/theme/Yaru/gnome-shell-theme.gresource"

# Check if glib 2.0 development libraries are installed.
if [ ! -x "$(command -v glib-compile-resources)" ]; then
    echo 'Additional glib 2.0 libraries need to be installed.'
    read -p 'Type y or Y to proceed. Any other key to exit: ' -n 1
    if [[ "$REPLY" =~ ^[yY]$ ]]; then
	apt install libglib2.0-dev-bin
    else
	echo
	exit 1
    fi
fi

############################################################################################
case "$1" in ###############################################################################
############################################################################################
--set)
############################################################################################


echo "
-------------------------------------------------------------------------------------------------------
You need to Reboot the System, Only if you are using the script for the first time.
>>>>>>>>>After 1st Restart, only logout will show you the applied settings, No need for Reboot.<<<<<<<<<<<<


Press any Key to Continue (Y/y/Enter/AnyKey).	Type 'N/n' to exit.
-------------------------------------------------------------------------------------------------------"
read answer

if [ "$answer" == "n" ] || [ "$answer" == "N" ]
then
echo "Okay, Exiting...
Script by : Manish Singh Parmar (github.com/SirParmar)"
exit 1
fi

echo "
Please Choose any one number from below.
-----------------------------------------
1. for Image		2. for Color
-----------------------------------------"
read a

if [ -z $a ]
then
echo "No Option chosen.
Exiting...
Script by : Manish Singh Parmar (github.com/SirParmar)"
exit 1
fi

if [ "$a" == "1" ]
then
echo "Enter Path for the Image, to set as Login screen (JPG/PNG only)
----------------------------------------------------
Example1: /usr/share/backgrounds/image.jpg
Example2: /usr/local/share/backgrounds/lockscreen.png
Example3: /home/username/Pictures/myPhoto.jpeg
----------------------------------------------------"
read b

elif [ "$a" == "2" ]
then
echo "
Enter Hex Color Code for Login Screen
-------------------------------------------------------------------------------------------------------------------------
Example1: #00ff00
Example2: #fca
Example3: #456789
Example4: #123
Example5: #FF00FF
-------------------------------------------------------------------------------------------------------------------------"
read c
fi

if [ -z $b ] && [ -z $c ]
then
echo "Invalid Input .
Exiting...
Script by : Manish Singh Parmar (github.com/SirParmar)"
exit 1
fi

if [ -z $c ]
then
color="#042320"
else
color="$c"
fi

if ! [ -z $c ]
then
    	if ! [[ $c =~ ^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$ ]]; then
    	echo "
------------------------------------------------------------------------------------------------------------
    	Invalid HEX Color Code, Enter a valid HEX color to apply desired settings.
------------------------------------------------------------------------------------------------------------"
    	exit 1
    	fi
fi

if ! [ -z $b ]
then
	if ! [ -e $b ]; then
	echo "
---------------------------------------------------------------------------------------------------
Image path you entered is Invalid, A default background defined by me is going to be used for now.
Please notedown the correct file path of the Image and then run this script.
---------------------------------------------------------------------------------------------------"
	fi
fi

prefix="/org/gnome/shell/theme"
dest="/usr/local/share/gnome-shell/theme/ubuntu-gdm"

install -D /dev/null $dest/gdm3.css
install -D /dev/null $dest/ubuntu-gdm.gresource.xml
install -d $dest/icons/scalable/actions

gresource extract $source $prefix/gdm3.css > $dest/original.css
gresource extract $source $prefix/checkbox.svg > $dest/checkbox.svg
gresource extract $source $prefix/checkbox-off.svg > $dest/checkbox-off.svg
gresource extract $source $prefix/checkbox-focused.svg > $dest/checkbox-focused.svg
gresource extract $source $prefix/checkbox-off-focused.svg > $dest/checkbox-off-focused.svg
gresource extract $source $prefix/toggle-on.svg > $dest/toggle-on.svg
gresource extract $source $prefix/toggle-off.svg > $dest/toggle-off.svg
gresource extract $source $prefix/icons/scalable/actions/pointer-drag-symbolic.svg > $dest/icons/scalable/actions/pointer-drag-symbolic.svg
gresource extract $source $prefix/icons/scalable/actions/keyboard-enter-symbolic.svg > $dest/icons/scalable/actions/keyboard-enter-symbolic.svg
gresource extract $source $prefix/icons/scalable/actions/keyboard-hide-symbolic.svg > $dest/icons/scalable/actions/keyboard-hide-symbolic.svg
gresource extract $source $prefix/icons/scalable/actions/pointer-secondary-click-symbolic.svg > $dest/icons/scalable/actions/pointer-secondary-click-symbolic.svg
gresource extract $source $prefix/icons/scalable/actions/keyboard-shift-filled-symbolic.svg > $dest/icons/scalable/actions/keyboard-shift-filled-symbolic.svg
gresource extract $source $prefix/icons/scalable/actions/keyboard-caps-lock-filled-symbolic.svg > $dest/icons/scalable/actions/keyboard-caps-lock-filled-symbolic.svg
gresource extract $source $prefix/icons/scalable/actions/pointer-primary-click-symbolic.svg > $dest/icons/scalable/actions/pointer-primary-click-symbolic.svg
gresource extract $source $prefix/icons/scalable/actions/keyboard-layout-filled-symbolic.svg > $dest/icons/scalable/actions/keyboard-layout-filled-symbolic.svg
gresource extract $source $prefix/icons/scalable/actions/eye-not-looking-symbolic.svg > $dest/icons/scalable/actions/eye-not-looking-symbolic.svg
gresource extract $source $prefix/icons/scalable/actions/pointer-double-click-symbolic.svg > $dest/icons/scalable/actions/pointer-double-click-symbolic.svg
gresource extract $source $prefix/icons/scalable/actions/eye-open-negative-filled-symbolic.svg > $dest/icons/scalable/actions/eye-open-negative-filled-symbolic.svg

echo '@import url("resource:///org/gnome/shell/theme/original.css");
  #lockDialogGroup {
  background: '$color' url(file://'$b');
  background-repeat: no-repeat;
  background-size: cover;;
  background-position: center; }' > $dest/gdm3.css

echo '<?xml version="1.0" encoding="UTF-8"?>
<gresources>
  <gresource prefix="/org/gnome/shell/theme">
    <file>original.css</file>
    <file>gdm3.css</file>
    <file>toggle-off.svg</file>
    <file>checkbox-off.svg</file>
    <file>toggle-on.svg</file>
    <file>checkbox-off-focused.svg</file>
    <file>checkbox-focused.svg</file>
    <file>checkbox.svg</file>
    <file>icons/scalable/actions/pointer-drag-symbolic.svg</file>
    <file>icons/scalable/actions/keyboard-enter-symbolic.svg</file>
    <file>icons/scalable/actions/keyboard-hide-symbolic.svg</file>
    <file>icons/scalable/actions/pointer-secondary-click-symbolic.svg</file>
    <file>icons/scalable/actions/keyboard-shift-filled-symbolic.svg</file>
    <file>icons/scalable/actions/keyboard-caps-lock-filled-symbolic.svg</file>
    <file>icons/scalable/actions/pointer-primary-click-symbolic.svg</file>
    <file>icons/scalable/actions/keyboard-layout-filled-symbolic.svg</file>
    <file>icons/scalable/actions/eye-not-looking-symbolic.svg</file>
    <file>icons/scalable/actions/pointer-double-click-symbolic.svg</file>
    <file>icons/scalable/actions/eye-open-negative-filled-symbolic.svg</file>
  </gresource>
</gresources>' > $dest/ubuntu-gdm.gresource.xml

cd $dest
glib-compile-resources ubuntu-gdm.gresource.xml
mv ubuntu-gdm.gresource ..
rm -r $dest
update-alternatives --quiet --install /usr/share/gnome-shell/gdm3-theme.gresource gdm3-theme.gresource /usr/local/share/gnome-shell/theme/ubuntu-gdm.gresource 0
update-alternatives --quiet --set gdm3-theme.gresource /usr/local/share/gnome-shell/theme/ubuntu-gdm.gresource

check=$(update-alternatives --query gdm3-theme.gresource | grep Value | grep /usr/local/share/gnome-shell/theme/ubuntu-gdm.gresource >/dev/null && echo "pass" || echo "fail")
if [ "$check" == "pass" ]
then
echo "
				     		---------
						|Success|
						---------
			   Script by : Manish Singh Parmar (github.com/SirParmar)"
else
echo Failure
exit 1
fi
;;
############################################################################################
--reset) ###################################################################################
############################################################################################

if [ -e /usr/local/share/gnome-shell/theme/ubuntu-gdm.gresource ]
then
rm /usr/local/share/gnome-shell/theme/ubuntu-gdm.gresource
update-alternatives --quiet --set gdm3-theme.gresource "$source"
cd /usr/local/share
rmdir --ignore-fail-on-non-empty -p gnome-shell/theme
echo "
				     		---------------
						|Reset Success|
						---------------
			   Script by : Manish Singh Parmar (github.com/SirParmar)"
else
echo "
-----------------------------------------------------------------------------
Already Reset. (or may be background is not set using this Script.)
-----------------------------------------------------------------------------"
exit 1
fi
;;
############################################################################################
*) #########################################################################################
############################################################################################
echo "Use the parameters '--set' or '--reset'; example: 'ubuntu-gdm.sh --set' or 'ubuntu-gdm.sh --reset'
Script Written by : Manish Singh Parmar (github.com/SirParmar)"
exit 1
esac
