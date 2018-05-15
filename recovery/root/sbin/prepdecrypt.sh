#!/sbin/sh

relink()
{
	/sbin/cp $1 ${1}_old
	sed 's|/system/bin/linker64|///////sbin/linker64|' "${1}_old" > "$1"
	chmod 755 $1
}

relink /sbin/qseecomd
relink /sbin/android.hardware.gatekeeper@1.0-service-qti
relink /sbin/android.hardware.keymaster@3.0-service-qti

/sbin/setprop crypto.ready 1