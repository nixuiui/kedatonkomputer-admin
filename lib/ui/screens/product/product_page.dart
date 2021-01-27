import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kedatonkomputer/core/bloc/product/product_bloc.dart';
import 'package:kedatonkomputer/core/bloc/product/product_event.dart';
import 'package:kedatonkomputer/core/bloc/product/product_state.dart';
import 'package:kedatonkomputer/core/models/product_model.dart';
import 'package:kedatonkomputer/ui/screens/product/product_form.dart';
import 'package:kedatonkomputer/ui/widget/box.dart';
import 'package:kedatonkomputer/ui/widget/button.dart';
import 'package:kedatonkomputer/ui/widget/form.dart';
import 'package:kedatonkomputer/ui/widget/loading.dart';
import 'package:kedatonkomputer/ui/widget/text.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  var bloc = ProductBloc();
  var products = <Product>[];
  var isStarting = true;

  var controller = TextEditingController();

  @override
  void initState() {
    refresh();
    super.initState();
  }

  refresh() {
    bloc.add(LoadProducts(
      isRefresh: true,
      search: controller?.text ?? ""
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: bloc,
      listener: (context, state) {
        if(state is ProductLoaded) {
          setState(() {
            isStarting = false;
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextFieldBox(
                      textHint: "Cari Produk",
                      backgroundColor: Colors.white,
                      borderColor: Colors.white,
                      controller: controller,
                      onFieldSubmitted: (value) {
                        controller?.text = value;
                        refresh();
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        isStarting = true;
                      });
                      refresh();
                    },
                  )
                ],
              ),
              Divider(),
              Expanded(
                child: isStarting ? LoadingCustom() : ListView.separated(
                  itemCount: products.length,
                  separatorBuilder: (context, index) => Divider(height: 0), 
                  itemBuilder: (context, index) => Row(
                    children: [
                      Expanded(
                        child: Box(
                          padding: 16,
                          onPressed: () => Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ProductForm(product: products[index])
                          )).then((value) => bloc.add(LoadProducts(isRefresh: true))),
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(products[index].name),
                                    LabelText(products[index]?.category?.name ?? ""),
                                  ],
                                )
                              ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.all(16),
                        icon: Icon(Icons.delete, color: Colors.red), 
                        onPressed: (){
                          setState(() {
                            bloc.add(DeleteProduct(id: products[index].id));
                            products.removeAt(index);
                          });
                        }
                      )
                    ],
                  ), 
                ),
              ),
              Box(
                padding: 16,
                child: RaisedButtonAccent(
                  text: "Tambah Produk",
                  onPressed: () => Navigator.push(context, MaterialPageRoute(
                    builder: (context) => ProductForm()
                  )).then((value) => bloc.add(LoadProducts(isRefresh: true)))
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}