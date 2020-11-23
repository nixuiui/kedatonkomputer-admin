import 'package:flutter/material.dart';
import 'package:kedatonkomputer/ui/widget/box.dart';
import 'package:kedatonkomputer/ui/widget/button.dart';
import 'package:kedatonkomputer/ui/widget/form.dart';
import 'package:kedatonkomputer/ui/widget/text.dart';

class CategoryForm extends StatefulWidget {
  @override
  _CategoryFormState createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {

  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Kategori"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                SmallText("Nama Kategori"),
                TextFieldBorderBottom(
                  textHint: "Nama Kategori",
                ),
              ],
            ),
          ),
          Box(
            padding: 16,
            child: RaisedButtonAccent(
              text: "Simpan",
              onPressed: () {}
            ),
          )
        ],
      ),
    );
  }
}