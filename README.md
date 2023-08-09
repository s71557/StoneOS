# OpenWrt-Build
云编译OpenWrt-R2S固件

LEDE源码：
https://github.com/coolsnowwolf/lede

# 编译简要说明：
固件信息里的时间为编译开始的时间，方便核对上游源码提交时间

自定义主题 主机名 管理地址 编译源码：.github/workflows/OpenWrt-Build.yml

自定义固件配置：Config/General.txt

自定义编译机型：Config/Rockchip.txt

自定义添加软件包：Scripts/Plugins.sh

自定义DIY脚本：Scripts/Settings.sh

固件每天24点自动编译
