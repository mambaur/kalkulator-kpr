// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

import '../../core/currency_format.dart';
import '../../core/helpers.dart';
import '../../core/loading_overlay.dart';
import '../../models/calculate_model.dart';
import '../principle/principal_table.dart';

class FixAndFloatingScreen extends StatefulWidget {
  const FixAndFloatingScreen({super.key});

  @override
  State<FixAndFloatingScreen> createState() => _FixAndFloatingScreenState();
}

class _FixAndFloatingScreenState extends State<FixAndFloatingScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _loanController = TextEditingController();
  final _loanTotalController = TextEditingController();
  final _dpPercentController = TextEditingController();
  final _dpNominalController = TextEditingController();
  final _yearController = TextEditingController();
  final _interestController = TextEditingController();
  double fixInterestRateValue = 4;
  double fixedCreditPeriod = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      controller: _loanController,
                      validator: (value) {
                        if (value == '') {
                          return "Jumlah pinjaman tidak boleh kosong";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        double dpPercent = 0;
                        double dpNominal = 0;
                        if (_dpPercentController.text.isNotEmpty) {
                          dpPercent = double.tryParse(_dpPercentController.text
                                  .replaceAll(",", "")) ??
                              0;
                          dpNominal = (double.tryParse(_loanController.text
                                      .replaceAll(",", "")) ??
                                  0) *
                              (dpPercent / 100);
                          _dpNominalController.text =
                              NumberFormat.decimalPattern('en')
                                  .format(dpNominal.toInt());
                        } else {
                          _dpPercentController.text = '';
                          _dpNominalController.text = '';
                        }

                        double loanNominal = double.tryParse(
                                _loanController.text.replaceAll(",", "")) ??
                            0;

                        if (loanNominal > 0) {
                          _loanTotalController.text =
                              NumberFormat.decimalPattern('en')
                                  .format((loanNominal - dpNominal).toInt());
                        } else {
                          _loanTotalController.text = '0';
                        }
                      },
                      inputFormatters: [
                        ThousandsFormatter(
                            allowFraction: false,
                            formatter: NumberFormat.decimalPattern('en'))
                      ],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        // filled: true,
                        // fillColor: Colors.blue.shade100,
                        label: const Text('Jumlah Pinjaman (Rp)'),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.shade400)),
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
                          flex: 2,
                          child: TextFormField(
                            controller: _dpPercentController,
                            inputFormatters: [
                              ThousandsFormatter(
                                  allowFraction: true,
                                  formatter: NumberFormat.decimalPattern('en'))
                            ],
                            onChanged: (value) {
                              double dpPercent =
                                  double.tryParse(value.replaceAll(",", "")) ??
                                      0;
                              if (dpPercent > 100) {
                                dpPercent = 100;
                                _dpPercentController.text = '100';
                              }

                              double dpNominal = 0;
                              if (_loanController.text.isNotEmpty) {
                                dpNominal = (double.tryParse(_loanController
                                            .text
                                            .replaceAll(",", "")) ??
                                        0) *
                                    (dpPercent / 100);
                                _dpNominalController.text =
                                    NumberFormat.decimalPattern('en')
                                        .format(dpNominal.toInt());
                              } else {
                                _dpNominalController.text = '';
                              }

                              double loanNominal = double.tryParse(
                                      _loanController.text
                                          .replaceAll(",", "")) ??
                                  0;

                              if (loanNominal > 0) {
                                _loanTotalController.text =
                                    NumberFormat.decimalPattern('en').format(
                                        (loanNominal - dpNominal).toInt());
                              } else {
                                _loanTotalController.text = '0';
                              }
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              // filled: true,
                              // fillColor: Colors.blue.shade100,
                              label: const Text('DP'),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400),
                              ),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400)),
                              suffixIcon: const Icon(
                                Icons.percent,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            controller: _dpNominalController,
                            inputFormatters: [
                              ThousandsFormatter(
                                  allowFraction: true,
                                  formatter: NumberFormat.decimalPattern('en'))
                            ],
                            onChanged: (value) {
                              double dpNominal =
                                  double.tryParse(value.replaceAll(",", "")) ??
                                      0;
                              if (dpNominal < 0) {
                                dpNominal = 0;
                                _dpNominalController.text = '0';
                              }

                              double dpPercent = 0;
                              if (_loanController.text.isNotEmpty) {
                                dpPercent = (dpNominal /
                                        (double.tryParse(_loanController.text
                                                .replaceAll(",", "")) ??
                                            1)) *
                                    100;
                                _dpPercentController.text =
                                    NumberFormat.decimalPattern('en')
                                        .format(dpPercent);
                              } else {
                                _dpPercentController.text = '';
                              }

                              double loanNominal = double.tryParse(
                                      _loanController.text
                                          .replaceAll(",", "")) ??
                                  0;

                              if (loanNominal > 0) {
                                _loanTotalController.text =
                                    NumberFormat.decimalPattern('en').format(
                                        (loanNominal - dpNominal).toInt());
                              } else {
                                _loanTotalController.text = '0';
                              }
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              // filled: true,
                              // fillColor: Colors.blue.shade100,
                              label: const Text('DP (RP)'),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400),
                              ),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      controller: _loanTotalController,
                      onChanged: (value) {},
                      readOnly: true,
                      inputFormatters: [
                        ThousandsFormatter(
                            allowFraction: false,
                            formatter: NumberFormat.decimalPattern('en'))
                      ],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        // filled: true,
                        // fillColor: Colors.blue.shade100,
                        label: const Text('Total Pinjaman (Rp)'),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.shade400)),
                        suffixIcon: SizedBox(
                          width: 20,
                          height: 20,
                          child: Image.asset('assets/money.png'),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      bottom: 10,
                    ),
                    child: TextFormField(
                      controller: _yearController,
                      validator: (value) {
                        if (value == '') {
                          return "Jangka waktu tidak boleh kosong";
                        }
                        return null;
                      },
                      inputFormatters: [
                        ThousandsFormatter(
                            allowFraction: false,
                            formatter: NumberFormat.decimalPattern('en'))
                      ],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        // filled: true,
                        // fillColor: Colors.blue.shade100,
                        label: const Text('Jangka Waktu (Tahun)'),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.shade400)),
                        suffixIcon:
                            const Icon(Icons.alarm, color: Colors.black54),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 12, top: 24),
                    child: Text(
                      'Bunga Fix',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      'Suku Bunga Fix',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                  StatefulBuilder(builder: (context, setState) {
                    return Column(
                      children: [
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            tickMarkShape: SliderTickMarkShape.noTickMark,
                          ),
                          child: Slider(
                            activeColor: Colors.purple,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            value: fixInterestRateValue,
                            divisions: 20,
                            min: 1,
                            max: 20,
                            onChanged: (double value) {
                              setState(() {
                                fixInterestRateValue = value;
                              });
                            },
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '${fixInterestRateValue.toInt()} %',
                              style: TextStyle(fontSize: 16),
                            ),
                            const Spacer(),
                            Text(
                              '20 %',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Divider(),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      'Masa Kredit Fix',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                  StatefulBuilder(builder: (context, setState) {
                    return Column(
                      children: [
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            tickMarkShape: SliderTickMarkShape.noTickMark,
                          ),
                          child: Slider(
                            activeColor: Colors.purple,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            value: fixedCreditPeriod,
                            divisions: 15,
                            min: 1,
                            max: 15,
                            onChanged: (double value) {
                              setState(() {
                                fixedCreditPeriod = value;
                              });
                            },
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '${fixedCreditPeriod.toInt()} Tahun',
                              style: TextStyle(fontSize: 16),
                            ),
                            const Spacer(),
                            Text(
                              '15 Tahun',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
                  Container(
                    padding: const EdgeInsets.only(bottom: 12, top: 32),
                    child: Text(
                      'Bunga Floating',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      controller: _interestController,
                      validator: (value) {
                        if (value == '') {
                          return "Bunga pinjaman tidak boleh kosong";
                        }
                        return null;
                      },
                      inputFormatters: [
                        ThousandsFormatter(
                            allowFraction: true,
                            formatter: NumberFormat.decimalPattern('en'))
                      ],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        // filled: true,
                        // fillColor: Colors.blue.shade100,
                        label: const Text('Bunga Pinjaman'),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.shade400)),
                        suffixIcon: const Icon(
                          Icons.percent,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                    style:
                        FilledButton.styleFrom(backgroundColor: Colors.purple),
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }

                      LoadingOverlay.show(context);
                      CalculateModel calculateModel = CalculateModel(
                        fixInterest: fixInterestRateValue.floorToDouble(),
                        fixYear: fixedCreditPeriod.floorToDouble(),
                        floatingInterest: double.parse(
                          CurrencyFormat.toNumberComma(
                            _interestController.text,
                          ),
                        ),
                        loanPlafon: double.parse(
                            CurrencyFormat.toNumber(_loanTotalController.text)),
                        loan: double.parse(
                            CurrencyFormat.toNumber(_loanTotalController.text)),
                        year: double.parse(
                            CurrencyFormat.toNumber(_yearController.text)),
                        interest: double.parse(
                          CurrencyFormat.toNumberComma(
                            _interestController.text,
                          ),
                        ),
                      );

                      List<CalculateResultModel> tables =
                          installmentTableAnuitasFixFloating(calculateModel);

                      await Future.delayed(const Duration(seconds: 1));
                      LoadingOverlay.hide();

                      Navigator.push(context,
                          MaterialPageRoute(builder: (builder) {
                        return PrincipalTable(
                          results: tables,
                          type: CalculatorType.anuitas,
                          calculateModel: CalculateModel(
                            fixInterest: fixInterestRateValue.floorToDouble(),
                            fixYear: fixedCreditPeriod.floorToDouble(),
                            floatingInterest: double.parse(
                              CurrencyFormat.toNumberComma(
                                _interestController.text,
                              ),
                            ),
                            loanPlafon: double.parse(CurrencyFormat.toNumber(
                                _loanTotalController.text)),
                            loan: double.parse(CurrencyFormat.toNumber(
                                _loanTotalController.text)),
                            year: double.parse(
                                CurrencyFormat.toNumber(_yearController.text)),
                            interest: double.parse(
                              CurrencyFormat.toNumberComma(
                                _interestController.text,
                              ),
                            ),
                          ),
                        );
                      }));
                    },
                    child: Wrap(
                      children: [
                        Text('Hitung Simulasi'),
                        Icon(Icons.chevron_right)
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
