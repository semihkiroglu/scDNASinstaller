Shoucast2 DNAS Yükleyici
==========================

Bu kabuk betiği Shoutcast DNAS 2 güncel sürümünü Linux tabanlı sunucunuza daha hızlı ve kolay yüklemenizi sağlar.

## Desteklenen Sistemler
* Debian/Ubuntu
* CentOS/Fedora
* Raspbian

## Gereksinimler
Bu yükleyicinin başarıyla çalışması için şunlara dikkat edin:

* Internet bağlantısı olan bir sunucuda çalışmalı.
* Yükleyiciyi indirmek için sunucunuzda git kurulu olmalı. (Dokümantasyona göre)
* Yükleyici root kullanıcıda çalışmalı.
* Firewall kapalı olmalı.
* Kurulum sırasında 8000 portunu kullanan hiç bir uygulama olmamalı.


# Kurulum
### Debian/Ubuntu için

Öncelikle yükleyici ve dosyalarını indirelim:
	
	$ apt-get install -y git
	$ git clone https://github.com/semihkiroglu/scDNASinstaller.git
	
Root kullanıcıya geçelim: (Zaten root ile çalışıyorsa es geçin)
	
	$ su

Her ihtimale karşı yetkileri ayarlayalım:

	# chmod 7777 install.sh
	
Yükleyiciyi çalıştıralım:

	# ./install.sh

--------------	
### CentOS/Fedora 21 ve öncesi için

Öncelikle yükleyici ve dosyalarını indirelim:
	
	$ yum -y install git
	$ git clone https://github.com/semihkiroglu/scDNASinstaller.git
	
Root kullanıcıya geçelim: (Zaten root ile çalışıyorsa es geçin)
	
	$ su

Her ihtimale karşı yetkileri ayarlayalım:

	# chmod 7777 install.sh
	
Yükleyiciyi çalıştıralım:

	# ./install.sh

-------------------
### Fedora 22 ve sonrası için

Öncelikle yükleyici ve dosyalarını indirelim:
	
	$ dnf install git
	$ git clone https://github.com/semihkiroglu/scDNASinstaller.git
	
Root kullanıcıya geçelim: (Zaten root ile çalışıyorsa es geçin)
	
	$ su

Her ihtimale karşı yetkileri ayarlayalım:

	# chmod 7777 install.sh
	
Yükleyiciyi çalıştıralım:

	# ./install.sh

# Nasıl Çalışır?

* Kurulum paketine göre sonraki aşamalarda gereken uygulamalar yüklenir.
* DNAS kontrolünü kolaylaştırmak için yazdığım küçük başka bir betik /usr/local/bin dizinine taşınır.
* /var/ dizini içinde radio isimli bir dizin oluşturulur ve oraya geçilir.
* İşlemci mimarisine göre nullsoft sunucularından güncel DNAS paketi indirilir.
* İndirilen paket /var/radio dizini içine açılır ve asıl paket silinir.
* DNAS yapılandırması için sc_serv setup parametresi ile başlatılır ve tarayıcı üzerinde kurulumu tamamlamanızı bekler.
* İsterseniz sunucu başlatıldığında DNAS'ın otomatik çalışması için gereken satırı nasıl ekleyeceğinizi tarif eder.
* İsterseniz root giriş yaptığında DNAS'ı otomatik başlatacak satır ~/.bashrc dosyasına eklenir.
* Kurulum sonlanır.

# Yaşanabilecek Sorunlar
================

Öncelikle: Bu benim hem ilk kabul betiği deneyimim, hem de ilk açık kaynak deneyimim. Biraz tecrübesizce davranmış olabilirim. Betik herhangi bir hata ile karşılaşsa bile bunu size bildirecek kabiliyette değil. Şayet gereksinimler kısmında yazdıklarımı yaparsanız sorunsuz bir yükleme olacağı inancındayım.
Yaşanabilme ihtimali olan bir kaç şey:

* Kurulum sonrasında /var/radio dizinini bulamıyorum/boş görüyorum.

	* root erişiminiz yok.
	* Yanlış bir paket yöneticisi seçildi ve öncesinde ilgili uygulamalar sunucuda yüklü değildi.
	
