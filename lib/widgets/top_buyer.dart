import 'package:ecommerce_admin_tut/models/orders.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'custom_text.dart';

class TopBuyerWidget extends StatelessWidget {
  final OrderModel orderModel;
  TopBuyerWidget({this.orderModel});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        orderModel.id.toString(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(DateFormat.yMMMd()
          .format(DateTime.fromMillisecondsSinceEpoch(orderModel.createdAt))),
      trailing: CustomText(
        text: "Npr. " + ' ${orderModel.total}',
        color: Colors.green.shade800,
        weight: FontWeight.bold,
      ),
    );
  }
}
