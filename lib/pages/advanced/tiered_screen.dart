// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

import '../../core/currency_format.dart';
import '../../core/helpers.dart';
import '../../core/loading_overlay.dart';
import '../../models/calculate_model.dart';
import '../principle/principal_table.dart';

class TieredScreen extends StatefulWidget {
  final CalculatorType type;
  const TieredScreen({super.key, required this.type});

  @override
  State<TieredScreen> createState() => _TieredScreenState();
}

class _TieredScreenState extends State<TieredScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _loanController = TextEditingController();
  final _loanTotalController = TextEditingController();
  final _dpPercentController = TextEditingController();
  final _dpNominalController = TextEditingController();
  final _yearController = TextEditingController();
  final _interestController = TextEditingController();

  final List<TextEditingController> _controllers = [TextEditingController()];

  void removeFixInterest(int index) {
    if (_controllers.length > 1) {
      setState(() {
        _controllers.removeAt(index);
      });
    }
  }

  void addFixInterest() {
    setState(() {
      _controllers.add(TextEditingController());
    });
  }

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
                        if (value == '' || value?.replaceAll(' ', '') == '0') {
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
                        if (value == '' || value?.replaceAll(' ', '') == '0') {
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
                    padding: const EdgeInsets.only(bottom: 12, top: 32),
                    child: Row(
                      children: [
                        Text(
                          'Bunga Fix',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            addFixInterest();
                          },
                          icon: Icon(Icons.add_circle_outline,
                              color: Colors.purple),
                        ),
                      ],
                    ),
                  ),
                  for (int i = 0; i < _controllers.length; i++)
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text('Bunga tahun ke ${i + 1}'),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: _controllers[i],
                              validator: (value) {
                                if (value == '' ||
                                    value?.replaceAll(' ', '') == '0') {
                                  return "Bunga pinjaman tidak boleh kosong";
                                }
                                return null;
                              },
                              inputFormatters: [
                                ThousandsFormatter(
                                    allowFraction: true,
                                    formatter:
                                        NumberFormat.decimalPattern('en'))
                              ],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                label: const Text('Bunga (%)'),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400),
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade400)),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    removeFixInterest(i);
                                  },
                                  icon: Icon(
                                    Icons.do_not_disturb_on_outlined,
                                    color: i == 0 ? Colors.grey : Colors.purple,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                        if (value == '' || value?.replaceAll(' ', '') == '0') {
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

                      if (_controllers.length >=
                          double.parse(
                              CurrencyFormat.toNumber(_yearController.text))) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.purple,
                            content: Text(
                              'Tahun bunga fix harus lebih kecil dari jangka waktu pinjaman',
                            ),
                          ),
                        );
                        return;
                      }

                      LoadingOverlay.show(context);
                      CalculateModel calculateModel = CalculateModel(
                        fixYear: _controllers.length.floorToDouble(),
                        floatingInterest: double.parse(
                          CurrencyFormat.toNumberComma(
                            _interestController.text,
                          ),
                        ),
                        initialLoan: double.parse(
                            CurrencyFormat.toNumber(_loanController.text)),
                        dpNominal: double.parse(
                            CurrencyFormat.toNumber(_dpNominalController.text)),
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

                      List<double> tieredInterest = [];
                      for (var controller in _controllers) {
                        double interest = double.parse(
                          CurrencyFormat.toNumberComma(controller.text),
                        );
                        tieredInterest.add(interest);
                      }

                      List<CalculateResultModel> tables =
                          installmentTableTiered(
                              widget.type, calculateModel, tieredInterest);

                      await Future.delayed(const Duration(seconds: 1));
                      LoadingOverlay.hide();

                      Navigator.push(context,
                          MaterialPageRoute(builder: (builder) {
                        return PrincipalTable(
                          tieredInterest: tieredInterest,
                          results: tables,
                          type: widget.type,
                          calculateModel: CalculateModel(
                            fixYear: _controllers.length.floorToDouble(),
                            floatingInterest: double.parse(
                              CurrencyFormat.toNumberComma(
                                _interestController.text,
                              ),
                            ),
                            initialLoan: double.parse(
                                CurrencyFormat.toNumber(_loanController.text)),
                            dpNominal: double.parse(CurrencyFormat.toNumber(
                                _dpNominalController.text)),
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
