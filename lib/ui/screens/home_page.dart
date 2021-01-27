import 'package:flutter/material.dart';
import 'package:kedatonkomputer/helper/shared_preferences.dart';
import 'package:kedatonkomputer/ui/screens/category/category_page.dart';
import 'package:kedatonkomputer/ui/screens/login.dart';
import 'package:kedatonkomputer/ui/screens/order/order_page.dart';
import 'package:kedatonkomputer/ui/screens/product/product_page.dart';
import 'package:kedatonkomputer/ui/screens/profile_page.dart';
import 'package:kedatonkomputer/ui/screens/report_page.dart';
import 'package:kedatonkomputer/ui/screens/user/user_page.dart';
import 'package:kedatonkomputer/ui/widget/box.dart';
import 'package:kedatonkomputer/ui/widget/text.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.account_circle), 
          onPressed: () => Navigator.push(context, MaterialPageRoute(
            builder: (context) => ProfilePage()
          ))
        ),
        title: Text("Kedaton Komputer"),
      ),
      body: Column(
        children: [
          Box(
            child: Row(
              children: [
                Icon(Icons.list),
                SizedBox(width: 16),
                TextCustom("Kelola Kategori Produk"),
              ],
            ),
            padding: 16,
            onPressed: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) => CategoryPage()
            ))
          ),
          Divider(height: 0),
          Box(
            child: Row(
              children: [
                Icon(Icons.layers),
                SizedBox(width: 16),
                TextCustom("Kelola Produk"),
              ],
            ),
            padding: 16,
            onPressed: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) => ProductPage()
            ))
          ),
          Divider(height: 0),
          Box(
            child: Row(
              children: [
                Icon(Icons.shopping_basket),
                SizedBox(width: 16),
                TextCustom("Kelola Order"),
              ],
            ),
            padding: 16,
            onPressed: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) => OrderPage()
            ))
          ),
          Divider(height: 0),
          Box(
            child: Row(
              children: [
                Icon(Icons.people),
                SizedBox(width: 16),
                TextCustom("Kelola User"),
              ],
            ),
            padding: 16,
            onPressed: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) => UserPage()
            ))
          ),
          Divider(height: 0),
          Box(
            child: Row(
              children: [
                Icon(Icons.bar_chart),
                SizedBox(width: 16),
                TextCustom("Report"),
              ],
            ),
            padding: 16,
            onPressed: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) => ReportPage()
            ))
          ),
          Divider(height: 0),
          Box(
            child: Row(
              children: [
                Icon(Icons.logout),
                SizedBox(width: 16),
                TextCustom("Keluar"),
              ],
            ),
            padding: 16,
            onPressed: () {
              SharedPreferencesHelper.clear();
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => LoginPage()
              ));
            },
          ),
          Divider(height: 0),
        ],
      )
    );
  }
}