#This installs and starts sys-snap2, changes the interval, and sets up a cronjob.
#Version 0.09 (centos 5 is not supported)
if [[ `cat /etc/redhat-release | cut -d" " -f3 | cut -d "." -f1` == "5" ]]; then 
    echo "This does not support CentOS5. If you want, you can try bash <(curl http://github.com/echoe/edit/sscroncp.sh)"
    exit 1; 
fi

if [[ ! -e /root/sys-snap.pl ]] ; then
	su - -c "wget --no-check-certificate -N -P /root https://raw.githubusercontent.com/cPanelTechs/SysSnapv2/master/sys-snap.pl;"
	sed -i s/"'interval'      => 10,"/"'interval'      => 1,"/g /root/sys-snap.pl;
	chmod 744 /root/sys-snap.pl;
	cd /root/; yes | ./sys-snap.pl --start;
fi

if [[ ! -e /etc/cron.d/syssnap ]]; then
    echo "00 0 * * * yes | /usr/bin/perl /root/sys-snap.pl --stop" > /etc/cron.d/syssnap;
    echo "01 0 * * * yes | /usr/bin/perl /root/sys-snap.pl --start" >> /etc/cron.d/syssnap;
    echo "02 0 * * * /usr/bin/find /root/system-snapshot* -type d -mtime +14 -delete" >> /etc/cron.d/syssnap;
fi
