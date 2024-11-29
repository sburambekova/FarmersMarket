import 'package:flutter/material.dart';
import 'cart_item.dart';

import 'package:flutter/material.dart';

class OrderTrackingPage extends StatelessWidget {
  final String orderId;
  final String orderStatus;

  const OrderTrackingPage({super.key, required this.orderId, required this.orderStatus});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order Tracking: $orderId')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Current Status: $orderStatus',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add logic to refresh the order status
              },
              child: const Text('Refresh Status'),
            ),
          ],
        ),
      ),
    );
  }
}

