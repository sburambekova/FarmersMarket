import 'package:flutter/material.dart';
import 'buyer.dart'; // Adjust this path
import 'order_placement.dart';
import 'order_confirmation.dart';
import 'cart_item.dart';

class CartPage extends StatelessWidget {
  final List<CartItem> cartItems;
  final Function(Map<String, dynamic>) onCheckout;

  const CartPage({super.key, required this.cartItems, required this.onCheckout});

  double calculateTotal() {
    return cartItems.fold(0, (total, item) => total + (item.price * item.quantity));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body: cartItems.isEmpty
          ? const Center(child: Text('Your cart is empty!'))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text('Quantity: ${item.quantity} | Price: \$${item.price}'),
                  trailing: Text('Total: \$${(item.price * item.quantity).toStringAsFixed(2)}'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total: \$${calculateTotal().toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final order = {
                'id': DateTime.now().millisecondsSinceEpoch.toString(),
                'status': 'Processing',
                'items': cartItems.map((item) => item.name).toList(),
                'total': calculateTotal(),
              };
              onCheckout(order); // Pass order back to BuyerPage
            },
            child: const Text('Proceed to Checkout'),
          ),
        ],
      ),
    );
  }
}
