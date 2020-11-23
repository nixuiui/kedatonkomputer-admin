import 'package:flutter/material.dart';
import 'package:indonesia/indonesia.dart';
import 'package:kedatonkomputer/core/models/product_model.dart';
import 'package:kedatonkomputer/helper/app_consts.dart';
import 'package:kedatonkomputer/ui/widget/box.dart';
import 'package:kedatonkomputer/ui/widget/text.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key key,
    @required this.product,
    this.onPressed,
  }) : super(key: key);

  final Product product;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Box(
      boxShadow: [AppBoxShadow.type3],
      borderRadius: 8,
      onPressed: onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1/1,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8)
              ),
              child: Box(
                color: Colors.grey[300],
                image: NetworkImage(product.images.length > 0 ? product?.images[0] : ""),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextCustom(
                  product?.name ?? "",
                  maxLines: 2,
                  fontWeight: FontWeight.w600,
                ),
                Text(rupiah(product?.sellPrice ?? 0)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}