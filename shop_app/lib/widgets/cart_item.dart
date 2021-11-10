import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final double price;
  final String title;
  final int quantity;
  final String id;

  CartItem(
    this.id,
    this.title,
    this.price,
    this.quantity,
  );
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        child: ListTile(
          leading: CircleAvatar(child: Text('{$price}')),
          title: Text(title),
          subtitle: Text('Total : ${price * quantity}'),
          trailing: Text('$quantity x'),
        ),
      ),
    );
  }
}
