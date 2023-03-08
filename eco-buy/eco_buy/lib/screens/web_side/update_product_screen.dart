import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_buy/models/products_model.dart';
import 'package:eco_buy/screens/web_side/update_complete_screen.dart';
import 'package:eco_buy/utils/eco_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class UpdateProductScreen extends StatelessWidget {
  static const String id = "UpdateProductScreen";
//  String? id;
  UpdateProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Update Product Screen ",
              style: EcoStyle.EcoBold,
            ),
            StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('products').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data == null) {
                  return const Center(
                    child: Text("No Data Exists"),
                  );
                }
                final data = snapshot.data!.docs;
                return Expanded(
                  //  color: Colors.primaries[Random().nextInt(data.length)],
                  // width: double.infinity,
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          color: Colors.black,
                          // color: Colors.primaries[
                          //  Random().nextInt(snapshot.data!.docs.length)],
                          width: double.infinity,
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Text(
                                " ${data[index]['productName']}",
                                style: TextStyle(color: Colors.white),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 50,
                                    color: Colors.primaries[Random()
                                        .nextInt(snapshot.data!.docs.length)],
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                UpdateCompleteScreen(
                                              id: data[index].id,
                                              products: Products(
                                                  category: data[index]
                                                      ['category'],
                                                  id: data[index].id,
                                                  productName: data[index]
                                                      ['productName'],
                                                  detail: data[index]['detail'],
                                                  price: data[index]['price'],
                                                  discountprice: data[index]
                                                      ['discountprice'],
                                                  serialCode: data[index]
                                                      ['serialCode'],
                                                  imageUrls: data[index]
                                                      ['imageUrls'],
                                                  isFavourite: data[index]
                                                      ['isFavourite'],
                                                  isOnsale: data[index]
                                                      ['isOnsale'],
                                                  isPopular: data[index]
                                                      ['isPopular'],
                                                  brandName: data[index]
                                                      ['brandname']),
                                            ),
                                          ),
                                        );
                                      },
                                      icon:
                                          Icon(Icons.edit, color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    width: 50,
                                    color: Colors.primaries[Random()
                                        .nextInt(snapshot.data!.docs.length)],
                                    child: IconButton(
                                      onPressed: () {
                                        Products.deleteProduct(
                                          data[index].id,
                                        );
                                      },
                                      icon: Icon(Icons.delete,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            Row(
              children: [],
            )
          ],
        ),
      ),
    );
  }
}

 // Container(
                          //   width: 300,
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.end,
                          //     children: [
                          //       IconButton(
                          //           onPressed: () {
                          //             Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                   builder: (context) =>
                          //                       UpdateCompleteScreen(
                          //                     id: data[index].id,
                          //                     products: Products(
                          //                         category: data[index]
                          //                             ['category'],
                          //                         id: data[index].id,
                          //                         productName: data[index]
                          //                             ['productName'],
                          //                         detail: data[index]
                          //                             ['detail'],
                          //                         price: data[index]['price'],
                          //                         discountprice: data[index]
                          //                             ['discountprice'],
                          //                         serialCode: data[index]
                          //                             ['serialCode'],
                          //                         imageUrls: data[index]
                          //                             ['imageUrls'],
                          //                         isFavourite: data[index]
                          //                             ['isFavourite'],
                          //                         isOnsale: data[index]
                          //                             ['isOnsale'],
                          //                         isPopular: data[index]
                          //                             ['isPopular'],
                          //                         brandName: data[index]
                          //                             ['brandname']),
                          //                   ),
                          //                 ));
                          //           },
                          //           icon: Icon(Icons.edit,
                          //               color: Colors.white)),
                          //       IconButton(
                          //           onPressed: () {},
                          //           icon: Icon(Icons.delete,
                          //               color: Colors.white)),
                          //     ],
                          //   ),
                          // ),
                    