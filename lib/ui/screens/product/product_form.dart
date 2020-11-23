import 'package:flutter/material.dart';
import 'package:kedatonkomputer/core/models/category_model.dart';
import 'package:kedatonkomputer/core/models/option_model.dart';
import 'package:kedatonkomputer/ui/widget/form.dart';
import 'package:kedatonkomputer/ui/widget/text.dart';

class ProductForm extends StatefulWidget {
  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {

  var nameController = TextEditingController();
  var merkProductController = TextEditingController();
  var buyPriceController = TextEditingController();
  var sellPriceController = TextEditingController();
  var descriptionController = TextEditingController();
  var stockController = TextEditingController();

  var categories = <OptionsModel<Category>>[];
  OptionsModel<Category> category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Produk"),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          SmallText("Nama Produk"),
          TextFieldBorderBottom(
            textHint: "Nama Produk",
          ),
          SizedBox(height: 16),
          SmallText("Merk"),
          TextFieldBorderBottom(
            textHint: "Ex: Asus, Acer",
          ),
          SizedBox(height: 16),
          SmallText("Harga Modal"),
          TextFieldBorderBottom(
            textHint: "0",
            inputType: TextInputType.number,
          ),
          SizedBox(height: 16),
          SmallText("Harga Jual"),
          TextFieldBorderBottom(
            textHint: "0",
            inputType: TextInputType.number,
          ),
          SizedBox(height: 16),
          SmallText("Stok"),
          TextFieldBorderBottom(
            textHint: "0",
            inputType: TextInputType.number,
          ),
          SizedBox(height: 16),
          SmallText("Kategori"),
          SelectionBorderBottom(
            child: Text("Pilih Kategori"),
          ),
          SizedBox(height: 16),
          SmallText("Deskripsi"),
          TextAreaBorderBottom(
            textHint: "Deskripsi produk",
            minLines: 6,
            maxLines: 15,
          ),
        ],
      ),
    );
  }
}