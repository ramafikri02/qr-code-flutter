import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file_plus/open_file_plus.dart';
import 'package:qr_code/app/data/models/product_model.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxList<ProductModel> allProducts = List<ProductModel>.empty().obs;

  void downloadCatalog() async {
    final pdf = pw.Document();

    //! reset all products
    allProducts([]);

    //! get products from database
    var getData = await firestore.collection("product").get();
    for (var element in getData.docs) {
      allProducts.add(ProductModel.fromJson(element.data()));
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          List<pw.TableRow> allData = List.generate(
            allProducts.length,
            (index) {
              ProductModel product = allProducts[index];
              return pw.TableRow(
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(20),
                    child: pw.Text(
                      textAlign: pw.TextAlign.center,
                      "${index + 1}",
                      style: const pw.TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(20),
                    child: pw.Text(
                      textAlign: pw.TextAlign.center,
                      product.code,
                      style: const pw.TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(20),
                    child: pw.Text(
                      textAlign: pw.TextAlign.center,
                      product.name,
                      style: const pw.TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(20),
                    child: pw.Text(
                      textAlign: pw.TextAlign.center,
                      "${product.qty}",
                      style: const pw.TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(20),
                    child: pw.BarcodeWidget(
                        color: PdfColor.fromHex("#000000"),
                        barcode: pw.Barcode.qrCode(),
                        data: product.code,
                        height: 50,
                        width: 50),
                  ),
                ],
              );
            },
          );
          return [
            pw.Center(
              child: pw.Text(
                "Catalog Products",
                textAlign: pw.TextAlign.center,
                style: const pw.TextStyle(
                  fontSize: 24,
                ),
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
                          fontSize: 10,
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
                          fontSize: 10,
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
                          fontSize: 10,
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
                          fontSize: 10,
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
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                //! isi data
                ...allData
              ],
            )
          ];
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
