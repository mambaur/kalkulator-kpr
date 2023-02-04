import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kalkulator_kpr/core/currency_format.dart';
import 'package:kalkulator_kpr/models/calculate_model.dart';

enum StatusAd { initial, loaded }

class PrincipalTable extends StatefulWidget {
  final List<CalculateResultModel>? results;
  final CalculateModel? calculateModel;
  final CalculatorType? type;
  const PrincipalTable(
      {super.key, this.results, this.calculateModel, this.type});

  @override
  State<PrincipalTable> createState() => _PrincipalTableState();
}

class _PrincipalTableState extends State<PrincipalTable> {
  int month = 0;
  List<DataRow> rows = [];

  List<DataRow> setRowValue() {
    return (widget.results ?? []).map((e) {
      month++;
      return DataRow(
        cells: <DataCell>[
          DataCell(GestureDetector(
            onTap: () {},
            child: Text(
              month.toString(),
              style: const TextStyle(fontSize: 12),
            ),
          )),
          DataCell(Text(currencyId.format(e.principal))),
          DataCell(Text(currencyId.format(e.interestResult))),
          DataCell(Text(currencyId.format(e.installmentResult))),
          DataCell(Text(currencyId.format(
              e.principalTotalRemain! < 1 ? 0 : e.principalTotalRemain!))),
        ],
      );
    }).toList();
  }

  addFooter() {
    rows.add(DataRow(
      cells: <DataCell>[
        DataCell(GestureDetector(
          onTap: () {},
          child: const Text(
            "Total",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        )),
        DataCell(Text(
          currencyId.format(getTotal("principal")),
          style: const TextStyle(fontWeight: FontWeight.bold),
        )),
        DataCell(Text(currencyId.format(getTotal("interest")),
            style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text(currencyId.format(getTotal("installment")),
            style: const TextStyle(fontWeight: FontWeight.bold))),
        const DataCell(
            Text("--", style: TextStyle(fontWeight: FontWeight.bold))),
      ],
    ));
  }

  int getTotal(String type) {
    int data = 0;
    for (var i = 0; i < (widget.results ?? []).length; i++) {
      if (type == "principal") {
        data = data + widget.results![i].principal!.toInt();
      } else if (type == "interest") {
        data = data + widget.results![i].interestResult!.toInt();
      } else if (type == "installment") {
        data = data + widget.results![i].installmentResult!.toInt();
      } else if (type == "principal_remain") {
        data = data + widget.results![i].principalTotalRemain!.toInt();
      }
    }
    return data;
  }

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
    rows = setRowValue();
    addFooter();
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
        title: const Text('Tabel Angsuran'),
        centerTitle: true,
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
      ),
      body: CustomScrollView(
          // controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate([
              Container(
                width: size.width,
                margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 3,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text('Jenis'),
                          ),
                          Text(
                            widget.type == CalculatorType.flat
                                ? 'Flat'
                                : widget.type == CalculatorType.effective
                                    ? 'Efektif'
                                    : 'Anuitas',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.purple),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text('Jumlah Pinjaman'),
                          ),
                          Text(
                            "Rp. ${currencyId.format(widget.calculateModel!.loan)}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text('Jangka Waktu (Tahun)'),
                          ),
                          Text(
                            currencyId.format(widget.calculateModel!.year),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text('Bunga (%)'),
                          ),
                          Text(
                            widget.calculateModel!.interest!.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              statusAd == StatusAd.loaded
                  ? Container(
                      width: size.width,
                      margin:
                          const EdgeInsets.only(top: 15, left: 15, right: 15),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 3,
                            offset: const Offset(
                                0, 1), // changes position of shadow
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
            ])),
            SliverList(
                delegate: SliverChildListDelegate([
              Container(
                  width: size.width,
                  margin: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 4,
                        blurRadius: 3,
                        offset:
                            const Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        headingRowColor: MaterialStateColor.resolveWith(
                          (states) {
                            return Colors.purple;
                          },
                        ),
                        headingTextStyle:
                            const TextStyle(fontWeight: FontWeight.bold),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5)),
                        columns: const [
                          DataColumn(
                            label: Text(
                              'Bulan\nke',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Angsuran\nPokok',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Bunga',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                            // onSort: sortColumn,
                          ),
                          DataColumn(
                            label: Text(
                              'Jumlah\nAngsuran',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Sisa\nPinjaman',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                        rows: rows,
                      ),
                    ),
                  )),
            ])),
            SliverList(delegate: SliverChildListDelegate([])),
          ]),
    );
  }
}
