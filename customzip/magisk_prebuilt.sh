#!/bin/sh

CUSTOMZIP_DIR="$1"
MAGISK_DIR="${CUSTOMZIP_DIR}/Magisk"
MAGISK_ZIP="Magisk.apk"
MAGISK_VER="MagiskVer"
MAGISKALPHA_ZIP="MagiskAlpha.apk"
MAGISKALPHA_VER="MagiskAlphaVer"
MAGISKVERIFY_SHA256="verify.sha256sum"
MAGISK_ZIP_PATH="${MAGISK_DIR}/${MAGISK_ZIP}"
MAGISK_VER_PATH="${MAGISK_DIR}/${MAGISK_VER}"
MAGISKALPHA_ZIP_PATH="${MAGISK_DIR}/${MAGISKALPHA_ZIP}"
MAGISKALPHA_VER_PATH="${MAGISK_DIR}/${MAGISKALPHA_VER}"
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
	$(${CURL} -sL $1 -H 'Cache-Control: no-cache' --connect-timeout 2 -m 30 --retry 2 -o $2)
}

curl_read()
{
	local RESULT="$(${CURL} -sL $1 -H 'Cache-Control: no-cache' --connect-timeout 2 -m 10 --retry 2)"
	echo "${RESULT}"
	return $?
}

download_magisk()
{
	[ ! -f "${MAGISK_ZIP_PATH}" ] && curl_dl ${MAGISK_URL}/${MAGISK_ZIP} ${MAGISK_ZIP_PATH}
	[ ! -f "${MAGISK_VER_PATH}" ] && curl_dl ${MAGISK_URL}/${MAGISK_VER} ${MAGISK_VER_PATH} 
	[ ! -f "${MAGISKALPHA_ZIP_PATH}" ] && curl_dl ${MAGISK_URL}/${MAGISKALPHA_ZIP} ${MAGISKALPHA_ZIP_PATH} 
	[ ! -f "${MAGISKALPHA_VER_PATH}" ] && curl_dl ${MAGISK_URL}/${MAGISKALPHA_VER} ${MAGISKALPHA_VER_PATH}
	sleep 1
}

verify()
{
	local VERIFY_STATE=1
	if [ -f "${MAGISK_ZIP_PATH}" ] &&
		[ -f "${MAGISK_VER_PATH}" ] &&
		[ -f "${MAGISKALPHA_ZIP_PATH}" ] &&
		[ -f "${MAGISKALPHA_VER_PATH}" ]; then
		local VERIFY=$(curl_read ${MAGISK_URL}/${MAGISKVERIFY_SHA256} | sed 's/  /-/g')
		[ ${#VERIFY} -lt 64 ] && logYR "magisk_prebuilt: " "Download file failed !"  && exit 1
		for item in ${VERIFY}
		do
		 	local VERIFY_FILE_SHA256=$(echo "${item}" | awk -F '-' '{print $1}')
			local VERIFY_FILE_NAME=$(echo "${item}" | awk -F '-' '{print $2}')
			local TARGET_DL_PATH=""
			[ "${VERIFY_FILE_NAME}" == "${MAGISK_ZIP}" ] && TARGET_DL_PATH=${MAGISK_ZIP_PATH}
			[ "${VERIFY_FILE_NAME}" == "${MAGISK_VER}" ] && TARGET_DL_PATH=${MAGISK_VER_PATH}
			[ "${VERIFY_FILE_NAME}" == "${MAGISKALPHA_ZIP}" ] && TARGET_DL_PATH=${MAGISKALPHA_ZIP_PATH}
			[ "${VERIFY_FILE_NAME}" == "${MAGISKALPHA_VER}" ] && TARGET_DL_PATH=${MAGISKALPHA_VER_PATH}
			local TARGET_DL_SHA256=$(sha256sum ${TARGET_DL_PATH} | awk -F ' ' '{print $1}')
			if [ ${#VERIFY_FILE_SHA256} -ge 64 ] &&
				[ ${#VERIFY_FILE_NAME} -gt 1 ] &&
				[ ${#TARGET_DL_PATH} -gt 1 ] &&
				[ ${#TARGET_DL_SHA256} -ge 64 ]; then

				if [ "${VERIFY_FILE_SHA256}" == "${TARGET_DL_SHA256}" ]; then
					logYG "${VERIFY_FILE_NAME}: " "Verification succeeded !"
				else
					VERIFY_STATE=0
					rm -f ${TARGET_DL_PATH} > /dev/null 2>&1
					logYR "${VERIFY_FILE_NAME}: " "Verification failed !"
				fi
			else
				logYR "magisk_prebuilt: " "Download file failed !"
				exit 1
			fi
		done
		[ ${VERIFY_STATE} -eq 1 ] && exit 0 || exit 1
	else
		logYR "magisk_prebuilt: " "Download file failed !"
		exit 1
	fi
}

download_magisk
verify
