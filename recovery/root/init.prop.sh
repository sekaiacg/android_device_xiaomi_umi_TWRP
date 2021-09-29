#!sbin/sh

_resetprop(){
  resetprop ro.product.model $1
  resetprop ro.product.odm.model $1
  resetprop ro.product.system.model $1
  resetprop ro.product.vendor.model $1
  resetprop ro.product.product.model $1
  resetprop ro.product.system_ext.model $1
  resetprop ro.product.device $2
  resetprop ro.product.odm.device $2
  resetprop ro.product.system.device $2
  resetprop ro.product.vendor.device $2
  resetprop ro.build.product $2
  resetprop ro.product.name $2
  resetprop ro.product.odm.name $2
  resetprop ro.product.product.device $2
  resetprop ro.product.product.name $2
  resetprop ro.product.system.name $2
  resetprop ro.product.system_ext.device $2
  resetprop ro.product.system_ext.name $2
  resetprop ro.product.vendor.name $2
}

reset(){

if [[ $1 == "1" ]]; then
  _resetprop "Mi 10 Pro" "cmi"
else
  _resetprop "Mi 10" "umi"
fi

}

hwversion=`getprop ro.boot.hwversion | awk -F '[.]' '{print $1}'`

if [[ ${#hwversion} -ge 1 ]]; then
  reset $hwversion
else
  reset "2"
fi

exit 0




