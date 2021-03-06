# Script to launch games with lower device resolution
# uses `pgrep, tail` from GNU coreutils, available in a Magisk module,
# since toolBox's `tail` doesn't implement '--pid=' option,
# and `am , renice , wm` from /system/bin.
# Using Bash is recommended, but it should work with default Android mksh
# as well so no shebang here.

# script for performance mod, device dependent
#. 0msm8916_performance.sh

# Intent specifics for launching an application
action="android.intent.action.MAIN"
category="android.intent.category.LAUNCHER"

# app specifics, installation uid and LAUNCHER Activity

# app user id is useful when using method 1 of finding pid of running
# FoF process only, not needed when using method 2
#uid="u0_a413"
# ^^^^^^^^^^^ this value needs to be updated after app re-installs
# try `dumpsys package com.koyokiservices.FoF | grep userID=`
# you'll get number xxnnn replace "xx" with "u0_a"
# or launch FoF, and try to find FoF in `htop` tool, uid should be there.

# FoF package_Name and  main_activity name
package="com.koyokiservices.FoF"
activity="com.google.firebase.MessagingUnityPlayerActivity"

# am command args for launching the app
cmd="start -a $action -c $category $package/$activity"

# Alter resolution to what works best for you
# string is res_X x resY, ie for 1280x720 size, you use 720x1280
# sample resolutions :
# 320x640
# 384x512
# 420x800
# 480x720
# 480x854
# 512x960
# 540x960
# 600x800
# 720x1280 etc.

# First alter the device resolution

wm size 480x854

# Then launch the app, call `am` with proper args
am $cmd

# Wait while game loads
sleep 1 && echo "sleeping for a second done!"

# Get pid of launched FoF process

#method 1: ps|grep comboo

#pid=`ps | grep $package | grep $uid | cut -d' ' -f 4`
#pid=`echo $pid | cut -d" " -f 4`

# pgrep is directly available as root user in gnu coreutils magisk module,
# so use that insted of
# ps | grep | cut combo
# method 2: with pgrep

#pid=`pgrep $package`
pid=$(pgrep $package)

echo "pid=$pid"

# Set process id to max cpu priority, maybe keep it -15 ?
renice -20 "$pid"

# Wait while pid is running
# method 1, while-do loop

#while :
#do
#	result=`pgrep $package`
#	if [ "${result:-null}" = null ]; then
#		wm size 720x1280
#		break
#	fi
#	sleep 10
#done

# method 2 , tail with command
#echo "time tail --pid=$pid -f /dev/null"

time tail --pid="$pid" -f /dev/null

# Finally, reset the resolution to default
wm size reset

#echo "   ."
# set perf mode to average, device dependent scripts
#. 2msm8916_avg.sh

echo "program complete"

