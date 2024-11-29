import 'package:flutter/material.dart';
import 'order_tracking.dart'; // Import the Order Tracking Page


class OrdersPage extends StatelessWidget {
  final List<Map<String, dynamic>> orders;

  const OrdersPage({Key? key, required this.orders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text('Order ID: ${order['id']}'),
              subtitle: Text('Status: ${order['status']}'),
              trailing: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderTrackingPage(
                        orderId: order['id']!,
                        orderStatus: order['status']!, // Pass the order status
                      ),
                    ),
                  );
                },
                child: const Text('Track Order'),
              ),
            ),
          );
        },
      ),
    );
  }
}

