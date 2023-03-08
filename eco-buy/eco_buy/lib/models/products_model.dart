import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Products {
  String? category;
  String? id;
  String? productName;
  String? brandName;
  String? detail;
  int? price;
  int? discountprice;
  String? serialCode;
  List? imageUrls;
  bool? isOnsale;
  bool? isPopular;
  bool? isFavourite;
  Products(
      {this.category,
      this.id,
      this.productName,
      this.brandName,
      this.detail,
      this.price,
      this.discountprice,
      this.serialCode,
      this.imageUrls,
      this.isFavourite,
      this.isOnsale,
      this.isPopular});

  static Future<void> addProduct(Products products) async {
    debugPrint("Product is now Adding");
    //  CollectionReference db = FirebaseFirestore.instance.collection('products').doc();
    // ignore: unnecessary_cast
    await FirebaseFirestore.instance
        .collection("products")
        .doc(products.id)
        // ignore: unnecessary_cast
        .set({
          "category": products.category,
          "productName": products.productName,
          "price": products.price,
          "discountprice": products.discountprice,
          "imageUrls": products.imageUrls,
          "serialCode": products.serialCode,
          "isOnsale": products.isOnsale,
          "isFavourite": products.isFavourite,
          "isPopular": products.isPopular,
          "id": products.id,
          "detail": products.detail,
          "brandname": products.brandName
        } as Map<String, dynamic>);
    Map<String, dynamic> data = {
      "category": products.category,
      "productName": products.productName,
      "price": products.price,
      "discountprice": products.discountprice!,
      "imageUrls": products.imageUrls,
      "serialCode": products.serialCode!,
      "isOnsale": products.isOnsale!,
      "isFavourite": products.isFavourite!,
      "isPopular": products.isPopular!,
      "id": products.id!,
      "detail": products.detail!,
      "brandname": products.brandName!
    };
    try {
      // await db.add(data);
      debugPrint("Added");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> updateProduct(Products products) async {
    CollectionReference db = FirebaseFirestore.instance.collection("products");
    Map<String, dynamic> data = {
      "category": products.category,
      "productName": products.productName,
      "price": products.price,
      "discountprice": products.discountprice,
      "imageUrls": products.imageUrls,
      "serialCode": products.serialCode,
      "isOnsale": products.isOnsale,
      "isFavourite": products.isFavourite,
      "isPopular": products.isPopular,
      "id": products.id,
      "detail": products.detail,
      "brandname": products.brandName
    };
    await db.doc(products.id).update(data);
  }

  static Future deleteProduct(String id) async {
    CollectionReference db = FirebaseFirestore.instance.collection("products");
    await db.doc(id).delete();
  }
}
