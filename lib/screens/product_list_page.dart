import 'package:flutter/material.dart';
import 'cart_item.dart';

class ProductListPage extends StatefulWidget {
  final List<CartItem> cartItems;

  const ProductListPage({Key? key, required this.cartItems}) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final List<Map<String, dynamic>> products = [
    {'name': 'Tomatoes', 'price': 20.0, 'quantity': 50},
    {'name': 'Apples', 'price': 50.0, 'quantity': 30},
    {'name': 'Wheat Seeds', 'price': 100.0, 'quantity': 10},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Card(
          margin: const EdgeInsets.all(8),
          child: ListTile(
            title: Text(product['name']),
            subtitle: Text('Price: \$${product['price']}'),
            trailing: ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.cartItems.add(
                    CartItem(
                      name: product['name'],
                      price: product['price'],
                      quantity: 1,
                    ),
                  );
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${product['name']} added to cart!')),
                );
              },
              child: const Text('Add to Cart'),
            ),
          ),
        );
      },
    );
  }
}
