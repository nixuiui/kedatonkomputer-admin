import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kedatonkomputer/core/bloc/category/category_bloc.dart';
import 'package:kedatonkomputer/core/bloc/category/category_event.dart';
import 'package:kedatonkomputer/core/bloc/category/category_state.dart';
import 'package:kedatonkomputer/core/models/category_model.dart';
import 'package:kedatonkomputer/ui/screens/category/category_form.dart';
import 'package:kedatonkomputer/ui/widget/box.dart';
import 'package:kedatonkomputer/ui/widget/button.dart';
import 'package:kedatonkomputer/ui/widget/loading.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  var bloc = CategoryBloc();
  var categories = <Category>[];
  var isStarting = true;

  @override
  void initState() {
    refresh();
    super.initState();
  }

  refresh() {
    bloc.add(LoadCategories());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: bloc,
      listener: (context, state) {
        if(state is CategoryLoaded) {
          setState(() {
            isStarting = false;
            categories = state.data;
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
                child: isStarting ? LoadingCustom() : ListView.separated(
                  itemCount: categories.length,
                  separatorBuilder: (context, index) => Divider(height: 0), 
                  itemBuilder: (context, index) => Row(
                    children: [
                      Expanded(
                        child: Box(
                          padding: 16,
                          onPressed: () => Navigator.push(context, MaterialPageRoute(
                            builder: (context) => CategoryForm(category: categories[index])
                          )).then((value) => bloc.add(LoadCategories())),
                          child: Text(categories[index].name),
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.all(16),
                        icon: Icon(Icons.delete, color: Colors.red), 
                        onPressed: (){
                          setState(() {
                            bloc.add(DeleteCategory(id: categories[index].id));
                            categories.removeAt(index);
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
                  text: "Tambah Kategori",
                  onPressed: () => Navigator.push(context, MaterialPageRoute(
                    builder: (context) => CategoryForm()
                  )).then((value) => bloc.add(LoadCategories()))
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}