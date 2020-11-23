import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kedatonkomputer/core/bloc/category/category_bloc.dart';
import 'package:kedatonkomputer/core/bloc/category/category_event.dart';
import 'package:kedatonkomputer/core/bloc/category/category_state.dart';
import 'package:kedatonkomputer/core/models/category_model.dart';
import 'package:kedatonkomputer/ui/widget/box.dart';
import 'package:kedatonkomputer/ui/widget/button.dart';
import 'package:kedatonkomputer/ui/widget/form.dart';
import 'package:kedatonkomputer/ui/widget/text.dart';
import 'package:toast/toast.dart';

class CategoryForm extends StatefulWidget {

  const CategoryForm({
    Key key,
    this.category,
  }) : super(key: key);
  
  final Category category;

  @override
  _CategoryFormState createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {

  var nameController = TextEditingController();
  var bloc = CategoryBloc();
  var isLoading = false;

  @override
  void initState() {
    if(widget.category != null) {
      nameController.text = widget.category.name;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: bloc,
      listener: (context, state) {
        if(state is CategoryCreated) {
          setState(() {
            isLoading = false;
            Navigator.pop(context);
          });
        } else if(state is CategoryUpdated) {
          setState(() {
            isLoading = false;
            Navigator.pop(context);
          });
        } else if(state is CategoryFailure) {
          setState(() {
            isLoading = false;
          });
        }
      },
      child: Scaffold(
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
                    controller: nameController,
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
                    if(widget.category == null) {
                      bloc.add(CreateCategory(name: nameController.text));
                    } else {
                      bloc.add(UpdateCategory(name: nameController.text, id: widget.category.id));
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
}