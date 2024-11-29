import 'package:flutter/material.dart';
import 'cart_item.dart';  // Import only what's necessary

class OrderConfirmationPage extends StatelessWidget {
  final List<CartItem> cartItems;
  final double total;
  final String address;

  // Constructor to accept cartItems, total, and address
  const OrderConfirmationPage({
    Key? key,
    required this.cartItems,
    required this.total,
    required this.address
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Confirmation'),
      ),
      body: Column(
        children: [
          // List of cart items
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text('Quantity: ${item.quantity} | Price: \$${item.price}'),
                );
              },
            ),
          ),

          // Display total price
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total: \$${total.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          // Display delivery address
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Delivery Address: $address',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),

          // Confirm order button
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Navigate back to the previous page
            },
            child: const Text('Confirm Order'),
          ),
        ],
      ),
    );
  }
}

