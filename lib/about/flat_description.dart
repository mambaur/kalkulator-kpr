import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kalkulator_kpr/about/other_app.dart';

enum StatusAd { initial, loaded }

class FlatDescription extends StatefulWidget {
  const FlatDescription({super.key});

  @override
  State<FlatDescription> createState() => _FlatDescriptionState();
}

class _FlatDescriptionState extends State<FlatDescription> {
  BannerAd? myBanner;

  StatusAd statusAd = StatusAd.initial;

  BannerAdListener listener() => BannerAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            statusAd = StatusAd.loaded;
          });
        },
      );

  @override
  void initState() {
    myBanner = BannerAd(
      adUnitId: kDebugMode
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-2465007971338713/9945891754',
      size: AdSize.fullBanner,
      request: const AdRequest(),
      listener: listener(),
    );
    myBanner!.load();
    super.initState();
  }

  @override
  void dispose() {
    myBanner!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flat'),
        centerTitle: true,
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(children: [
          statusAd == StatusAd.loaded
              ? Container(
                  width: size.width,
                  margin: const EdgeInsets.only(bottom: 15),
                  // padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 3,
                        offset:
                            const Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    width: myBanner!.size.width.toDouble(),
                    height: myBanner!.size.height.toDouble(),
                    child: AdWidget(ad: myBanner!),
                  ),
                )
              : const SizedBox(),
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: const Text(
                'Bunga flat adalah sistem perhitungan suku bunga dengan mengacu pada besaran pokok awal pinjaman. Umumnya, jenis perhitungan ini digunakan pada kredit konsumtif, seperti KTA, mobil, handphone, dan lain sebagainya.'),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: const Text(
                'Bunga flat juga termasuk cara menghitung bunga pinjaman di bank paling mudah dibandingkan lainnya. Sebab, besaran nilai bunga dan pokok dalam cicilan bulanan akan tetap sama dan tidak berubah.'),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: const Text(
                'Adapun cara menghitung bunga pinjaman per bulan menggunakan sistem flat ialah sebagai berikut.'),
          ),
          SizedBox(width: size.width, child: Image.asset('assets/flat.png')),
          const SizedBox(
            height: 15,
          ),
          const OtherApp()
        ]),
      ),
    );
  }
}
