import 'package:flutter/material.dart';
import 'add_product.dart';
import 'edit_product.dart';

class FarmerDashboard extends StatefulWidget {
  const FarmerDashboard({super.key});

  @override
  _FarmerDashboardState createState() => _FarmerDashboardState();
}

class _FarmerDashboardState extends State<FarmerDashboard> {
  List<Map<String, dynamic>> products = [
    {'name': 'Tomatoes', 'category': 'Vegetables', 'price': 20, 'quantity': 50, 'status': 'Available'},
    {'name': 'Apples', 'category': 'Fruits', 'price': 50, 'quantity': 30, 'status': 'Available'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Farmer Dashboard')),
      body: ListView.builder(
        //list of products:
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product['name']),
            subtitle: Text('Category: ${product['category']} | Quantity: ${product['quantity']}'),
            trailing: Text('\$${product['price']}'),
            //function to edit the product info
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProductPage(
                    product: product,
                    onProductUpdated: (updatedProduct) {
                      setState(() {
                        products[index] = updatedProduct; //update the product
                      });
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      //button to add products
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProductPage(
                onProductAdded: (newProduct) {
                  setState(() {
                    products.add(newProduct); //add a new product to the list
                  });
                },
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
