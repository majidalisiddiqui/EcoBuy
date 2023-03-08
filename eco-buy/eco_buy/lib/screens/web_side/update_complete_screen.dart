import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';

import '../../models/category_model.dart';
import '../../models/products_model.dart';
import '../../widgets/eco_button.dart';
import '../../widgets/eco_textfield.dart';

// ignore: must_be_immutable
class UpdateCompleteScreen extends StatefulWidget {
  String? id;
  Products? products;
  UpdateCompleteScreen({super.key, this.id, this.products});

  @override
  State<UpdateCompleteScreen> createState() => _UpdateCompleteScreenState();
}

class _UpdateCompleteScreenState extends State<UpdateCompleteScreen> {
  List<XFile> images = [];
  List<String> imageUrls = [];
  String? selectedValue;
  TextEditingController idC = TextEditingController();
  TextEditingController productNameC = TextEditingController();
  TextEditingController brandNameC = TextEditingController();
  TextEditingController detailC = TextEditingController();
  TextEditingController priceC = TextEditingController();
  TextEditingController discountPriceC = TextEditingController();
  TextEditingController serialCodeC = TextEditingController();
  bool isOnSale = false;
  bool isPopular = false;
  bool isFavourite = false;
  var uuid = const Uuid();
  get imagePicker => null;
  bool isSaving = false;
  bool isUploading = false;

  updatedData() {
    brandNameC.text = widget.products!.brandName!;
    selectedValue = widget.products!.category!;
    idC.text = widget.products!.id!;
    productNameC.text = widget.products!.productName!;
    detailC.text = widget.products!.detail!;
    priceC.text = widget.products!.price!.toString();
    discountPriceC.text = widget.products!.discountprice.toString();
    serialCodeC.text = widget.products!.serialCode!;
    isOnSale = widget.products!.isOnsale!;
    isPopular = widget.products!.isPopular!;
    isFavourite = widget.products!.isFavourite!;
  }

  @override
  void initState() {
    // TODO: implement initState
    updatedData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 13.w, vertical: 7.h),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.5),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Form(
                child: Column(
                  children: [
                    const Text("Add Product"),
                    DropdownButtonFormField(
                      validator: (value) {
                        if (value == null) {
                          return "Catageroy must be seleceted";
                        }
                        return null;
                      },
                      value: selectedValue,
                      items: categories
                          .map((e) => DropdownMenuItem<String>(
                              value: e.title, child: Text(e.title.toString())))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value;
                        });
                      },
                    ),

                    EcoTextField(
                      hintText: "Brand Name",
                      controller: brandNameC,
                      validate: (v) {
                        if (v!.isEmpty) {
                          return "Should Not be empty";
                        }
                        return null;
                      },
                    ),
                    EcoTextField(
                      hintText: "ProductName",
                      controller: productNameC,
                      validate: (v) {
                        if (v!.isEmpty) {
                          return "Should Not be empty";
                        }
                        return null;
                      },
                    ),
                    EcoTextField(
                      hintText: "Price",
                      controller: priceC,
                      validate: (v) {
                        if (v!.isEmpty) {
                          return "Should Not be empty";
                        }
                        return null;
                      },
                    ),
                    EcoTextField(
                      maxLines: 5,
                      hintText: "Details",
                      controller: detailC,
                      validate: (v) {
                        if (v!.isEmpty) {
                          return "Should Not be empty";
                        }
                        return null;
                      },
                    ),
                    EcoTextField(
                      hintText: "Discount Pice",
                      controller: discountPriceC,
                      validate: (v) {
                        if (v!.isEmpty) {
                          return "Should Not be empty";
                        }
                        return null;
                      },
                    ),
                    EcoTextField(
                      hintText: "Serial Code",
                      controller: serialCodeC,
                      validate: (v) {
                        if (v!.isEmpty) {
                          return "Should Not be empty";
                        }
                        return null;
                      },
                    ),
                    Row(
                        children: widget.products!.imageUrls!.map((e) {
                      return Container(
                        width: 20,
                        height: 20,
                        child: Image.network(e),
                      );
                    }).toList()),

                    EcoButton(
                      title: "ADD IMAGES",
                      onPress: () {
                        pickImage();
                      },
                      isLoginButton: true,
                    ),
                    // EcoButton(
                    //   isLoading: isUploading,
                    //   title: "UPLOAD IMAGE",
                    //   isLoginButton: true,
                    //   onPress: () {
                    //     //postImages(images[0]);
                    //     uploadImages();
                    //   },
                    // ),
                    Container(
                      height: 45.h,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20)),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5),
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(), color: Colors.black),
                                child: Image.network(
                                  File(images[index].path).path,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      images.removeAt(index);
                                    });
                                  },
                                  icon: Icon(Icons.cancel))
                            ],
                          );
                        },
                      ),
                    ),
                    SwitchListTile(
                        title: const Text("Product is on Sale"),
                        value: isOnSale,
                        onChanged: (_) {
                          setState(() {
                            isOnSale = !isOnSale;
                          });
                        }),
                    SwitchListTile(
                      title: const Text("Product is Popular"),
                      value: isPopular,
                      onChanged: (value) {
                        setState(() {
                          isPopular = !isPopular;
                        });
                      },
                    ),
                    SwitchListTile(
                      title: const Text("Product is Favouraie"),
                      value: isFavourite,
                      onChanged: (value) {
                        setState(() {
                          isPopular = !isPopular;
                        });
                      },
                    ),
                    EcoButton(
                      title: "SAVE",
                      onPress: () {
                        save();
                      },
                      isLoading: isSaving,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  pickImage() async {
    final List<XFile> pickImage = await imagePicker.pickMultiImage();
    // ignore: unnecessary_null_comparison
    if (pickImage != null) {
      setState(() {
        images.addAll(pickImage);
      });
    } else {
      print("no Image selected");
    }
  }

  Future postImages(XFile? imageFile) async {
    setState(() {
      isUploading = true;
    });
    String urls;
    Reference ref = FirebaseStorage.instance.ref().child(imageFile!.name);
    try {
      if (kIsWeb) {
        await ref.putData(
          await imageFile.readAsBytes(),
          SettableMetadata(contentType: "image/jpeg"),
        );
        urls = await ref.getDownloadURL();
        setState(() {
          isUploading = false;
        });
        return urls;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  uploadImages() async {
    try {
      for (var image in images) {
        await postImages(image).then((value) => imageUrls.add(value));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  save() async {
    setState(() {
      isSaving = true;
    });
    try {
      await uploadImages();
      await Products.updateProduct(
              // id :idC.text ,
              Products(
                  brandName: brandNameC.text,
                  category: selectedValue,
                  id: idC.text,
                  productName: productNameC.text,
                  detail: detailC.text,
                  price: int.parse(priceC.text),
                  discountprice: int.parse(discountPriceC.text),
                  serialCode: serialCodeC.text,
                  imageUrls: imageUrls,
                  isFavourite: isFavourite,
                  isOnsale: isOnSale,
                  isPopular: isPopular))
          .onError((error, stackTrace) {
        debugPrint(error.toString());
      }).whenComplete(() {
        setState(() {
          isSaving = false;
          images.clear();
          imageUrls.clear();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Updated Successfully")));
        });
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    // await FirebaseFirestore.instance
    //     .collection("products")
    //     .add({"images": imageUrls}).whenComplete(() {
    //   setState(() {
    //     isSaving = false;

    //     c
    //   });
    // });
  }
}
