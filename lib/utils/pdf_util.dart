import 'dart:io';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:kalkulator_kpr/core/currency_format.dart';
import 'package:kalkulator_kpr/core/custom_date.dart';
import 'package:kalkulator_kpr/models/calculate_model.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;

class PdfUtil {
  static Future<File> generatePrincipalPDF(
      List<CalculateResultModel> calculates,
      {int? totalPrincipal,
      int? totalInterest,
      int? totalInstallment,
      CalculatorType? type,
      CalculateModel? calculateModel}) async {
    Uint8List? logobytes;

    try {
      ByteData bytes = await rootBundle.load('assets/ic_launcher.png');
      logobytes = bytes.buffer.asUint8List();
    } catch (_) {}

    String typePrincipal = type == CalculatorType.flat
        ? 'Flat'
        : type == CalculatorType.effective
            ? 'Efektif'
            : 'Anuitas';

    // pw.Document pdf = pw.Document();
    // pdf.addPage(pw.MultiPage(
    //     maxPages: 1000,
    //     pageFormat: PdfPageFormat.a4,
    //     build: (pw.Context context) {
    //       return [
    //         pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
    //           pw.Expanded(
    //               child: pw.Row(children: [
    //             logobytes != null
    //                 ? pw.Container(
    //                     margin: const pw.EdgeInsets.only(
    //                       right: 10,
    //                     ),
    //                     child: pw.Image(pw.MemoryImage(logobytes),
    //                         width: 50, height: 50))
    //                 : pw.SizedBox(),
    //             pw.Expanded(
    //                 child: pw.Column(
    //               crossAxisAlignment: pw.CrossAxisAlignment.start,
    //               mainAxisAlignment: pw.MainAxisAlignment.center,
    //               children: [
    //                 pw.Container(
    //                     child: pw.Text('Tabel Angsuran',
    //                         style: pw.TextStyle(
    //                             fontWeight: pw.FontWeight.bold, fontSize: 16))),
    //                 pw.Container(child: pw.Text('Kalkulator KPR')),
    //               ],
    //             )),
    //           ])),
    //           pw.Text(DateCustom.timestamp())
    //         ]),
    //         pw.SizedBox(height: 15),
    //         pw.Container(
    //           margin: const pw.EdgeInsets.only(bottom: 15),
    //           child: pw.Row(children: [
    //             pw.Expanded(
    //                 child: pw.Column(
    //                     crossAxisAlignment: pw.CrossAxisAlignment.start,
    //                     children: [
    //                   pw.Text("Jenis: $typePrincipal"),
    //                   pw.Text(
    //                       "Jumlah Pinjaman: Rp. ${currencyId.format(calculateModel?.loan ?? 0)}"),
    //                 ])),
    //             pw.Expanded(
    //                 child: pw.Column(
    //                     crossAxisAlignment: pw.CrossAxisAlignment.start,
    //                     children: [
    //                   pw.Text(
    //                       "Jangka Waktu (Tahun): ${currencyId.format(calculateModel?.year ?? 0)}"),
    //                   pw.Text(
    //                       "Bunga (%): ${calculateModel?.interest?.toString()}"),
    //                 ])),
    //           ]),
    //         ),
    //         pw.Table(
    //             columnWidths: {
    //               0: const pw.FixedColumnWidth(50),
    //               // 1: const pw.FlexColumnWidth(1),
    //             },
    //             border: pw.TableBorder.all(),
    //             children: [
    //               pw.TableRow(children: [
    //                 pw.Center(
    //                     child: pw.Container(
    //                   padding: const pw.EdgeInsets.all(10),
    //                   child: pw.Text("Bulan ke",
    //                       textAlign: pw.TextAlign.center,
    //                       style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
    //                 )),
    //                 pw.Center(
    //                     child: pw.Container(
    //                   padding: const pw.EdgeInsets.all(10),
    //                   child: pw.Text("Angsuran Pokok",
    //                       textAlign: pw.TextAlign.center,
    //                       style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
    //                 )),
    //                 pw.Center(
    //                     child: pw.Container(
    //                   padding: const pw.EdgeInsets.all(10),
    //                   child: pw.Text("Bunga",
    //                       textAlign: pw.TextAlign.center,
    //                       style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
    //                 )),
    //                 pw.Center(
    //                     child: pw.Container(
    //                   padding: const pw.EdgeInsets.all(10),
    //                   child: pw.Text("Jumlah Angsuran",
    //                       textAlign: pw.TextAlign.center,
    //                       style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
    //                 )),
    //                 pw.Center(
    //                     child: pw.Container(
    //                   padding: const pw.EdgeInsets.all(10),
    //                   child: pw.Text("Sisa Pinjaman",
    //                       textAlign: pw.TextAlign.center,
    //                       style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
    //                 )),
    //               ]),
    //               for (int i = 0; i < calculates.length; i++)
    //                 pw.TableRow(children: [
    //                   pw.Center(
    //                       child: pw.Container(
    //                     padding: const pw.EdgeInsets.all(10),
    //                     child: pw.Text((i + 1).toString()),
    //                   )),
    //                   pw.Align(
    //                       alignment: pw.Alignment.centerRight,
    //                       child: pw.Container(
    //                         padding: const pw.EdgeInsets.all(10),
    //                         child: pw.Text(
    //                             currencyId.format(calculates[i].principal)),
    //                       )),
    //                   pw.Align(
    //                       alignment: pw.Alignment.centerRight,
    //                       child: pw.Container(
    //                         padding: const pw.EdgeInsets.all(10),
    //                         child: pw.Text(currencyId
    //                             .format(calculates[i].interestResult)),
    //                       )),
    //                   pw.Align(
    //                       alignment: pw.Alignment.centerRight,
    //                       child: pw.Container(
    //                         padding: const pw.EdgeInsets.all(10),
    //                         child: pw.Text(currencyId
    //                             .format(calculates[i].installmentResult)),
    //                       )),
    //                   pw.Align(
    //                       alignment: pw.Alignment.centerRight,
    //                       child: pw.Container(
    //                         padding: const pw.EdgeInsets.all(10),
    //                         child: pw.Text(currencyId.format(
    //                             calculates[i].principalTotalRemain! < 1
    //                                 ? 0
    //                                 : calculates[i].principalTotalRemain!)),
    //                       )),
    //                 ]),
    //               pw.TableRow(children: [
    //                 pw.Center(
    //                     child: pw.Container(
    //                   padding: const pw.EdgeInsets.all(10),
    //                   child: pw.Text("Total",
    //                       textAlign: pw.TextAlign.center,
    //                       style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
    //                 )),
    //                 pw.Align(
    //                     alignment: pw.Alignment.centerRight,
    //                     child: pw.Container(
    //                       padding: const pw.EdgeInsets.all(10),
    //                       child: pw.Text(currencyId.format(totalPrincipal ?? 0),
    //                           style:
    //                               pw.TextStyle(fontWeight: pw.FontWeight.bold)),
    //                     )),
    //                 pw.Align(
    //                     alignment: pw.Alignment.centerRight,
    //                     child: pw.Container(
    //                       padding: const pw.EdgeInsets.all(10),
    //                       child: pw.Text(currencyId.format(totalInterest ?? 0),
    //                           style:
    //                               pw.TextStyle(fontWeight: pw.FontWeight.bold)),
    //                     )),
    //                 pw.Align(
    //                     alignment: pw.Alignment.centerRight,
    //                     child: pw.Container(
    //                       padding: const pw.EdgeInsets.all(10),
    //                       child: pw.Text(
    //                           currencyId.format(totalInstallment ?? 0),
    //                           style:
    //                               pw.TextStyle(fontWeight: pw.FontWeight.bold)),
    //                     )),
    //                 pw.Align(
    //                     alignment: pw.Alignment.centerRight,
    //                     child: pw.Container(
    //                       padding: const pw.EdgeInsets.all(10),
    //                       child: pw.Text("--",
    //                           style:
    //                               pw.TextStyle(fontWeight: pw.FontWeight.bold)),
    //                     )),
    //               ]),
    //             ]),
    //       ]; // Center
    //     }));

    final Directory? downloadsDir = await getDownloadsDirectory();
    final file = File(
        "${downloadsDir!.path}/principal-${Random().nextInt(1000000).toString()}.pdf");
    // await file.writeAsBytes(await pdf.save());
    return file;
  }
}
