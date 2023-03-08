import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_buy/models/category_model.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

class CategoryHome extends StatelessWidget {
  const CategoryHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...List.generate(
              categories.length,
              (index) => Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 15.h,
                          width: 15.w,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      AssetImage("${categories[index].image}")),
                              borderRadius: BorderRadius.circular(5),
                              // shape: BoxShape.circle,
                              border: Border.all(color: Colors.black)
                              // color: Colors.primaries[
                              //     Random().nextInt(categories.length)],
                              ),
                        ),
                      ),
                      Container(
                          //width: 10,
                          //   decoration: BoxDecoration(border: Border.all()),
                          child: Text(
                        categories[index].title!,
                        style: TextStyle(fontSize: 12),
                      )),
                    ],
                  )),
        ],
      ),
    );
  }
}
