import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/orders_provider.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem orders;
  OrderItem(this.orders);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expand = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.orders.total}'),
            subtitle: Text(
              DateFormat('dd/MM/yyyy HH:MM').format(widget.orders.date),
            ),
            trailing: IconButton(
              icon: _expand
                  ? const Icon(Icons.expand_less)
                  : const Icon(Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expand = !_expand;
                });
              },
            ),
          ),
          if (_expand)
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                height: min(widget.orders.product.length * 20.0 + 10, 180),
                child: ListView(
                  children: widget.orders.product
                      .map((prod) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                prod.title,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text('${prod.quantity} x \$${prod.price}',
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ))
                      .toList(),
                )),
        ],
      ),
    );
  }
}
