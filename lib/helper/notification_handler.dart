import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kedatonkomputer/ui/screens/home_page.dart';
import 'package:kedatonkomputer/ui/screens/order/order_detail.dart';

class NotificationHandler {
    Map<String, dynamic> message;
    NotificationHandler({
        this.message
    });
    Widget pageDirection() {
      return pageDirectionFromNotification(this.getType(), this.getId());
    }
    String getId() =>  Platform.isAndroid ? this.message['data']['_id'].toString() : this.message['_id'].toString();
    String getTitle() => Platform.isAndroid ? this.message['data']['title'].toString() : this.message['title'].toString();
    String getType() => Platform.isAndroid ? this.message['data']['type'].toString() : this.message['type'].toString();
}

Widget pageDirectionFromNotification(String type, String id) {
  switch (type) {
    case "order":
        return OrderDetailPage(id: id);
    default:
        return HomePage();
  }
}