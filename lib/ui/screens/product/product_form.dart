import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kedatonkomputer/core/bloc/category/category_bloc.dart';
import 'package:kedatonkomputer/core/bloc/category/category_event.dart';
import 'package:kedatonkomputer/core/bloc/category/category_state.dart';
import 'package:kedatonkomputer/core/bloc/product/product_bloc.dart';
import 'package:kedatonkomputer/core/bloc/product/product_event.dart';
import 'package:kedatonkomputer/core/bloc/product/product_state.dart';
import 'package:kedatonkomputer/core/models/category_model.dart';
import 'package:kedatonkomputer/core/models/option_model.dart';
import 'package:kedatonkomputer/core/models/product_model.dart';
import 'package:kedatonkomputer/ui/widget/box.dart';
import 'package:kedatonkomputer/ui/widget/button.dart';
import 'package:kedatonkomputer/ui/widget/form.dart';
import 'package:kedatonkomputer/ui/widget/select_option.dart';
import 'package:kedatonkomputer/ui/widget/text.dart';
import 'package:toast/toast.dart';

class ProductForm extends StatefulWidget {

  const ProductForm({
    Key key,
    this.product,
  }) : super(key: key);
  
  final Product product;

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

  var categoryBloc = CategoryBloc();
  var categories = <OptionsModel<Category>>[];
  OptionsModel<Category> category;

  var bloc = ProductBloc();
  var isLoading = false;

  @override
  void initState() {
    categoryBloc.add(LoadCategories());
    if(widget.product != null) {
      nameController.text = widget.product.name;
      merkProductController.text = widget.product.merkProduct;
      buyPriceController.text = widget.product.buyPrice.toString();
      sellPriceController.text = widget.product.sellPrice.toString();
      descriptionController.text = widget.product.description;
      stockController.text = widget.product.stock.toString();
      print("widget.product.category.toMap()");
      print(widget?.product?.toMap());
      category = OptionsModel(
        name: widget.product?.category?.name ?? "",
        value: widget.product.category
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener(
          cubit: bloc,
          listener: (context, state) {
            if(state is ProductCreated) {
              Navigator.pop(context);
            } else if(state is ProductUpdated) {
              Navigator.pop(context);
            } else if(state is ProductFailure) {
              setState(() {
                isLoading = false;
              });
            }
          }
        ),
        BlocListener(
          cubit: categoryBloc,
          listener: (context, state) {
            if(state is CategoryLoaded) {
              setState(() {
                categories = state.data.map((e) => OptionsModel(name: e.name, value: e)).toList();
              });
            }
          }
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text("Produk"),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  SmallText("Nama Produk"),
                  TextFieldBorderBottom(
                    textHint: "Nama Produk",
                    controller: nameController,
                  ),
                  SizedBox(height: 16),
                  SmallText("Merk"),
                  TextFieldBorderBottom(
                    textHint: "Ex: Asus, Acer",
                    controller: merkProductController,
                  ),
                  SizedBox(height: 16),
                  SmallText("Harga Modal"),
                  TextFieldBorderBottom(
                    textHint: "0",
                    inputType: TextInputType.number,
                    controller: buyPriceController,
                  ),
                  SizedBox(height: 16),
                  SmallText("Harga Jual"),
                  TextFieldBorderBottom(
                    textHint: "0",
                    inputType: TextInputType.number,
                    controller: sellPriceController,
                  ),
                  SizedBox(height: 16),
                  SmallText("Stok"),
                  TextFieldBorderBottom(
                    textHint: "0",
                    inputType: TextInputType.number,
                    controller: stockController,
                  ),
                  SizedBox(height: 16),
                  SmallText("Kategori"),
                  SelectionBorderBottom(
                    child: Text(category != null ? category?.name : "Pilih Kategori"),
                    onTap: () => selectCategory(),
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
            ),
            Box(
              padding: 16,
              child: RaisedButtonAccent(
                text: "Simpan",
                isLoading: isLoading,
                onPressed: () {
                  if(nameController.text == null || nameController.text == "") {
                    Toast.show("Nama harus diisi", context);
                  } else {
                    setState(() {
                      isLoading = true;
                    });
                    var data = ProductPost(
                      id: widget.product != null ? widget.product.id : "",
                      photo: null,
                      name: nameController?.text ?? "",
                      merkProduct: merkProductController?.text ?? "",
                      buyPrice: buyPriceController?.text ?? "",
                      sellPrice: sellPriceController?.text ?? "",
                      description: descriptionController?.text ?? "",
                      category: category?.value?.id ?? "",
                      stock: stockController?.text ?? "",
                    );
                    if(widget.product == null) {
                      bloc.add(CreateProduct(data: data));
                    } else {
                      bloc.add(UpdateProduct(data: data));
                    }
                  }
                }
              ),
            )
          ],
        ),
      ),
    );
  }

  Future selectCategory() async {
    Map results = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectOptions(
        title: "Pilih Bank",
        options: categories,
        selected: category,
        useFilter: true,
      )),
    );

    if (results != null && results.containsKey("data")) {
      setState(() {
        category = results["data"];
      });
    }
  }
}