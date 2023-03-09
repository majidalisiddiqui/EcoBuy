import 'package:eco_buy/screens/mobile_side/firebase_databse/Image_picker.dart';
import 'package:eco_buy/screens/mobile_side/firebase_databse/notes_firebase.dart';
import 'package:eco_buy/screens/mobile_side/home_screen.dart';
import 'package:eco_buy/screens/mobile_side/layout_screen.dart';
import 'package:eco_buy/screens/mobile_side/video_screen/Api/multi_user_api.dart';
import 'package:eco_buy/screens/mobile_side/video_screen/Bottom_Navigation.dart';
import 'package:eco_buy/screens/web_side/add_product_screen.dart';
import 'package:eco_buy/screens/web_side/update_product_screen.dart';
import 'package:eco_buy/screens/web_side/web_login.dart';
import 'package:eco_buy/screens/web_side/web_main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'package:sizer/sizer.dart';

import 'firebase_options.dart';

// void main() {
//   runApp(const MyApp());
// }

// For Getx Controller
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) {
    Get.put(GetxController);
  });
  runApp(const MyApp());
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Eco Buy',
        //debugShowCheckedModeBanner: true,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        //  home: ImagePick(),
        //home: AddProductScreen(),
        // home: UpdateProductScreen(),
        home: MultiUserApi(),
        //home: HomeApiScreen(),
        //  home: HomeScreen(),
        //  home: WebMainScreen(),
        // home: const LayoutScreen(),
        //home: BottomNavigatorBar(),
        // home: NotesFirebase(),
        routes: {
          WebLoginSCreen.id: (context) => const WebLoginSCreen(),
          WebMainScreen.id: (context) => const WebMainScreen(),
          //     UpdateProductScreen.id: (context) => UpdateProductScreen(),
          // AddProductScreen.id: (context) => const AddProductScreen(),
          // UpdateProductScreen.id: (context) => const UpdateProductScreen(),
          // DashBoardScreen.id: (context) => const DashBoardScreen(),
          // DeleteProductScreen.id: (context) => const DeleteProductScreen(),
        },
      ),
    );
  }
}
