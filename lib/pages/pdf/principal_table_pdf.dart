import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:kalkulator_kpr/models/calculate_model.dart';
import 'package:kalkulator_kpr/utils/pdf_util.dart';

class PrincipalTablePDF extends StatefulWidget {
  final CalculatorType? type;
  final CalculateModel? calculateModel;
  final List<CalculateResultModel>? results;
  const PrincipalTablePDF(
      {super.key, this.results, this.type, this.calculateModel});

  @override
  State<PrincipalTablePDF> createState() => _PrincipalTablePDFState();
}

class _PrincipalTablePDFState extends State<PrincipalTablePDF> {
  File? document;

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

  Future<void> initPDF() async {
    File filePdf = await PdfUtil.generatePrincipalPDF(widget.results ?? [],
        totalPrincipal: getTotal("principal"),
        totalInstallment: getTotal("installment"),
        totalInterest: getTotal("interest"),
        type: widget.type,
        calculateModel: widget.calculateModel);
    document = filePdf;
    setState(() {});
  }

  @override
  void initState() {
    initPDF();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Principal Table PDF'),
      ),
      body: document == null
          ? const SizedBox()
          : PDFView(
              filePath: document?.path,
              enableSwipe: true,
              swipeHorizontal: true,
              autoSpacing: false,
              pageFling: false,
              backgroundColor: Colors.grey,
            ),
    );
  }
}
