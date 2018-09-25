#!/bin/sh

rm -f /tmp/dnsmasq.adblock

wget-ssl --no-check-certificate -O- https://easylist-downloads.adblockplus.org/easylistchina+easylist.txt | grep ^\|\|[^\*]*\^$ | sed -e 's:||:address\=\/:' -e 's:\^:/0\.0\.0\.0:' > /tmp/dnsmasq.adblock
wget-ssl --no-check-certificate -O- http://tools.yiclear.com/ChinaList2.0.txt | grep ^||[^*]*^$ | sed -e 's:||:address=/:' -e 's:^:/0.0.0.0:' > /tmp/dnsmasq.adblock
wget-ssl --no-check-certificate -O- https://easylist.to/easylist/easylist.txt | grep ^||[^*]*^$ | sed -e 's:||:address=/:' -e 's:^:/0.0.0.0:' >> /tmp/dnsmasq.adblock
wget-ssl --no-check-certificate -O- https://raw.githubusercontent.com/xinggsf/Adblock-Plus-Rule/master/ABP-FX.txt | grep ^||[^*]*^$ | sed -e 's:||:address=/:' -e 's:^:/0.0.0.0:' >> /tmp/dnsmasq.adblock
if [ -s "/tmp/dnsmasq.adblock" ];then
	sed -i '/youku.com/d' /tmp/dnsmasq.adblock
	mv /tmp/dnsmasq.adblock /usr/share/adbyby/dnsmasq.adblock	
fi

sh /usr/share/adbyby/adupdate.sh




