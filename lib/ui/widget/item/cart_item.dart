import 'package:flutter/material.dart';
import 'package:indonesia/indonesia.dart';
import 'package:kedatonkomputer/core/models/cart_model.dart';
import 'package:kedatonkomputer/helper/app_consts.dart';
import 'package:kedatonkomputer/ui/widget/box.dart';
import 'package:kedatonkomputer/ui/widget/loading.dart';
import 'package:kedatonkomputer/ui/widget/text.dart';

class CartItem extends StatefulWidget {
  const CartItem({
    Key key,
    this.cart,
    this.isDeleting = false,
    this.onDelete,
    this.onUpdate,
  }) : super(key: key);

  final Cart cart;
  final bool isDeleting;
  final VoidCallback onDelete;
  final VoidCallback onUpdate;

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  
  Cart cart;

  @override
  void initState() {
    cart = widget.cart;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Box(
      borderRadius: 8,
      boxShadow: [AppBoxShadow.type3],
      padding: 16,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Box(
            width: 60,
            height: 60,
            color: Colors.grey[200],
            image: NetworkImage(cart?.product?.images[0] ?? ""),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BoldText(cart?.product?.name ?? ""),
                SmallText("${rupiah((cart?.product?.sellPrice ?? 0) * (cart?.quantity ?? 0))}"),
              ],
            ),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Box(
                    width: 25,
                    height: 25,
                    color: Colors.grey[200],
                    child: Center(child: Text("-"))
                  ),
                  Box(
                    width: 25,
                    height: 25,
                    color: Colors.white,
                    child: Center(child: Text("${cart?.quantity ?? 0}"))
                  ),
                  Box(
                    width: 25,
                    height: 25,
                    color: Colors.grey[200],
                    child: Center(child: Text("-"))
                  ),
                ],
              ),
              SizedBox(height: 16),
              widget.isDeleting ? LoadingCustom(size: 12) : GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: widget.onDelete,
                child: Icon(Icons.delete, color: Colors.grey)
              )
            ],
          ),
        ],
      ),
    );
  }
}