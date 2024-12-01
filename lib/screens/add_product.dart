import 'package:flutter/material.dart';

class AddProductPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onProductAdded;

  const AddProductPage({super.key, required this.onProductAdded});

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  String category = 'Vegetables';
  List<String> categories = ['Vegetables', 'Fruits', 'Seeds'];

  // Controllers for product info
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            //name of the product
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Product Name'),
              validator: (value) => value!.isEmpty ? 'Enter product name' : null,
            ),
            //category of the product
            DropdownButtonFormField(
              value: category,
              items: categories.map((cat) {
                return DropdownMenuItem(value: cat, child: Text(cat));
              }).toList(),
              onChanged: (value) => setState(() => category = value!),
              decoration: const InputDecoration(labelText: 'Category'),
            ),
            //price of the product
            TextFormField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? 'Enter price' : null,
            ),
            //quantity of the product
            TextFormField(
              controller: quantityController,
              decoration: const InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? 'Enter quantity' : null,
            ),
            //description of the product
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            //button to add
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final newProduct = {
                    'name': nameController.text,
                    'category': category,
                    'price': int.parse(priceController.text),
                    'quantity': int.parse(quantityController.text),
                    'description': descriptionController.text,
                    'status': 'Available', // Default status
                  };
                  widget.onProductAdded(newProduct); // Call the callback
                  Navigator.pop(context); // Go back to the dashboard
                }
              },
              child: const Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
