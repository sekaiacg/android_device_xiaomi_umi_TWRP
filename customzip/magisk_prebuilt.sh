#!/bin/sh

CUSTOMZIP_DIR="$1"
MAGISK_DIR="${CUSTOMZIP_DIR}/Magisk"
MAGISK_ZIP="Magisk.apk"
MAGISK_VER="MagiskVer"
MAGISKALPHA_ZIP="MagiskAlpha.apk"
MAGISKALPHA_VER="MagiskAlphaVer"
MAGISK_ZIP_PATH="${MAGISK_DIR}/${MAGISK_ZIP}"
MAGISK_VER_PATH="${MAGISK_DIR}/${MAGISK_VER}"
MAGISKALPHA_ZIP_PATH="${MAGISK_DIR}/${MAGISKALPHA_ZIP}"
MAGISKALPHA_VER_PATH="${MAGISK_DIR}/${MAGISKALPHA_VER}"
MAGISK_URL="https://raw.githubusercontent.com/sekaiacg/twrp_prebuilt/master/Magisk"
CURL="curl"
[[ -f "/sbin/curl" ]] && CURL="/sbin/curl"
[[ -f "/bin/curl" ]] && CURL="/bin/curl"
[[ -f "/usr/bin/curl" ]] && CURL="/usr/bin/curl"
CURL_CMD="${CURL} -sL --connect-timeout 5 -m 30 --retry 2 -o"

[[ ! -d "${MAGISK_DIR}" ]] &&  mkdir -p "${MAGISK_DIR}"

logYR()
{
	echo -e "\e[33m $1\e[m\e[91m$2\e[m"
}

download_magisk()
{
	[[ ! -f "${MAGISK_ZIP_PATH}" ]] && ${CURL_CMD} ${MAGISK_ZIP_PATH} ${MAGISK_URL}/${MAGISK_ZIP}
	[[ ! -f "${MAGISK_VER_PATH}" ]] && ${CURL_CMD} ${MAGISK_VER_PATH} ${MAGISK_URL}/${MAGISK_VER}
	[[ ! -f "${MAGISKALPHA_ZIP_PATH}" ]] && ${CURL_CMD} ${MAGISKALPHA_ZIP_PATH} ${MAGISK_URL}/${MAGISKALPHA_ZIP}
	[[ ! -f "${MAGISKALPHA_VER_PATH}" ]] && ${CURL_CMD} ${MAGISKALPHA_VER_PATH} ${MAGISK_URL}/${MAGISKALPHA_VER}
	sleep 1
}

verify()
{
	if [ -f "${MAGISK_ZIP_PATH}" ] &&
		[ -f "${MAGISK_VER_PATH}" ] &&
		[ -f "${MAGISKALPHA_ZIP_PATH}" ] &&
		[ -f "${MAGISKALPHA_VER_PATH}" ]; then
		exit 0
	else
		logYR "magisk_prebuilt: " "Download file failed !"
		exit 1
	fi
}

download_magisk
verify
