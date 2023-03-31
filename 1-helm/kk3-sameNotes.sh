## Packaging and Signing Charts ## 
- Once chartlari package haline getirip sonra da online chart repolarina atabiliriz. 
- Diger kullanicilarda buralardan hazir chartlari indirebiliriz. 

# $ helm package ./nginx-chart
- .tgz formatinda dosya verir. 
- Chart.yaml dosyasinda versiyon numarasi ne yaziyorsa onu geri dondurur. 
- tar gx formatinda zipli dosya verir. 

- Internetten indirilen chartlarin hepsi guvenilir olmayabilir. Garantisi yoktur. 

- helm gelistirici public ve private keylere sahiplerdir. Bu dosyalarla beraber helmChartlarini imzali hale getirebilirler. 
(provenance file)

# $ gpg --quick-generate-key "John Smith"
- Public ve provate key olusturmamizi saglar. 

# gpg --full-generate-key "John Smith"
- Daha detayli sekilde key olusturur. 

# $ gpg --export-secret-keys >~/.gnupg/secring.gpg
- gpg formatinda key export etmemizo saglar. 
Yukaridaki adimlarla key olusturma islemi tamamlandi. 

# $ gpg --list-keys
- Olusturulan keyleri listeler. 

# $ helm package --sign --key 'John Smith' --keyring ~/.gnupg/secring.gpg ./nginx-chart
- Olusturulan keye gore olusturulan charti imzalama islemi yapar. 
- Bu komut sonucunda .tagz formatindan farkli olarak nginx-chart-0.1.0.tgz.prov seklinde bir dosya olusur.

# $ sha256sum nginx-chart-0.1.0.tgz 
- Dosyanin gercekten hash ile uyusup uysumadiginin kontorolunu saglar. 

# $ helm verify ./nginx-chart-0.1.0.tgz
- Imzali dosyanin verify edilmesini saglar. HATA ALABILIRSIN!! Public key vermekte gerekebilir. 

# $ gpg --export 'John Smith' > mypublickey
- Public key export etmek icin kullanilir. 

# $ helm verify --keyring ./mypublickey ./nginx-0.1.0.tgz
- Public key vererek verify etmekte yarar olabilir. 
Signed by: John Smith
Using Key With Fingerprint: 20F2395A3176A22DD33DA45470D5188339885A0B
Chart Hash Verified: sha256:b7d05022a9617ab953a3246bc7ba6a9de9d4286b2e78e3ea7975cc54698c4274

# $ gpg --recv-keys --keyserver keyserver.ubuntu.com 8D40FE0CACC3FED4AD1C217180BA57AAFAAD1CA5
- Sanirim public key ubuntu server yukleme islemini yapiyor. Public sekilde dogrulama yapabilecek hala getiriyor. 

# $ helm install --verify nginx-chart-0.1.0
- verify islemi yaparak install islemi gerceklesitrir. 

-------------------------------------------------
## Uploading Charts ## 
- Artik elimizde imzali paketlerimiz mevcut. 
- daha onceki bolumde olusturdugumuz .tgz uzantili ve .tgz.prov uzantili dosyalardan yararlanarak index.yaml dosyasini uretmek gerekir. 
Bu dosya olmadan public ortama chartimizi gonderemeyiz. 

$ ls
nginx-chart nginx-chart-0.1.0.tgz nginx-chart-0.1.0.tgz.prov
$ mkdir nginx-chart-files
$ cp nginx-chart-0.1.0.tgz nginx-chart-0.1.0.tgz.provn ginx-chart-files/
# $ helm repo index nginx-chart-files/ --url https://example.com/charts
$ ls nginx-chart-files
index.yaml nginx-chart-0.1.0.tgz nginx-chart-0.1.0.tgz.prov

- index.yaml dosyasinda olsuturulan chartla alakli bir cok bilgi yer almaktadir. 
helm dosyalarindaki Chart.yaml gibi dusunebilir. 

# $ helm repo add our-cool-charts https://example-charts.storage.googleapis.com 
- Artik dosyamizi public chart repoya gonderdik. Lokalimize cekerek kullanim gerceklestirebiliriz. 