ipmitool -I lanplus -H idrac-pluto -U root -P calvin raw 0x30 0x30 0x01 0x00
ipmitool -I lanplus -H idrac-pluto -U root -P calvin raw 0x30 0x30 0x02 0xff 0xA

ipmitool -I lanplus -H idrac-neptune -U root -P calvin raw 0x30 0x30 0x01 0x00
ipmitool -I lanplus -H idrac-neptune -U root -P calvin raw 0x30 0x30 0x02 0xff 0xA

#bash -c "$(wget -qLO - https://raw.githubusercontent.com/NathanWarrick/Boilerplates/main/cron/ipmi-fans-low.sh)"