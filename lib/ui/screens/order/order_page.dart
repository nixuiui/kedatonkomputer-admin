import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indonesia/indonesia.dart';
import 'package:kedatonkomputer/core/bloc/order/order_bloc.dart';
import 'package:kedatonkomputer/core/bloc/order/order_event.dart';
import 'package:kedatonkomputer/core/bloc/order/order_state.dart';
import 'package:kedatonkomputer/core/models/order_model.dart';
import 'package:kedatonkomputer/ui/screens/order/order_detail.dart';
import 'package:kedatonkomputer/ui/widget/box.dart';
import 'package:kedatonkomputer/ui/widget/button.dart';
import 'package:kedatonkomputer/ui/widget/loading.dart';
import 'package:kedatonkomputer/ui/widget/text.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

  var bloc = OrderBloc();
  var orders = <OrderModel>[];
  var isLoading = true;

  @override
  void initState() {
    bloc.add(LoadMyOrders());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: bloc,
      listener: (context, state) {
        if(state is OrderLoaded) {
          setState(() {
            orders = state.data;
            isLoading = false;
          });
        } else if(state is OrderFailure) {
          setState(() {
            isLoading = false;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Riwayat Order"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: isLoading ? Center(child: LoadingCustom()) : ListView.separated(
                itemCount: orders.length,
                separatorBuilder: (context, index) => Divider(height: 0), 
                itemBuilder: (context, index) => Box(
                  padding: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Box(
                            width: 60,
                            height: 60,
                            image: NetworkImage(orders[index].detailProducts[0].product.images[0]),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(orders[index].detailProducts[0].product.name),
                                TextCustom(
                                  rupiah(orders[index].totalPrice),
                                  fontSize: 16,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w600,
                                ),
                                LabelText(orders[index]?.statusTransaction?.replaceAll("-", " ")?.toUpperCase() ?? ""),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          RaisedButtonCustom(
                            padding: 0,
                            radius: 4,
                            text: "Detail",
                            onPressed: () => Navigator.push(context, MaterialPageRoute(
                              builder: (context) => OrderDetailPage(id: orders[index].id)
                            )).then((value) => bloc.add(LoadMyOrders()))
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}