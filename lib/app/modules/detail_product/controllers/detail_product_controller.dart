import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class DetailProductController extends GetxController {
  RxBool isLoadingUpdate = false.obs;
  RxBool isLoadingDelete = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //! Update product
  Future<Map<String, dynamic>> editProduct(Map<String, dynamic> data) async {
    try {
      await firestore.collection("product").doc(data["id"]).update({
        "name": data["name"],
        "qty": data["qty"],
      });

      return {"error": false, "message": "Berhasil mengubah product"};
    } catch (e) {
      //? ketika running dalam mode debug akan menampilkan log error pada
      if (kDebugMode) {
        print(e);
      }
      //? Error general
      return {"error": true, "message": "Tidak dapat mengubah product"};
    }
  }

  //! Delete product
  Future<Map<String, dynamic>> deleteProduct(String id) async {
    try {
      await firestore.collection("product").doc(id).delete();

      return {"error": false, "message": "Berhasil menghapus product"};
    } catch (e) {
      //? ketika running dalam mode debug akan menampilkan log error pada
      if (kDebugMode) {
        print(e);
      }
      //? Error general
      return {"error": true, "message": "Tidak dapat menghapus product"};
    }
  }
}
