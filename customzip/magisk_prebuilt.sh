#!/bin/bash

CUSTOMZIP_DIR="$1"
MAGISK_UNOFFICIAL_VERSION="$2"
MAGISK_DIR="${CUSTOMZIP_DIR}/Magisk"
MAGISKVERIFY_SHA256="verify.sha256sum"
MAGISK_ZIP="Magisk.apk"
MAGISK_VER="MagiskVer"
MAGISK_ZIP_PATH="${MAGISK_DIR}/${MAGISK_ZIP}"
MAGISK_VER_PATH="${MAGISK_DIR}/${MAGISK_VER}"
MAGISKALPHA_ZIP="MagiskAlpha.apk"
MAGISKALPHA_VER="MagiskAlphaVer"
MAGISKDelta_ZIP="MagiskDelta.apk"
MAGISKDelta_VER="MagiskDeltaVer"
MAGISKUNOFFICIAL_ZIP_PATH="${MAGISK_DIR}/MagiskUnofficial.apk"
MAGISKUNOFFICIAL_VER_PATH="${MAGISK_DIR}/MagiskUnofficialVer"
MAGISK_URL="https://raw.githubusercontent.com/sekaiacg/twrp_prebuilt/master/Magisk"
CURL="curl"
[ -f "/sbin/curl" ] && CURL="/sbin/curl"
[ -f "/bin/curl" ] && CURL="/bin/curl"
[ -f "/usr/bin/curl" ] && CURL="/usr/bin/curl"

[ ! -d "${MAGISK_DIR}" ] &&  mkdir -p "${MAGISK_DIR}"

logYR()
{
	echo -e "\e[33m $1\e[m\e[91m$2\e[m"
}

logYG()
{
	echo -e "\e[33m $1\e[m\e[92m$2\e[m"
}

curl_dl()
{
	$(${CURL} -sL $1 -H 'Cache-Control: no-cache' --connect-timeout 3 -m 35 --retry 2 -o $2)
}

curl_read()
{
	local RESULT="$(${CURL} -sL $1 -H 'Cache-Control: no-cache' --connect-timeout 3 -m 5 --retry 3)"
	echo "${RESULT}"
	return $?
}

download_magisk()
{
	[ ! -f "${MAGISK_ZIP_PATH}" ] && curl_dl ${MAGISK_URL}/${MAGISK_ZIP} ${MAGISK_ZIP_PATH}
	[ ! -f "${MAGISK_VER_PATH}" ] && curl_dl ${MAGISK_URL}/${MAGISK_VER} ${MAGISK_VER_PATH}
	if [ "${MAGISK_UNOFFICIAL_VERSION}" = "Alpha" ]; then
		[ ! -f "${MAGISKUNOFFICIAL_ZIP_PATH}" ] && curl_dl ${MAGISK_URL}/${MAGISKALPHA_ZIP} ${MAGISKUNOFFICIAL_ZIP_PATH}
		[ ! -f "${MAGISKUNOFFICIAL_VER_PATH}" ] && curl_dl ${MAGISK_URL}/${MAGISKALPHA_VER} ${MAGISKUNOFFICIAL_VER_PATH}
	elif [ "${MAGISK_UNOFFICIAL_VERSION}" = "Delta" ]; then
		[ ! -f "${MAGISKUNOFFICIAL_ZIP_PATH}" ] && curl_dl ${MAGISK_URL}/${MAGISKDelta_ZIP} ${MAGISKUNOFFICIAL_ZIP_PATH}
		[ ! -f "${MAGISKUNOFFICIAL_VER_PATH}" ] && curl_dl ${MAGISK_URL}/${MAGISKDelta_VER} ${MAGISKUNOFFICIAL_VER_PATH}
	fi
}

do_verify()
{
	local VERIFY_ITEM=$1
	local TARGET_DL_PATH=$2
	local VERIFY_SHA256=$(echo "${VERIFY_ITEM}" | awk -F '-' '{print $1}')
	local VERIFY_FILE=$(echo "${VERIFY_ITEM}" | awk -F '-' '{print $2}')

	local VERIFY_FAIL=0
	if [ -f ${TARGET_DL_PATH} ] && [ ${#VERIFY_SHA256} -ge 64 ] && [ ${#VERIFY_FILE} -gt 1 ]; then
		local TARGET_DL_SHA256="$(sha256sum ${TARGET_DL_PATH} | awk -F ' ' '{print $1}')"
		if [ "${VERIFY_SHA256}" = "${TARGET_DL_SHA256}" ]; then
			logYG "${VERIFY_FILE}: " "Verification succeeded !"
		else
			# Try a second time
			curl_dl "${MAGISK_URL}/$VERIFY_FILE" "$TARGET_DL_PATH"
			TARGET_DL_SHA256=$(sha256sum ${TARGET_DL_PATH} | awk -F ' ' '{print $1}')
			if [ "${VERIFY_SHA256}" = "${TARGET_DL_SHA256}" ]; then
				logYG "${VERIFY_FILE}: " "Verification succeeded !"
			else
				rm -f ${TARGET_DL_PATH} > /dev/null 2>&1
				logYR "${VERIFY_FILE}: " "Verification failed !"
				VERIFY_FAIL=1
			fi
		fi
	else
		logYR "magisk_prebuilt: " "Download file failed !"
		VERIFY_FAIL=1
	fi

	return ${VERIFY_FAIL}
}

verify()
{
	local VERIFY_FAIL=0
	local VERIFY_FILE=$(curl_read ${MAGISK_URL}/${MAGISKVERIFY_SHA256} | sed 's/  /-/g')
	[ ${#VERIFY_FILE} -lt 64 ] && logYR "magisk_prebuilt: " "Read sha256 file failed !"  && exit 1
	local VERIFY_RET=0
	do_verify $(echo "${VERIFY_FILE}" | grep ${MAGISK_VER}) ${MAGISK_VER_PATH} || VERIFY_RET=1
	do_verify $(echo "${VERIFY_FILE}" | grep ${MAGISK_ZIP}) ${MAGISK_ZIP_PATH} || VERIFY_RET=1
	if [ "${MAGISK_UNOFFICIAL_VERSION}" = "Alpha" ]; then
		do_verify $(echo "${VERIFY_FILE}" | grep ${MAGISKALPHA_VER}) ${MAGISKUNOFFICIAL_VER_PATH} || VERIFY_RET=1
		do_verify $(echo "${VERIFY_FILE}" | grep ${MAGISKALPHA_ZIP}) ${MAGISKUNOFFICIAL_ZIP_PATH} || VERIFY_RET=1
	elif [ "${MAGISK_UNOFFICIAL_VERSION}" = "Delta" ]; then
		do_verify $(echo "${VERIFY_FILE}" | grep ${MAGISKDelta_VER}) ${MAGISKUNOFFICIAL_VER_PATH} || VERIFY_RET=1
		do_verify $(echo "${VERIFY_FILE}" | grep ${MAGISKDelta_ZIP}) ${MAGISKUNOFFICIAL_ZIP_PATH} || VERIFY_RET=1
	fi
	[ ${VERIFY_RET} -eq 0 ] && exit 0 || exit 1
}

download_magisk
verify
