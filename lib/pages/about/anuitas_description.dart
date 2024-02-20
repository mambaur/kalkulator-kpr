import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kalkulator_kpr/blocs/purchase_cubit/purchase_cubit.dart';
import 'package:kalkulator_kpr/pages/about/other_app.dart';

enum StatusAd { initial, loaded }

class AnuitasDescription extends StatefulWidget {
  const AnuitasDescription({super.key});

  @override
  State<AnuitasDescription> createState() => _AnuitasDescriptionState();
}

class _AnuitasDescriptionState extends State<AnuitasDescription> {
  BannerAd? myBanner;
  late PurchaseCubit _cubit;

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
    _cubit = BlocProvider.of<PurchaseCubit>(context);

    if (!kDebugMode && !_cubit.isPremium()) {
      myBanner = BannerAd(
        adUnitId: kDebugMode
            ? 'ca-app-pub-3940256099942544/6300978111'
            : 'ca-app-pub-2465007971338713/9945891754',
        size: AdSize.fullBanner,
        request: const AdRequest(),
        listener: listener(),
      );
      myBanner!.load();
    }

    super.initState();
  }

  @override
  void dispose() {
    if (myBanner != null) {
      myBanner!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anuitas'),
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
                'Bunga anuitas merupakan modifikasi dari bunga efektif dimana total cicilan per bulan jumlahnya sama. Namun, cara perhitungan bunganya akan tetap dikalkulasikan dari saldo pokok pinjaman.'),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: const Text(
                'Dalam perhitungan bunga anuitas, besaran cicilan pokok pinjaman akan meningkat, sementara besaran bunga menurun. Tujuannya ialah untuk mempermudah nasabah dalam melunasi angsuran bulanan dan tidak bingung dengan jumlah yang berubah-ubah. Berikut contohnya.'),
          ),
          SizedBox(width: size.width, child: Image.asset('assets/anuitas.png')),
          Container(
            margin: const EdgeInsets.only(bottom: 15, top: 15),
            child: const Text(
                'Hasil simulasi pada halaman utama adalah jumlah angsuran pada bulan pertama saja termasuk bunga dan pinjaman pokok.'),
          ),
          const OtherApp()
        ]),
      ),
    );
  }
}
