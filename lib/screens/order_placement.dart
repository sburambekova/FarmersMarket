import 'package:flutter/material.dart';
import 'buyer.dart';
import 'order_confirmation.dart';
import 'cart_item.dart';


class OrderPlacementPage extends StatefulWidget {
  final List<CartItem> cartItems;

  const OrderPlacementPage({Key? key, required this.cartItems}) : super(key: key);

  @override
  State<OrderPlacementPage> createState() => _OrderPlacementPageState();
}

class _OrderPlacementPageState extends State<OrderPlacementPage> {
  final TextEditingController addressController = TextEditingController();
  String selectedPaymentMethod = 'Credit Card'; // Default payment method
  final List<String> paymentMethods = ['Credit Card', 'PayPal', 'Cash on Delivery'];

  @override
  Widget build(BuildContext context) {
    double total = widget.cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Placement'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Delivery Address:', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(hintText: 'Enter your delivery address'),
            ),
            const SizedBox(height: 20),
            const Text('Payment Method:', style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: selectedPaymentMethod,
              items: paymentMethods.map((method) {
                return DropdownMenuItem(value: method, child: Text(method));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedPaymentMethod = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            const Text('Order Summary:', style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: widget.cartItems.length,
                itemBuilder: (context, index) {
                  final item = widget.cartItems[index];
                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text('Quantity: ${item.quantity} | Price: \$${item.price}'),
                    trailing: Text('Total: \$${(item.price * item.quantity).toStringAsFixed(2)}'),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Total: \$${total.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (addressController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a delivery address.')),
                  );
                  return;
                }

                // Navigate to Order Confirmation
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderConfirmationPage(
                      cartItems: widget.cartItems,  // Pass the correct cartItems
                      total: total,  // Pass the correct total
                      address: addressController.text,  // Pass the address entered by user
                    ),
                  ),
                );
              },
              child: const Text('Confirm Order'),
            ),
          ],
        ),
      ),
    );
  }
}

