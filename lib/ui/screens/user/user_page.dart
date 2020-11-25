import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kedatonkomputer/core/bloc/user/user_bloc.dart';
import 'package:kedatonkomputer/core/bloc/user/user_event.dart';
import 'package:kedatonkomputer/core/bloc/user/user_state.dart';
import 'package:kedatonkomputer/core/models/user_model.dart';
import 'package:kedatonkomputer/ui/screens/user/user_detail.dart';
import 'package:kedatonkomputer/ui/widget/box.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  var bloc = UserBloc();
  var users = <User>[];

  @override
  void initState() {
    refresh();
    super.initState();
  }

  refresh() {
    bloc.add(LoadUsers(isRefresh: true));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: bloc,
      listener: (context, state) {
        if(state is UserLoaded) {
          setState(() {
            users = state.data;
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("User"),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: users.length,
                  separatorBuilder: (context, index) => Divider(height: 0), 
                  itemBuilder: (context, index) => Row(
                    children: [
                      Expanded(
                        child: Box(
                          padding: 16,
                          child: Text(users[index].name),
                          onPressed: () => Navigator.push(context, MaterialPageRoute(
                            builder: (context) => UserDetailPage(user: users[index])
                          )),
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.all(16),
                        icon: Icon(Icons.delete, color: Colors.red), 
                        onPressed: (){
                          setState(() {
                            bloc.add(DeleteUser(id: users[index].id));
                            users.removeAt(index);
                          });
                        }
                      )
                    ],
                  ), 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}