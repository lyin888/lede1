#!/bin/sh

rm -f /tmp/dnsmasq.adblock

wget-ssl --no-check-certificate -O- https://easylist-downloads.adblockplus.org/easylistchina+easylist.txt | grep ^\|\|[^\*]*\^$ | sed -e 's:||:address\=\/:' -e 's:\^:/0\.0\.0\.0:' >>  /tmp/dnsmasq.adblock
wget-ssl --no-check-certificate -O- http://tools.yiclear.com/ChinaList2.0.txt | grep ^||[^*]*^$ | sed -e 's:||:address=/:' -e 's:^:/0.0.0.0:' >>  /tmp/dnsmasq.adblock
wget-ssl --no-check-certificate -O- https://easylist.to/easylist/easylist.txt | grep ^||[^*]*^$ | sed -e 's:||:address=/:' -e 's:^:/0.0.0.0:' >>  /tmp/dnsmasq.adblock
wget-ssl --no-check-certificate -O- https://raw.githubusercontent.com/xinggsf/Adblock-Plus-Rule/master/ABP-FX.txt | grep ^||[^*]*^$ | sed -e 's:||:address=/:' -e 's:^:/0.0.0.0:' >>  /tmp/dnsmasq.adblock
wget-ssl --no-check-certificate -O- https://raw.githubusercontent.com/yous/YousList/master/youslist.txt | grep ^\|\|[^\*]*\^$ | sed -e 's:||:address\=\/:' -e 's:\^:/0\.0\.0\.0:' >>  /tmp/dnsmasq.adblock

if ( ! cmp -s /tmp/dnsmasq.adblock /usr/share/adbyby/dnsmasq.adblock );then
	if [ -s "/tmp/dnsmasq.adblock" ];then
	sed -i '/youku.com/d' /tmp/dnsmasq.adblock
	mv /tmp/dnsmasq.adblock /usr/share/adbyby/dnsmasq.adblock
	echo "Update adblock Done!"
else
	echo "adblock No Change!"
	fi
fi

sh /usr/share/adbyby/adupdate.sh
