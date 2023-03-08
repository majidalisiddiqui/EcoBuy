import 'package:eco_buy/screens/mobile_side/login_screen.dart';
import 'package:eco_buy/screens/web_side/update_product_screen.dart';
import 'package:eco_buy/services/firebase_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_admin_scaffold/admin_scaffold.dart';

import 'add_product_screen.dart';
import 'dashboard_screen.dart';
import 'delete_product_screen.dart';

class WebMainScreen extends StatefulWidget {
  static const String id = 'webMainScreen';
  const WebMainScreen({super.key});

  @override
  State<WebMainScreen> createState() => _WebMainScreenState();
}

class _WebMainScreenState extends State<WebMainScreen> {
  Widget seletedScreen = DashBoardScreen();

  chooseScreen(item) {
    switch (item) {
      case DashBoardScreen.id:
        setState(() {
          seletedScreen = const DashBoardScreen();
        });
        break;
      case AddProductScreen.id:
        setState(() {
          seletedScreen = const AddProductScreen();
        });
        break;
      case UpdateProductScreen.id:
        setState(() {
          seletedScreen = UpdateProductScreen();
        });
        break;
      case DeleteProductScreen.id:
        setState(() {
          seletedScreen = const DeleteProductScreen();
        });
        break;
      default:
    }
  }

  signOut(BuildContext context) async {
    await FirebaseService.signOut();

    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => LoginScreen(),
    //     ));
    //Navigator.pop(context);
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  signOut(context);
                },
                icon: Icon(Icons.logout))
          ],
          title: const Text("ADMIN"),
          backgroundColor: Colors.black,
        ),
        sideBar: SideBar(
            onSelected: (item) {
              chooseScreen(item.route);
            },
            items: const [
              AdminMenuItem(
                  title: "DASHBOARD",
                  icon: Icons.dashboard,
                  route: DashBoardScreen.id),
              AdminMenuItem(
                  title: "ADD PRODUCTS ",
                  icon: Icons.add,
                  route: AddProductScreen.id),
              AdminMenuItem(
                  title: "UPDATE PRODUCTS",
                  icon: Icons.update,
                  route: UpdateProductScreen.id),
              AdminMenuItem(
                  title: "DELETE PRODUCTS",
                  icon: Icons.delete,
                  route: DeleteProductScreen.id),
              AdminMenuItem(
                  title: "CARD ITEMS",
                  icon: Icons.card_giftcard,
                  route: DashBoardScreen.id),
            ],
            selectedRoute: WebMainScreen.id),
        body: seletedScreen);
  }
}
