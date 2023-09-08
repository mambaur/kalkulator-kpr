import 'dart:io';
import 'dart:math';

import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PrincipalTablePDF extends StatefulWidget {
  const PrincipalTablePDF({super.key});

  @override
  State<PrincipalTablePDF> createState() => _PrincipalTablePDFState();
}

class _PrincipalTablePDFState extends State<PrincipalTablePDF> {
  final pdf = pw.Document();
  PDFDocument? document;

  Future<void> initPage() async {
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(children: [
            pw.Container(
                margin: const pw.EdgeInsets.only(bottom: 15),
                child: pw.Text('Principle Table',
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 16))),
            pw.Table(
                columnWidths: {
                  0: const pw.FixedColumnWidth(50),
                  // 1: const pw.FlexColumnWidth(1),
                },
                border: pw.TableBorder.all(),
                children: [
                  pw.TableRow(children: [
                    pw.Center(
                        child: pw.Container(
                      padding: const pw.EdgeInsets.all(10),
                      child: pw.Text("Bulan ke",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    )),
                    pw.Center(
                        child: pw.Container(
                      padding: const pw.EdgeInsets.all(10),
                      child: pw.Text("Angsuran Pokok",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    )),
                    pw.Center(
                        child: pw.Container(
                      padding: const pw.EdgeInsets.all(10),
                      child: pw.Text("Bunga",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    )),
                    pw.Center(
                        child: pw.Container(
                      padding: const pw.EdgeInsets.all(10),
                      child: pw.Text("Jumlah Angsuran",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    )),
                    pw.Center(
                        child: pw.Container(
                      padding: const pw.EdgeInsets.all(10),
                      child: pw.Text("Sisa Pinjaman",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    )),
                  ]),
                  pw.TableRow(children: [
                    pw.Center(
                        child: pw.Container(
                      padding: const pw.EdgeInsets.all(10),
                      child: pw.Text("1"),
                    )),
                    pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(10),
                          child: pw.Text("100.000"),
                        )),
                    pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(10),
                          child: pw.Text("200.000"),
                        )),
                    pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(10),
                          child: pw.Text("300.000"),
                        )),
                    pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(10),
                          child: pw.Text("400.000"),
                        )),
                  ]),
                  pw.TableRow(children: [
                    pw.Center(
                        child: pw.Container(
                      padding: const pw.EdgeInsets.all(10),
                      child: pw.Text("2"),
                    )),
                    pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(10),
                          child: pw.Text("100.000"),
                        )),
                    pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(10),
                          child: pw.Text("200.000"),
                        )),
                    pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(10),
                          child: pw.Text("300.000"),
                        )),
                    pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(10),
                          child: pw.Text("400.000"),
                        )),
                  ]),
                ])
          ]); // Center
        }));

    final Directory? downloadsDir = await getDownloadsDirectory();
    print(downloadsDir!.path +
        "/FilePDF_${Random().nextInt(1000000).toString()}.pdf");
    final file = File(downloadsDir!.path +
        "/FilePDF_${Random().nextInt(1000000).toString()}.pdf");
    await file.writeAsBytes(await pdf.save());

    document = await PDFDocument.fromFile(file);
    setState(() {});
  }

  @override
  void initState() {
    initPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Principal Table PDF'),
      ),
      body: Center(
          child: document == null
              ? const Center(child: CircularProgressIndicator())
              : PDFViewer(document: document!)),
    );
  }
}
