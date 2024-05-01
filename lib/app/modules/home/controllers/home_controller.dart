import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file_plus/open_file_plus.dart';

class HomeController extends GetxController {
  void downloadCatalog() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
            children: [
              pw.Center(
                child: pw.Text(
                  "Catalog Products",
                  textAlign: pw.TextAlign.center,
                  style: const pw.TextStyle(fontSize: 24),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Table(
                border: pw.TableBorder.all(
                  color: PdfColor.fromHex("#000000"),
                  width: 2,
                ),
                children: [
                  //! judul
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(20),
                        child: pw.Text(
                          textAlign: pw.TextAlign.center,
                          "No",
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(20),
                        child: pw.Text(
                          textAlign: pw.TextAlign.center,
                          "Product Code",
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(20),
                        child: pw.Text(
                          textAlign: pw.TextAlign.center,
                          "Nama Barang",
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(20),
                        child: pw.Text(
                          textAlign: pw.TextAlign.center,
                          "Quantity",
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(20),
                        child: pw.Text(
                          textAlign: pw.TextAlign.center,
                          "QR Code",
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  //! isi data
                  ...List.generate(5, (index) {
                    return pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(20),
                          child: pw.Text(
                            textAlign: pw.TextAlign.center,
                            "${index}",
                            style: pw.TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(20),
                          child: pw.Text(
                            textAlign: pw.TextAlign.center,
                            "sd22",
                            style: pw.TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(20),
                          child: pw.Text(
                            textAlign: pw.TextAlign.center,
                            "Nama Barang",
                            style: pw.TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(20),
                          child: pw.Text(
                            textAlign: pw.TextAlign.center,
                            "Quantity",
                            style: pw.TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(20),
                          child: pw.BarcodeWidget(
                              color: PdfColor.fromHex("#000000"),
                              barcode: pw.Barcode.qrCode(),
                              data: 'sd22',
                              height: 50,
                              width: 50),
                        ),
                      ],
                    );
                  })
                ],
              )
            ],
          );
        },
      ),
    );

    //* simpan
    Uint8List bytes = await pdf.save();

    //* buat file kosong di directory
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/product.pdf');

    //* memasukkan data di byte kedalam file kosong yang sudah dibuat
    await file.writeAsBytes(bytes);

    //* open pdf
    await OpenFile.open(file.path);
  }
}