* Yapılandırma sırasında ilgili ekrana ulaşamıyorum.

	* Sunucu internete bağlı değil.
	* root erişiminiz yok.
	* Firewall kapalı değil veya 8000 portuna izin verilmemiş.
	* Başka bir uygulama 8000 portunu kullanıyor.
	* Zaten bir DNAS kopyası çalışıyor.
	
* Giriş yaptığımda DNAS'ı başlatmasını istedim fakat başlatmıyor.

	DNAS, root giriş yaptıktan sonra 1-2 satırlık bir bilgi mesajıyla çalışmaya başladığını söyler veya hata döndürür. Herhangi bir mesaj gelmiyorsa:
	
	* root kullanıcı ile giriş yapmadınız.
	* Yüklemeyi root ile yapmadınız ve yüklemeyi yapan kullanıcı hesabına ilgili satır işlendi.
	
* radio komutu çalışmıyor.

	Bu betik de yeni yazdığım bir betik ve hatalar olması muhtemeldir.
	
	* Eğer radio komutunu çağırdığınızda, komut bulunamadı hatası alıyorsanız:
	
		* /usr/local/bin/ dizinine göz atın ve radio dosyasını arayın. Bulamazsanız proje içinden indirip kendiniz kopyalayın.
		
	* Eğer komut var fakat çalışmıyorsa:
	
		* Durumu bana bildirin. Eğer çözüm yolu hakkında fikriniz varsa bunu da bildirmenizden hoşnut olacağım.
		
* Sunucu çalışıyor gibi görünse de çalışmıyor.

	* /var/radio/ dizinine gidin ve aşağıdaki gibi sunucuyu tekrar başlatmaya çalışın. Log'lar görüntülenecektir. Eğer log'larda hata yoksa durumu bana bildirin lütfen.

		$ ./sc_serv start

# "radio" Komutunun Kullanımı
================

	Çok küçük bir yapıdır ve kullanımı çok kolaydır. Kısmen DNAS'ın kendine özgü parametrelerini taklit eder ve DNAS ile kısa yoldan haberleşmeyi sağlar.
	Kullanımı: radio start|start_daemon|stop|status

	### start
	
		*  DNAS'ı foreground (ön planda) başlatmayı sağlar. Ekranda çıktılar bulundurur ve bazen durdurulmadığı sürece ilgili terminal sürecini kilitler.

	### start_daemon

		* DNAS'ı background (arka planda) başlatmayı sağlar. Ekranda çıktı bulundurmaz. Terminali kullanmaya devam edersiniz.

	### stop
		
		* DNAS'a ait tüm process'leri durdurur.

	### status

		* Çalışan bir DNAS varsa PID değerini ve çalışıyor bilgisini döndürür, yoksa çalışmadığı bilgisini döndürür.


# Kaldırma
================

Bu proje yüzünden bunu düşünmenizi istemem fakat kaldırma için henüz bir girişimim olmadı. Aşağıdaki komutları sırayla uygulamanız halinde Shoutcast DNAS sisteminizden sorunsuz biçimde kaldırılacaktır.
ÖNEMLİ: root erişiminiz olmalı!

	# radio stop
	# rm /usr/local/bin/radio
	# rm -rf /var/radio/


# Lisans
================

Henüz doğru lisans türünü belirleyemedim. Fakat bu süre içerisinde kaynak kodlar değiştirilerek tekrar yayınlanması hoş değildir. Eğer böyle bir şey yapacaksanız ismimi silmeden yapmanızı rica ederim. Hatta mümkünse bana bildirmenizi de rica ederim.
Yakın zamanda burayı güncellemek dileğiyle :)


# Hakkımda
================
Merhaba, ben Semih Kıroğlu. İstanbul Sabahattin Zaim Üniversitesi Bilgisayar Mühendisliği öğrencisiyim ve Bilişim Kulübü Yönetim Kurulu Başkanlığı görevimi sürdürüyorum.

Hakkımda daha detaylı bilgiye aşağıdaki linkten ulaşabilirsiniz (yakında).
Veya beni Google'lamanız hakkımda daha hızlı bilgiye ulaşmanızı sağlayabilir.
<a href="https://semih.kiroglu.net">https://semih.kiroglu.net</a> (bu link ismim ile soy ismim arasına @ işareti eklendiğinde bir e-posta adresine dönüşebilir, tabii protokolü mailto yaparsanız :))


Denediğiniz ve geri bildirimde bulunduğunuz için teşekkür ederim.
