launch_fof.sh is a shell script to launch Android apps, supposedly games
with different/lower resolution than native device resolution.
It's written with root method of Magisk and Termux.

Setup & Usage
	Install Magisk module "GNU Utils for Android",
	see https://forum.xda-developers.com/android/software-hacking/mods-zackptg5-s-misc-projects-t3881164
	Put the script in location of your choice, launch it with root privileges to launch FoF instead of launcher icon.
	The device resolution can be adjusted in the script, find which suits you by trial & error.

	First the device resolution is altered,then designated app is launched, script waits while the launched app process is running,
	and restores device resolution to default when app process dies.

Warning :
	Using this script can potentially put your Android device in a locked state, when this script is in use and device 
	is locked, the script doesn't terminate, so it currently cannot restore device resolution back to default one. With
	the altered resolution, the device lock guard might crash, preventing you from unlocking your phone.

	One dirty work-around currently is to reset device resolution every boot, so in worst case scenario, you just reboot
	the device and normal state resolution will be restored,
	see https://github.com/Harshiv-Patel/SM-E700H_modifications/blob/master/data/adb/service.d/wminit.sh
	for how I do it, for now.
