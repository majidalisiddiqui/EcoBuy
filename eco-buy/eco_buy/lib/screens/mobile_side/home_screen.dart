import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_buy/models/products_model.dart';
import 'package:eco_buy/screens/mobile_side/login_screen.dart';
import 'package:eco_buy/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../widgets/category_home.dart';
import '../../widgets/home_cards.dart';
import 'package:sizer/sizer.dart';

//List catagerious = ["GROCERY", "ELECTRONIC", "COSMATIC", "PHARMACY", "CLOTHS"];

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List images = [
    "https://cdn.pixabay.com/photo/2015/09/21/14/24/supermarket-949913_960_720.jpg",
    "https://cdn.pixabay.com/photo/2017/08/05/00/12/girl-2581913_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/11/22/19/08/hangers-1850082_960_720.jpg",
    "https://cdn.pixabay.com/photo/2015/09/21/14/24/supermarket-949913_960_720.jpg",
    "https://cdn.pixabay.com/photo/2017/08/05/00/12/girl-2581913_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/11/22/19/08/hangers-1850082_960_720.jpg",
  ];

  List<Products> allproducts = [];

  getData() async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((e) {
          if (e.exists) {
            setState(() {
              allproducts.add(
                Products(
                    category: e['category'],
                    id: e.id,
                    productName: e['productName'],
                    detail: e['detail'],
                    price: e['price'],
                    discountprice: e['discountprice'],
                    serialCode: e['serialCode'],
                    imageUrls: e['imageUrls'],
                    isFavourite: e['isFavourite'],
                    isOnsale: e['isOnsale'],
                    isPopular: e['isPopular'],
                    brandName: e['brandname']),
              );
            });
          }
        });
      });
      print(allproducts[0].brandName);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    // super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              FirebaseService.signOut();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ));
            },
            icon: Icon(Icons.logout))
      ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RichText(
              text: const TextSpan(children: [
                TextSpan(
                    text: "SHOP ",
                    style: TextStyle(
                        fontSize: 27,
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold)),
                TextSpan(
                    text: "NOW",
                    style: TextStyle(
                        fontSize: 27,
                        color: Colors.black,
                        fontWeight: FontWeight.bold))
              ]),
            ),
            const CategoryHome(),
            CaroselSliderScreen(images: images),
            
          ],
        ),
      ),
    );
  }
}

class CaroselSliderScreen extends StatelessWidget {
  const CaroselSliderScreen({
    super.key,
    required this.images,
  });

  final List images;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: images
            .map((e) => Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        // child: Image.network(
                        //   e,
                        //   width: double.infinity,
                        //   height: 200,
                        //   fit: BoxFit.fill,
                        // ),
                        // to get Network imae and loading show
                        child: CachedNetworkImage(
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.fill,
                          imageUrl: e,
                          placeholder: (context, url) {
                            return LinearProgressIndicator();
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(colors: [
                              Colors.blueAccent.withOpacity(0.3),
                              Colors.redAccent.withOpacity(0.3),
                            ])),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: Container(
                        color: Colors.black.withOpacity(0.4),
                        child: const Text(
                          "TITLE",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ))
            .toList(),
        options: CarouselOptions(height: 200, autoPlay: true));
  }
}
