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

twrp_name=`getprop ro.product.system.name`

if [[ -n "$twrp_name" ]]; then
  case ${twrp_name} in
   twrp_umi)
      _resetprop "Mi 10" "umi"
      ;;
   twrp_cmi)
      _resetprop "Mi 10 Pro" "cmi"
      ;;
   twrp_lmi)
      _resetprop "Redmi K30 Pro" "lmi"
      ;;
   *) 
      exit 0
      ;;
  esac
fi

exit 0




