import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kalkulator_kpr/core/helpers.dart';
import 'package:kalkulator_kpr/models/calculate_model.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

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
      home: const MyHomePage(title: 'Kalkulator KPR'),
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
  final _loadController = TextEditingController();
  final _yearController = TextEditingController();
  final _interestController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: SafeArea(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              // const DrawerHeader(
              //   decoration: BoxDecoration(
              //     color: Colors.blue,
              //   ),
              //   child: Text('Drawer Header'),
              // ),
              ListTile(
                title: const Text('Bunga Flat'),
                onTap: () {
                  _scaffoldKey.currentState?.openEndDrawer();
                  CalculateResultModel calculate = calculateFlat(
                      CalculateModel(loan: 400000000, year: 3, interest: 10));
                  print(calculate.toJson());
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: const Text('Bunga Efektif'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: const Text('Bunga Anuitas'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
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
                    title: const Text('Flat'),
                    centerTitle: true,
                    elevation: 0,
                    leading: IconButton(
                      onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                      icon: SizedBox(
                        width: 25,
                        height: 25,
                        child: Image.network(
                            'https://cdn-icons-png.flaticon.com/512/9091/9091429.png'),
                      ),
                    ),
                    actions: [
                      IconButton(
                        onPressed: () =>
                            _scaffoldKey.currentState?.openDrawer(),
                        icon: SizedBox(
                          width: 25,
                          height: 25,
                          child: Image.network(
                              'https://cdn-icons-png.flaticon.com/512/984/984199.png'),
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
                        percent: 0.7,
                        center: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Total Angsuran",
                              style: TextStyle(fontSize: 15.0),
                            ),
                            Text(
                              "Rp 10.000.000",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25.0),
                            ),
                            Text(
                              "Per Bulan",
                              style: TextStyle(fontSize: 15.0),
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
                                children: const [
                                  Text(
                                    "Angsuran Pokok",
                                    style: TextStyle(),
                                  ),
                                  Text(
                                    "Rp 8.000.000",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                children: const [
                                  Text(
                                    "Bunga",
                                    style: TextStyle(),
                                  ),
                                  Text(
                                    "Rp 1.000.000",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                              controller: _loadController,
                              validator: (value) {
                                if (value == '') {
                                  return "Jumlah pinjaman tidak boleh kosong";
                                }
                              },
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
                                  child: Image.network(
                                      "https://cdn-icons-png.flaticon.com/512/8222/8222244.png"),
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
                                      suffixIcon: const Icon(Icons.date_range,
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
                                Expanded(
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey.shade300,
                                        foregroundColor: Colors.black87,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState!
                                            .validate()) {}
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.all(15.0),
                                        child: Text('Hitung Ulang'),
                                      )),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.purple,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: const Padding(
                                        padding: EdgeInsets.all(15.0),
                                        child: Text('Tabel Angsuran'),
                                      )),
                                ),
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
