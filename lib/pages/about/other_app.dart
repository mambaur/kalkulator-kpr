import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OtherAppItem extends StatelessWidget {
  final String imageUrl, title;
  final Function() onTap;
  const OtherAppItem({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          margin: const EdgeInsets.only(right: 15),
          child: Column(
            children: [
              Container(
                // height: 100,
                // width: 100,
                // padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.07),
                    spreadRadius: 1,
                    blurRadius: 12,
                    offset: const Offset(1, 1),
                  )
                ], borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.only(bottom: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.fill,
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
              Text(title)
            ],
          )),
    );
  }
}

class OtherApp extends StatelessWidget {
  const OtherApp({super.key});

  Future<void> _launchUrl(String url) async {
    Uri urlParse = Uri.parse(url);
    if (!await launchUrl(urlParse, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $urlParse';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      width: size.width,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Aplikasi lainnya',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.8)),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _launchUrl(
                    "https://play.google.com/store/apps/dev?id=8918426189046119136"),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Selengkapnya',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 160,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics()),
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(15),
            shrinkWrap: true,
            children: [
              OtherAppItem(
                title: 'Ongkirku',
                imageUrl:
                    "https://play-lh.googleusercontent.com/r0TGGj1JpfmsdygWZWSm6Qbe5UwVJV-GqL8x74rHoj_m0kdMa83qhcBfceVvY0y4iwQ=w240-h480-rw",
                onTap: () => _launchUrl(
                    'https://play.google.com/store/apps/details?id=com.caraguna.ongkirku'),
              ),
              OtherAppItem(
                title: "Arisan Digital",
                imageUrl:
                    "https://play-lh.googleusercontent.com/Zxrskjm49N09lhxM4uu53hdsuF-Gjec9v80jW_TlS7QU-wEta1hoEUGDxjk--iVHlAY=w240-h480-rw",
                onTap: () => _launchUrl(
                    'https://play.google.com/store/apps/details?id=com.caraguna.arisan.digital'),
              ),
              OtherAppItem(
                title: "Template Surat",
                imageUrl:
                    "https://play-lh.googleusercontent.com/fwIlO68FjQVikZC5U7vD-mhbYk2MdNbXrd-OEJ0spfowRYfmb_G7QFtz9aW8YzC07RQu=w240-h480-rw",
                onTap: () => _launchUrl(
                    'https://play.google.com/store/apps/details?id=com.caraguna.terator'),
              ),
              OtherAppItem(
                title: "Konversi Satuan",
                imageUrl:
                    "https://play-lh.googleusercontent.com/8lR9ozrqyfEZx3lLAffljIGsOH8HDrSXO8mQRQahlnp1A_K8N6VkaZq9Pa-spH3G1Q=w240-h480-rw",
                onTap: () => _launchUrl(
                    'https://play.google.com/store/apps/details?id=com.caraguna.konversi_satuan'),
              ),
              OtherAppItem(
                title: "Dompet Saku",
                imageUrl:
                    "https://play-lh.googleusercontent.com/pdRjo3hfVkztagBsmzewl8pwu4rgMUDa6hLE0_g2-1S4TaS7YJ2f8L_II_BWAJLlEg0=w240-h480-rw",
                onTap: () => _launchUrl(
                    'https://play.google.com/store/apps/details?id=com.caraguna.dompet_apps'),
              ),
              OtherAppItem(
                title: "URL Shortener",
                imageUrl:
                    "https://play-lh.googleusercontent.com/G7aSJ783R-A12E7Sm2V4bHZwMYRvJp4LdhsGjuthrH9m3EUeZWf52E1Sc5G0hVisxw=w240-h480-rw",
                onTap: () => _launchUrl(
                    'https://play.google.com/store/apps/details?id=com.caraguna.url_shortener'),
              ),
              OtherAppItem(
                title: "Signature",
                imageUrl:
                    "https://play-lh.googleusercontent.com/F7RqL77RhfxdY28PqWN1JM8jdF4T_d_DLc1cOgN0o82yxc0LsTbibN_AOYDZyHW6sA=w240-h480-rw",
                onTap: () => _launchUrl(
                    'https://play.google.com/store/apps/details?id=com.caraguna.signature'),
              ),
              OtherAppItem(
                title: "Kamus Hukum",
                imageUrl:
                    "https://play-lh.googleusercontent.com/v5dQLeUMcRdO1swe18cWCaFTR1mWdDUaGduSzUVshRUVUZ6igG0ml3UnMWg76q1tfZ4=w240-h480-rw",
                onTap: () => _launchUrl(
                    'https://play.google.com/store/apps/details?id=com.caraguna.kamus.hukum'),
              ),
              OtherAppItem(
                title: "Kamus Trading",
                imageUrl:
                    "https://play-lh.googleusercontent.com/9JKOJumqVwoZZhaBPlQQPp1TFevWxaGJNZhx5Tb4DoVUeDpD1G2OeOjo_gnzKKM5s7c=w240-h480-rw",
                onTap: () => _launchUrl(
                    'https://play.google.com/store/apps/details?id=com.caraguna.kamus.trading'),
              ),
              OtherAppItem(
                title: "Phonespec",
                imageUrl:
                    "https://play-lh.googleusercontent.com/l9-VnwjG467ySNDHHVGJknBmIAEsY9L8yHO0HVNfrf9O60JjwrSUda0DF9XJy5sGtw=w240-h480-rw",
                onTap: () => _launchUrl(
                    'https://play.google.com/store/apps/details?id=com.caraguna.phonespec'),
              ),
              OtherAppItem(
                title: "Resep Masakan",
                imageUrl:
                    "https://play-lh.googleusercontent.com/Xta_ifkMOxRgmscMBYUCLNLIy8_rekOxLvb9V94xm1zJIwfYnhsBWfIJXpskBBiAKg=w240-h480-rw",
                onTap: () => _launchUrl(
                    'https://play.google.com/store/apps/details?id=com.caraguna.recipe_apps'),
              ),
              OtherAppItem(
                title: "Al Quran",
                imageUrl:
                    "https://play-lh.googleusercontent.com/a7xq8dWnNuAP9HYW7zHGS-_u4tUKDLnogOuFE5HOfsu8aJK1oW8CGVge1xMPsrCCzCU=w240-h480-rw",
                onTap: () => _launchUrl(
                    'https://play.google.com/store/apps/details?id=com.caraguna.alquran_app'),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
