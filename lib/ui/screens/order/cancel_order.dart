import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kedatonkomputer/core/bloc/order/order_bloc.dart';
import 'package:kedatonkomputer/core/bloc/order/order_event.dart';
import 'package:kedatonkomputer/core/bloc/order/order_state.dart';
import 'package:kedatonkomputer/core/models/order_model.dart';
import 'package:kedatonkomputer/ui/widget/button.dart';
import 'package:kedatonkomputer/ui/widget/form.dart';
import 'package:toast/toast.dart';

class CancelOrderPage extends StatefulWidget {

  const CancelOrderPage({
    Key key,
    this.order,
    this.bloc,
  }) : super(key: key);
  
  final OrderModel order;
  final OrderBloc bloc;

  @override
  _CancelOrderPageState createState() => _CancelOrderPageState();
}

class _CancelOrderPageState extends State<CancelOrderPage> {

  var controller = TextEditingController();
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: widget.bloc,
      listener: (context, state) {
        if(state is OrderConfirmated) {
          Navigator.pop(context);
        } else if(state is OrderFailure) {
          setState(() {
            isLoading = false;
            Toast.show(state.error, context);
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Tolak Orderan")
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: TextAreaBorderBottom(
                    textHint: "Tulis alasan dibatalkan",
                    minLines: 10,
                    controller: controller,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: RaisedButtonPrimary(
                  text: "Tolak Orderan",
                  isLoading: isLoading,
                  onPressed: isLoading ? null : () {
                    if(controller.text == null || controller.text == ""){
                      Toast.show("Isi alasan dulu", context);
                    } else {
                      setState(() {
                        isLoading = true;
                      });
                      widget.bloc.add(ConfirmOrder(
                        id: widget.order.id, 
                        cancelReason: controller.text,
                        status: "terima"
                      ));
                    }
                  }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}