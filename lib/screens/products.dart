import 'package:flutter/material.dart';


class ProductPage extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product['name'], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('Price: \$${product['price']}'),
            Text('Quantity: ${product['quantity']} available'),
            Text('Farm Location: ${product['location']}'),
            const SizedBox(height: 20),
            const Text(
              'Description:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text('Detailed description about the product goes here.'),
            // Add more widgets like images, reviews, etc., as needed.
          ],
        ),
      ),
    );
  }
}
