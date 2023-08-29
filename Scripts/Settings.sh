#!/bin/bash

#删除冲突插件
rm -rf $(find ./feeds/luci/ -type d -regex ".*\(argon\|argon\).*")
#修改默认主题
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git ./package/lean/luci-theme-argon 
git clone -b 18.06 https://github.com/jerrykuku/luci-app-argon-config.git ./package/lean/luci-app-argon-config
#修改默认IP地址
sed -i "s/192\.168\.[0-9]*\.[0-9]*/$OpenWrt_IP/g" ./package/base-files/files/bin/config_generate
#修改默认主机名
sed -i "s/hostname='.*'/hostname='$OpenWrt_NAME'/g" ./package/base-files/files/bin/config_generate
#修改默认时区
sed -i "s/timezone='.*'/timezone='CST-8'/g" ./package/base-files/files/bin/config_generate
sed -i "/timezone='.*'/a\\\t\t\set system.@system[-1].zonename='Asia/Shanghai'" ./package/base-files/files/bin/config_generate
#修改R2S leds配置
#sed -i '/r2s/{n;n;n;i \    ucidef_set_led_netdev "wlan" "WLAN" "green:wlan" "wlan0"
#}' target/linux/rockchip/armv8/base-files/etc/board.d/01_leds
#编译6.1内核
sed -i 's/5.15/6.1/g' ./target/linux/rockchip/Makefile
#加入编译作者信息
new_name="StoneOS $(date +"%Y-%m-%d")"
sed -i "s/OpenWrt /$new_name/g" package/lean/default-settings/files/zzz-default-settings
#sed -i "s/OpenWrt /StoneOS /g" package/lean/default-settings/files/zzz-default-settings
## R2S专属优化
# 关闭 eth0 offloading rx/rx
#sed -i '/set_interface_core 4 "eth1"/a\\tset_interface_core 1 "ff150000.i2c"' target/linux/rockchip/armv8/base-files/etc/hotplug.d/net/40-net-smp-affinity
#sed -i '/ff150000.i2c/a\\tset_interface_core 8 "ff160000.i2c"' target/linux/rockchip/armv8/base-files/etc/hotplug.d/net/40-net-smp-affinity
# 交换 LAN/WAN 口
#sed -i 's,"eth1" "eth0","eth0" "eth1",g' target/linux/rockchip/armv8/base-files/etc/board.d/02_network
#sed -i "s,'eth1' 'eth0','eth0' 'eth1',g" target/linux/rockchip/armv8/base-files/etc/board.d/02_network
#修改ssh登录信息
>package/base-files/files/etc/banner
echo -e '███████╗████████╗ ██████╗ ███╗   ██╗███████╗ ██████╗ ███████╗' >> package/base-files/files/etc/banner
echo -e '██╔════╝╚══██╔══╝██╔═══██╗████╗  ██║██╔════╝██╔═══██╗██╔════╝' >> package/base-files/files/etc/banner
echo -e '███████╗   ██║   ██║   ██║██╔██╗ ██║█████╗  ██║   ██║███████╗' >> package/base-files/files/etc/banner
echo -e '╚════██║   ██║   ██║   ██║██║╚██╗██║██╔══╝  ██║   ██║╚════██║' >> package/base-files/files/etc/banner
echo -e '███████║   ██║   ╚██████╔╝██║ ╚████║███████╗╚██████╔╝███████║' >> package/base-files/files/etc/banner
echo -e '╚══════╝   ╚═╝    ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ╚═════╝ ╚══════╝\n' >> package/base-files/files/etc/banner
                                                             
#根据源码来修改
if [[ $OpenWrt_URL == *"lede"* ]] ; then
  #修改默认时间格式
  sed -i 's/os.date()/os.date("%Y-%m-%d %H:%M:%S %A")/g' $(find ./package/*/autocore/files/ -type f -name "index.htm")
fi
