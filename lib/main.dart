import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kalkulator_kpr/about/anuitas_description.dart';
import 'package:kalkulator_kpr/about/disclaimer.dart';
import 'package:kalkulator_kpr/about/effective_description.dart';
import 'package:kalkulator_kpr/about/flat_description.dart';
import 'package:kalkulator_kpr/core/currency_format.dart';
import 'package:kalkulator_kpr/core/helpers.dart';
import 'package:kalkulator_kpr/core/loading_overlay.dart';
import 'package:kalkulator_kpr/models/calculate_model.dart';
import 'package:kalkulator_kpr/principal_table.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:upgrader/upgrader.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalkulator KPR',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: UpgradeAlert(
          upgrader: Upgrader(
              durationUntilAlertAgain: const Duration(hours: 3),
              showIgnore: false,
              showLater: false,
              canDismissDialog: false,
              showReleaseNotes: false),
          child: const MyHomePage(title: 'Kalkulator KPR')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _loanController = TextEditingController();
  final _yearController = TextEditingController();
  final _interestController = TextEditingController();

  CalculateResultModel? result;

  CalculatorType type = CalculatorType.anuitas;

  double? percentIndicator = 0;

  Future calculate() async {
    if (_formKey.currentState!.validate()) {
      percentIndicator = 0;
      setState(() {});
      // result = null;
      // setState(() {});
      LoadingOverlay.show(context);
      await Future.delayed(const Duration(seconds: 1));
      CalculateModel calculateModel = CalculateModel(
        loan: double.parse(CurrencyFormat.toNumber(_loanController.text)),
        year: double.parse(CurrencyFormat.toNumber(_yearController.text)),
        interest: double.parse(
            CurrencyFormat.toNumberComma(_interestController.text)),
      );
      if (type == CalculatorType.flat) {
        result = calculateFlat(calculateModel);
      } else if (type == CalculatorType.effective) {
        result = calculateEffective(calculateModel);
      } else {
        result = calculateAnuitas(calculateModel);
      }
      if (result != null) {
        percentIndicator = result!.principal! / result!.installmentResult!;
      }
      LoadingOverlay.hide();
      // print(result?.toJson());
      setState(() {});
    }
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Kalkulator KPR',
                      style: TextStyle(
                          color: Colors.purple,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Simulasi Kredit',
                      style: TextStyle(),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 0.5,
              ),
              ListTile(
                selected: type == CalculatorType.anuitas,
                selectedColor: Colors.purple,
                title: const Text('Bunga Anuitas'),
                onTap: () {
                  type = CalculatorType.anuitas;
                  _scaffoldKey.currentState?.openEndDrawer();
                  if (!(_loanController.text == '' ||
                      _yearController.text == '' ||
                      _interestController.text == '')) {
                    calculate();
                  } else {
                    setState(() {});
                  }
                },
              ),
              ListTile(
                selected: type == CalculatorType.effective,
                selectedColor: Colors.purple,
                title: const Text('Bunga Efektif'),
                onTap: () {
                  type = CalculatorType.effective;
                  _scaffoldKey.currentState?.openEndDrawer();
                  if (!(_loanController.text == '' ||
                      _yearController.text == '' ||
                      _interestController.text == '')) {
                    calculate();
                  } else {
                    setState(() {});
                  }
                },
              ),
              ListTile(
                selected: type == CalculatorType.flat,
                selectedColor: Colors.purple,
                title: const Text('Bunga Flat'),
                onTap: () {
                  type = CalculatorType.flat;
                  _scaffoldKey.currentState?.openEndDrawer();
                  if (!(_loanController.text == '' ||
                      _yearController.text == '' ||
                      _interestController.text == '')) {
                    calculate();
                  } else {
                    setState(() {});
                  }
                },
              ),
              const Spacer(),
              ListTile(
                title: const Text('Reset'),
                leading: const Icon(
                  Icons.refresh,
                ),
                onTap: () {
                  _scaffoldKey.currentState?.openEndDrawer();
                  setState(() {
                    result = null;
                    _interestController.text = '';
                    _yearController.text = '';
                    _loanController.text = '';
                  });
                },
              ),
              ListTile(
                title: const Text('Privacy Policy'),
                leading: const Icon(
                  Icons.gpp_maybe_outlined,
                ),
                onTap: () => _launchUrl(
                    "https://caraguna.com/privacy-policy-kalkulator-kpr-simulasi-kredit/"),
              ),
              ListTile(
                title: const Text('Versi 1.0.0'),
                leading: const Icon(
                  Icons.info_outline,
                ),
                onTap: () {},
              ),
              const SizedBox(
                height: 15,
              )
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: size.height,
              child: Column(
                children: [
                  AppBar(
                    title: Text(type == CalculatorType.flat
                        ? 'Flat'
                        : type == CalculatorType.effective
                            ? 'Efektif'
                            : 'Anuitas'),
                    centerTitle: true,
                    elevation: 0,
                    leading: IconButton(
                      onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                      icon: SizedBox(
                        width: 25,
                        height: 25,
                        child: Image.asset('assets/menu.png'),
                      ),
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (builder) {
                            if (type == CalculatorType.flat) {
                              return const FlatDescription();
                            } else if (type == CalculatorType.effective) {
                              return const EffectiveDescription();
                            } else {
                              return const AnuitasDescription();
                            }
                          }));
                        },
                        icon: SizedBox(
                          width: 25,
                          height: 25,
                          child: Image.asset('assets/question.png'),
                        ),
                      )
                    ],
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.transparent,
                  ),
                  Expanded(
                    child: Center(
                      child: CircularPercentIndicator(
                        radius: 120.0,
                        lineWidth: 13.0,
                        animation: true,
                        percent: percentIndicator ?? 0,
                        center: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Total Angsuran",
                              style: TextStyle(fontSize: 15.0),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Rp ${currencyId.format(result?.installmentResult ?? 0)}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25.0),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              type == CalculatorType.flat ||
                                      type == CalculatorType.anuitas
                                  ? "Per Bulan"
                                  : "Bulan Pertama",
                              style: const TextStyle(fontSize: 15.0),
                            ),
                          ],
                        ),
                        footer: Container(
                          margin: const EdgeInsets.only(top: 30),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 15,
                                height: 15,
                                margin: const EdgeInsets.only(right: 5),
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.purple),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Angsuran Pokok",
                                    style: TextStyle(),
                                  ),
                                  Text(
                                    "Rp ${currencyId.format(result?.principal ?? 0)}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Container(
                                width: 15,
                                height: 15,
                                margin: const EdgeInsets.only(right: 5),
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.grey),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Bunga",
                                    style: TextStyle(),
                                  ),
                                  Text(
                                    "Rp ${currencyId.format(result?.interestResult ?? 0)}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Colors.purple,
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Container(
                      // height: size.height * 0.4,
                      width: size.width,
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: const Offset(
                                  0, 1), // changes position of shadow
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(15))),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: TextFormField(
                              controller: _loanController,
                              validator: (value) {
                                if (value == '') {
                                  return "Jumlah pinjaman tidak boleh kosong";
                                }
                              },
                              inputFormatters: [
                                ThousandsFormatter(
                                    allowFraction: false,
                                    formatter:
                                        NumberFormat.decimalPattern('en'))
                              ],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                // filled: true,
                                // fillColor: Colors.blue.shade100,
                                label: const Text('Jumlah Pinjaman (Rp)'),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400),
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade400)),
                                suffixIcon: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Image.asset('assets/money.png'),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _yearController,
                                    validator: (value) {
                                      if (value == '') {
                                        return "Jangka waktu tidak boleh kosong";
                                      }
                                    },
                                    inputFormatters: [
                                      ThousandsFormatter(
                                          allowFraction: false,
                                          formatter:
                                              NumberFormat.decimalPattern('en'))
                                    ],
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      // filled: true,
                                      // fillColor: Colors.blue.shade100,
                                      label: const Text('Jangka Waktu (Tahun)'),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade400),
                                      ),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade400)),
                                      suffixIcon: const Icon(Icons.alarm,
                                          color: Colors.black54),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: _interestController,
                                    validator: (value) {
                                      if (value == '') {
                                        return "Bunga pinjaman tidak boleh kosong";
                                      }
                                    },
                                    inputFormatters: [
                                      ThousandsFormatter(
                                          allowFraction: true,
                                          formatter:
                                              NumberFormat.decimalPattern('en'))
                                    ],
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      // filled: true,
                                      // fillColor: Colors.blue.shade100,
                                      label: const Text('Bunga Pinjaman'),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade400),
                                      ),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade400)),
                                      suffixIcon: const Icon(
                                        Icons.percent,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: size.width,
                            margin: const EdgeInsets.only(top: 5),
                            child: Row(
                              children: [
                                result != null
                                    ? Expanded(
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.grey.shade300,
                                              foregroundColor: Colors.black87,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                              ),
                                            ),
                                            onPressed: () => calculate(),
                                            child: const Padding(
                                              padding: EdgeInsets.all(15.0),
                                              child: Text('Hitung Ulang'),
                                            )),
                                      )
                                    : Expanded(
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.purple,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                              ),
                                            ),
                                            onPressed: () => calculate(),
                                            child: const Padding(
                                              padding: EdgeInsets.all(15.0),
                                              child: Text('Hitung Simulasi'),
                                            )),
                                      ),
                                SizedBox(
                                  width: result != null ? 10 : 0,
                                ),
                                result != null
                                    ? Expanded(
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.purple,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                              ),
                                            ),
                                            onPressed: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                LoadingOverlay.show(context);
                                                CalculateModel calculateModel =
                                                    CalculateModel(
                                                  loanPlafon: double.parse(
                                                      CurrencyFormat.toNumber(
                                                          _loanController
                                                              .text)),
                                                  loan: double.parse(
                                                      CurrencyFormat.toNumber(
                                                          _loanController
                                                              .text)),
                                                  year: double.parse(
                                                      CurrencyFormat.toNumber(
                                                          _yearController
                                                              .text)),
                                                  interest: double.parse(
                                                      CurrencyFormat
                                                          .toNumberComma(
                                                              _interestController
                                                                  .text)),
                                                );

                                                List<CalculateResultModel>
                                                    tables =
                                                    type == CalculatorType.flat
                                                        ? installmentTableFlat(
                                                            calculateModel)
                                                        : type ==
                                                                CalculatorType
                                                                    .effective
                                                            ? installmentTableEffective(
                                                                calculateModel)
                                                            : installmentTableAnuitas(
                                                                calculateModel);
                                                await Future.delayed(
                                                    const Duration(seconds: 1));
                                                LoadingOverlay.hide();

                                                // ignore: use_build_context_synchronously
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (builder) {
                                                  return PrincipalTable(
                                                    results: tables,
                                                    type: type,
                                                    calculateModel:
                                                        CalculateModel(
                                                      loanPlafon: double.parse(
                                                          CurrencyFormat
                                                              .toNumber(
                                                                  _loanController
                                                                      .text)),
                                                      loan: double.parse(
                                                          CurrencyFormat
                                                              .toNumber(
                                                                  _loanController
                                                                      .text)),
                                                      year: double.parse(
                                                          CurrencyFormat
                                                              .toNumber(
                                                                  _yearController
                                                                      .text)),
                                                      interest: double.parse(
                                                          CurrencyFormat
                                                              .toNumberComma(
                                                                  _interestController
                                                                      .text)),
                                                    ),
                                                  );
                                                }));
                                              }
                                            },
                                            child: const Padding(
                                              padding: EdgeInsets.all(15.0),
                                              child: Text('Tabel Angsuran'),
                                            )),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
