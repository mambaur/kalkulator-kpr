import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

class FixAndFloatingScreen extends StatefulWidget {
  const FixAndFloatingScreen({super.key});

  @override
  State<FixAndFloatingScreen> createState() => _FixAndFloatingScreenState();
}

class _FixAndFloatingScreenState extends State<FixAndFloatingScreen> {
  double fixInterestRateValue = 4;
  double fixedCreditPeriod = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
                    // controller: _loanController,
                    validator: (value) {
                      if (value == '') {
                        return "Jumlah pinjaman tidak boleh kosong";
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
                      label: const Text('Jumlah Pinjaman (Rp)'),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400)),
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
                          // controller: _yearController,
                          validator: (value) {
                            if (value == '') {
                              return "DP tidak boleh kosong";
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
                          // controller: _interestController,
                          validator: (value) {
                            if (value == '') {
                              return "DP tidak boleh kosong";
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
                  margin: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: TextFormField(
                    // controller: _yearController,
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
                          borderSide: BorderSide(color: Colors.grey.shade400)),
                      suffixIcon:
                          const Icon(Icons.alarm, color: Colors.black54),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 12, top: 24),
                  child: Text(
                    'Bunga Fix',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    'Suku Bunga Fix',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
                            style: TextStyle(fontSize: 14, color: Colors.grey),
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
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
                            style: TextStyle(fontSize: 14, color: Colors.grey),
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    // controller: _interestController,
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
                          borderSide: BorderSide(color: Colors.grey.shade400)),
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
                  style: FilledButton.styleFrom(backgroundColor: Colors.purple),
                  onPressed: () {},
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
    );
  }
}
