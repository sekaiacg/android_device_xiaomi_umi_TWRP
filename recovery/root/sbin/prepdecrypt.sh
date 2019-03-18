#!/sbin/sh

relink()
{
	fname=$(basename "$1")
	target="/sbin/$fname"
	sed 's|/system/bin/linker64|///////sbin/linker64|' "$1" > "$target"
	chmod 755 $target
}

relink /sbin/qseecomd
relink /sbin/android.hardware.gatekeeper@1.0-service-qti
relink /sbin/android.hardware.keymaster@4.0-service-qti

setprop prep.decrypt 1
exit 0