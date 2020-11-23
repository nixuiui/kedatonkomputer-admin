import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indonesia/indonesia.dart';
import 'package:kedatonkomputer/core/bloc/order/order_bloc.dart';
import 'package:kedatonkomputer/core/bloc/order/order_event.dart';
import 'package:kedatonkomputer/core/bloc/order/order_state.dart';
import 'package:kedatonkomputer/core/models/order_model.dart';
import 'package:kedatonkomputer/ui/screens/camera_page.dart';
import 'package:kedatonkomputer/ui/screens/order/cancel_order.dart';
import 'package:kedatonkomputer/ui/screens/select_from_gallery.dart';
import 'package:kedatonkomputer/ui/widget/box.dart';
import 'package:kedatonkomputer/ui/widget/button.dart';
import 'package:kedatonkomputer/ui/widget/loading.dart';
import 'package:kedatonkomputer/ui/widget/text.dart';
import 'package:toast/toast.dart';

class OrderDetailPage extends StatefulWidget {

  const OrderDetailPage({
    Key key,
    this.order,
  }) : super(key: key);
  
  final OrderModel order;

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {

  var bloc = OrderBloc();
  OrderModel order;
  var isAccepting = false;
  var isUploadingPhoto = false;

  @override
  void initState() {
    order = widget.order;
    bloc.add(LoadDetailOrder(id: order.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener(
          cubit: bloc,
          listener: (context, state) {
            if(state is OrderDetailLoaded) {
              print("OrderDetailLoaded");
              setState(() {
                isAccepting = false;
                isUploadingPhoto = false;
                order = state.data;
              });
            } else if(state is OrderConfirmated) {
              bloc.add(LoadDetailOrder(id: order.id));
              print("OrderConfirmated");
            } else if(state is OrderReceived) {
              print("OrderReceived");
              bloc.add(LoadDetailOrder(id: order.id));
            } else if(state is OrderFailure) {
              print("OrderFailure");
              setState(() {
                isAccepting = false;
                isUploadingPhoto = false;
              });
            }
          }
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text("Detail Order"),
        ),
        body: ListView(
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: order.detailProducts.length,
              separatorBuilder: (context, index) => Divider(height: 0), 
              itemBuilder: (context, index) => Box(
                padding: 16,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (order?.detailProducts[index]?.product?.images?.length ?? 0) > 0 ? Container(
                      margin: EdgeInsets.only(right: 16),
                      child: Box(
                        width: 60,
                        height: 60,
                        image: NetworkImage(order?.detailProducts[index]?.product?.images[0] ?? ""),
                      ),
                    ) : Container(),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextCustom(
                            order?.detailProducts[index]?.product?.name ?? "",
                            maxLines: 3,
                          ),
                          SmallText("${order?.detailProducts[index]?.count ?? ''}x"),
                          TextCustom("${rupiah(order?.detailProducts[index]?.price ?? '')}"),
                        ],
                      )
                    ),
                  ],
                ),
              ), 
            ),
            Divider(height: 0),
            SizedBox(height: 16),
            Divider(height: 0),
            Box(
              padding: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, 
                children: [
                  LabelText("Metode Pembayaran"),
                  TextCustom(order?.paymentMethod?.toUpperCase() ?? ""),
                  SizedBox(height: 12),
                  LabelText("Status"),
                  TextCustom(order?.statusTransaction?.toUpperCase()?.replaceAll("-", " ") ?? ""),
                  SizedBox(height: 12),
                  LabelText("Total Bayar"),
                  TextCustom(rupiah(order?.totalPrice)),
                  SizedBox(height: 12),
                  LabelText("Catatan"),
                  TextCustom(order?.orderNotes ?? "-"),
                  order?.cancelReason != null && order?.cancelReason != "" ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 12),
                      LabelText("Alasan Dibatalkan"),
                      TextCustom(order?.cancelReason ?? "-"),
                    ],
                  ) : Container(),
                ],
              )
            ),
            Divider(height: 0),
            SizedBox(height: 16),
            order?.statusTransaction == "menunggu-konfirmasi" ? Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: RaisedButtonCustom(
                      text: "Tolak",
                      color: Colors.red,
                      onPressed: () => Navigator.push(context, MaterialPageRoute(
                        builder: (context) => CancelOrderPage(order: order, bloc: bloc)
                      )),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: RaisedButtonPrimary(
                      text: "Terima",
                      isLoading: isAccepting,
                      onPressed: () {
                        setState(() {
                          isAccepting = true;
                        });
                        bloc.add(ConfirmOrder(id: order?.id, status: "terima", cancelReason: ""));
                      },
                    ),
                  ),
                ],
              ),
            ) : Container(),
            order?.statusTransaction == "menunggu-kedatangan" ? Column(
              children: [
                Divider(height: 0),
                Box(
                  padding: 16,
                  child: Column(
                    children: [
                      TextCustom("Konfirmasi barang sudah sampai ke konsumen"),
                      SizedBox(height: 16),
                      isUploadingPhoto ? LoadingCustom() : Row(
                        children: [
                          Expanded(
                            child: RaisedButtonCustom(
                              icon: Icons.camera_alt,
                              text: "Ambil Foto",
                              color: Colors.white,
                              borderColor: Colors.grey[300],
                              radius: 50,
                              textColor: Colors.black87,
                              iconColor: Colors.black87,
                              onPressed: () => takePicture(),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: RaisedButtonCustom(
                              icon: Icons.image,
                              text: "Dari Gallery",
                              color: Colors.white,
                              borderColor: Colors.grey[300],
                              radius: 50,
                              textColor: Colors.black87,
                              iconColor: Colors.black87,
                              onPressed: () => selectFromGallery(),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ),
                Divider(height: 0),
              ],
            ) : Container()
          ],
        ),
      ),
    );
  }

  Future takePicture() async {
    Map results = await Navigator.push(context, MaterialPageRoute(
      builder: (context) => CameraPage(
        selectedCameraIdx: 1, 
        scale: 1/1,
        subtitle: "Foto Profil",
        flipable: true,
      )
    ));

    if (results != null && results.containsKey("data")) {
      File file = results["data"];
      if(file.lengthSync() > 2000000) {
        Toast.show("Size gambar tidak boleh melebihi 2MB", context);
      } else {
        setState(() {
          isUploadingPhoto = true;
        });
        bloc.add(ReceiveOrder(order: order?.id, proofItemReceived: file));
      }
    }
  }
  
  Future selectFromGallery() async {
    Map results = await Navigator.push(context, MaterialPageRoute(
      builder: (context) => SelectFromGallery()
    ));

    if (results != null && results.containsKey("file")) {
      File file = results["file"];
      if(file.lengthSync() > 2000000) {
        Toast.show("Size gambar tidak boleh melebihi 2MB", context);
      } else {
        setState(() {
          isUploadingPhoto = true;
        });
        bloc.add(ReceiveOrder(order: order?.id, proofItemReceived: file));
      }
    }
  }
}