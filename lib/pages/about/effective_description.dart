import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kalkulator_kpr/blocs/purchase_cubit/purchase_cubit.dart';
import 'package:kalkulator_kpr/pages/about/other_app.dart';

enum StatusAd { initial, loaded }

class EffectiveDescription extends StatefulWidget {
  const EffectiveDescription({super.key});

  @override
  State<EffectiveDescription> createState() => _EffectiveDescriptionState();
}

class _EffectiveDescriptionState extends State<EffectiveDescription> {
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
        title: const Text('Effective'),
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
                'Bunga efektif merupakan kebalikan dari bunga flat. Sistem perhitungan ini membuat angsuran semakin mengecil setiap bulannya.'),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: const Text(
                'Hal ini disebabkan karena bunga efektif menghitung besaran bunga berdasarkan sisa pokok utang atau jumlah yang belum dibayarkan. Sehingga, pembayaran bunga pun akan terus berkurang dari waktu ke waktu. Umumnya, bunga efektif digunakan pada jenis kredit jangka panjang, seperti investasi atau KPR.'),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: const Text(
                'Adapun cara menghitung bunga pinjaman per tahun dengan sistem efektif ialah sebagai berikut.'),
          ),
          SizedBox(
              width: size.width, child: Image.asset('assets/effective.png')),
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
