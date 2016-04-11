#!/bin/bash
echo "Shoutcast2 DNAS Yukleyici"
echo "  Semih Kiroglu tarafindan olusturuldu"
echo "  semih.kiroglu.net ~ semih@kiroglu.net"
echo ""
echo "  Lutfen kurulum boyunca firewall unuzu devre disi birakin!"
echo "  root kullanici uzerinde calismaniz gereklidir!"

echo ""
echo "Hangi paket yoneticisini kullaniyorsunuz?"
select sel1 in "apt-get" "yum" "dnf" "Vazgec"; do
case $sel1 in
	apt-get ) 
		echo ""
		apt-get install -y wget tar &> /dev/null
		break
	;;
	yum ) 
		echo ""
		yum -y install wget tar
		break
	;;
	dnf ) 
		echo ""
		dnf -y install wget tar
		break
	;;
	Vazgec ) exit;;
esac
done

{
	mv radio /usr/local/bin/radio
	chmod +x /usr/local/bin/radio
	mkdir /var/radio/
	cd /var/radio/
} &> /dev/null

echo ""
echo "Hangi mimariyi kullaniyorsunuz?"
select sel2 in "x86" "x64" "ARMv6" "Vazgec"; do
case $sel2 in
	x86 ) 
	{	
		wget http://download.nullsoft.com/shoutcast/tools/sc_serv2_linux-latest.tar.gz
		tar xfz sc_serv2_linux-latest.tar.gz
		rm sc_serv2_linux-latest.tar.gz
	} &> /dev/null
		break
	;;
	x64 ) 
	{
		wget http://download.nullsoft.com/shoutcast/tools/sc_serv2_linux_x64-latest.tar.gz
		tar xfz sc_serv2_linux_x64-latest.tar.gz
		rm sc_serv2_linux_x64-latest.tar.gz
	} &> /dev/null
		break
	;;
	ARMv6 )
	{ 
		wget http://download.nullsoft.com/shoutcast/tools/sc_serv2_armv6_rpi-latest.tar.gz
		tar xfz sc_serv2_armv6_rpi-latest.tar.gz
		rm sc_serv2_armv6_rpi-latest.tar.gz
	} &> /dev/null
		break
	;;
	Vazgec ) exit;;
esac
done
echo ""	
echo "Yapilandirma icin web tarayicisini kullanin:"
echo "http://sunucu-ip-adresi:8000/"
echo "Eger bir alt satir yoksa yapilandirma tamamlandiginda Ctrl+C tus kombinasyonunu kullanarak devam edin."
chmod +x sc_serv
nohup ./sc_serv setup &> /dev/null
echo ""
read -p "Yapilandirma tamamlandiginda [Enter] tusuna basin..."
echo ""
echo "Eger sistem baslatildiginda DNAS'in calismasini istiyorsaniz"
echo "/etc/rc.local dosyasina"
echo "exit 0 komutundan once"
echo "radio start_daemon komutunu ekleyin"
echo ""
echo "Kullanici girisi ile DNAS baslatilsin mi? (Yukarida anlatilandan farklidir!)"
echo "(Stabil olmayabilir!)"
select sel3 in "Evet" "Hayir"; do
case $sel3 in
	Evet ) 
	{
		echo "radio start_daemon" >> ~/.bashrc
	} &> /dev/null
		break
	;;
	Hayir ) 
		break
	;;
esac
done
echo ""
echo "Tebrikler! Kurulum tamamlandi."
echo "ONEMLI: Firewall ayarlarinizi sectiginiz porta gore yapilandirmayi ve baslatmayi unutmayin!"
echo "Sistemi yeniden baslatmanizi oneririm."
echo ""
echo "Kullaniminiz icin tesekkurler!"
echo "Semih Kiroglu"
echo ""
