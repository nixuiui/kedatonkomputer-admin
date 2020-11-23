import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kedatonkomputer/core/bloc/product/product_bloc.dart';
import 'package:kedatonkomputer/core/bloc/product/product_event.dart';
import 'package:kedatonkomputer/core/bloc/product/product_state.dart';
import 'package:kedatonkomputer/core/models/product_model.dart';
import 'package:kedatonkomputer/ui/screens/product/product_form.dart';
import 'package:kedatonkomputer/ui/widget/box.dart';
import 'package:kedatonkomputer/ui/widget/button.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  var bloc = ProductBloc();
  var products = <Product>[];

  @override
  void initState() {
    refresh();
    super.initState();
  }

  refresh() {
    bloc.add(LoadProducts(isRefresh: true));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: bloc,
      listener: (context, state) {
        if(state is ProductLoaded) {
          setState(() {
            products = state.data;
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Produk"),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: products.length,
                  separatorBuilder: (context, index) => Divider(height: 0), 
                  itemBuilder: (context, index) => Box(
                    padding: 16,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Box(
                          width: 40,
                          height: 40,
                          color: Colors.grey[200],
                          image: NetworkImage(products[index].images.length > 0 ? products[index].images[0] : ""),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Text(products[index].name)
                        ),
                      ],
                    ),
                  ), 
                ),
              ),
              Box(
                padding: 16,
                child: RaisedButtonAccent(
                  text: "Tambah Produk",
                  onPressed: () => Navigator.push(context, MaterialPageRoute(
                    builder: (context) => ProductForm()
                  ))
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}