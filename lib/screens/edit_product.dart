import 'package:flutter/material.dart';

class EditProductPage extends StatefulWidget {
  final Map<String, dynamic> product;
  final Function(Map<String, dynamic>) onProductUpdated;

  const EditProductPage({super.key, required this.product, required this.onProductUpdated});

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
  late String category;
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController quantityController;
  late TextEditingController descriptionController;

  List<String> categories = ['Vegetables', 'Fruits', 'Seeds'];

  @override
  //controllers for editing product info
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.product['name']);
    priceController = TextEditingController(text: widget.product['price'].toString());
    quantityController = TextEditingController(text: widget.product['quantity'].toString());
    descriptionController = TextEditingController(text: widget.product['description'] ?? '');
    category = widget.product['category'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Product')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            //edit name of the product
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Product Name'),
              validator: (value) => value!.isEmpty ? 'Enter product name' : null,
            ),
            //edit category of the product
            DropdownButtonFormField(
              value: category,
              items: categories.map((cat) {
                return DropdownMenuItem(value: cat, child: Text(cat));
              }).toList(),
              onChanged: (value) => setState(() => category = value!),
              decoration: const InputDecoration(labelText: 'Category'),
            ),
            //edit price of the product
            TextFormField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? 'Enter price' : null,
            ),
            //edit quantity of the product
            TextFormField(
              controller: quantityController,
              decoration: const InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? 'Enter quantity' : null,
            ),
            //edit product description
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            //button to save changes
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final updatedProduct = {
                    'name': nameController.text,
                    'category': category,
                    'price': int.parse(priceController.text),
                    'quantity': int.parse(quantityController.text),
                    'description': descriptionController.text,
                    'status': widget.product['status'], // Keep the existing status
                  };
                  widget.onProductUpdated(updatedProduct); // Call the callback
                  Navigator.pop(context); // Go back to the dashboard
                }
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
