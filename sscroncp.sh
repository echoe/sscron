#This installs and starts sys-snap (cPanel version), changes the interval, and sets up a cronjob.
echo "Installing cPanel sys-snap2. Please note this is not technically supported.";
su - -c "wget --no-check-certificate -N -P /root/ http://echoe.github.com/etcediting/sys-snap-cpanelperl.pl;"
chmod 744 /root/sys-snap-cpanelperl.pl;
cd /root/; yes | ./sys-snap-cpanelperl.pl --start;
echo "00 0 * * * yes | /usr/bin/perl /root/sys-snap-cpanelperl.pl --stop" > /etc/cron.d/syssnap;
echo "01 0 * * * yes | /usr/bin/perl /root/sys-snap-cpanelperl.pl --start" >> /etc/cron.d/syssnap;
echo "02 0 * * * /usr/bin/find /root/system-snapshot* -type d -mtime +14 -delete" >> /etc/cron.d/syssnap;
