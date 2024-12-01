import 'package:flutter/material.dart';
import 'cart_item.dart';
import 'buyer_cart_page.dart';
import 'orders_page.dart';
import 'chat_page_buyer.dart';

class BuyerPage extends StatefulWidget {
  const BuyerPage({super.key});

  @override
  State<BuyerPage> createState() => _BuyerPageState();
}
//bottom dashboard
class _BuyerPageState extends State<BuyerPage> {
  int _currentIndex = 0;
  final List<CartItem> cartItems = [];
  final List<Map<String, dynamic>> orders = [];
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      ProductListPage(cartItems: cartItems), // Products with filtering and sorting
      CartPage(
        cartItems: cartItems,
        onCheckout: (confirmedOrder) {
          setState(() {
            orders.add(confirmedOrder);
          });
          setState(() => _currentIndex = 3); // Redirect to Orders Page
        },
      ),
      const ChatPage(), // Chat
      OrdersPage(orders: orders), // My Orders
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle()),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'My Orders',
          ),
        ],
      ),
    );
  }

  String _getAppBarTitle() {
    switch (_currentIndex) {
      case 0:
        return 'Browse Products';
      case 1:
        return 'Cart';
      case 2:
        return 'Chat';
      case 3:
        return 'My Orders';
      default:
        return 'Buyer Dashboard';
    }
  }
}

class ProductListPage extends StatefulWidget {
  final List<CartItem> cartItems;

  const ProductListPage({Key? key, required this.cartItems}) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}
//list of products
class _ProductListPageState extends State<ProductListPage> {
  final List<Map<String, dynamic>> products = [
    {'name': 'Tomatoes', 'price': 20, 'quantity': 50, 'location': 'Farm A', 'category': 'Vegetables'},
    {'name': 'Apples', 'price': 50, 'quantity': 30, 'location': 'Farm B', 'category': 'Fruits'},
    {'name': 'Wheat Seeds', 'price': 100, 'quantity': 10, 'location': 'Farm C', 'category': 'Seeds'},
  ];
  //variables for sorting and filtering
  String selectedCategory = 'All';
  List<String> categories = ['All', 'Vegetables', 'Fruits', 'Seeds'];

  double minPrice = 0;
  double maxPrice = 200;
  String selectedLocation = 'All';
  List<String> locations = ['All', 'Farm A', 'Farm B', 'Farm C'];

  String sortOrder = 'Ascending';
  List<String> sortOptions = ['Ascending', 'Descending'];

  //sorting/filtering implementation
  @override
  Widget build(BuildContext context) {
    //filtering
    List<Map<String, dynamic>> filteredProducts = products.where((product) {
      bool matchesCategory = selectedCategory == 'All' || product['category'] == selectedCategory;
      bool matchesPrice = product['price'] >= minPrice && product['price'] <= maxPrice;
      bool matchesLocation = selectedLocation == 'All' || product['location'] == selectedLocation;
      return matchesCategory && matchesPrice && matchesLocation;
    }).toList();
    //sorting
    filteredProducts.sort((a, b) {
      if (sortOrder == 'Ascending') {
        return a['price'].compareTo(b['price']);
      } else {
        return b['price'].compareTo(a['price']);
      }
    });

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              //menu for category filtering
              DropdownButton<String>(
                value: selectedCategory,
                items: categories.map((category) {
                  return DropdownMenuItem(value: category, child: Text(category));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value!;
                  });
                },
              ),
              Spacer(),
              //menu for location filtering
              DropdownButton<String>(
                value: selectedLocation,
                items: locations.map((location) {
                  return DropdownMenuItem(value: location, child: Text(location));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedLocation = value!;
                  });
                },
              ),
            ],
          ),
        ),
        //slider for sorting by price
        RangeSlider(
          values: RangeValues(minPrice, maxPrice),
          min: 0,
          max: 200,
          divisions: 20,
          labels: RangeLabels('\$${minPrice.toInt()}', '\$${maxPrice.toInt()}'),
          onChanged: (RangeValues values) {
            setState(() {
              minPrice = values.start;
              maxPrice = values.end;
            });
          },
        ),
        DropdownButton<String>(
          value: sortOrder,
          items: sortOptions.map((option) {
            return DropdownMenuItem(value: option, child: Text(option));
          }).toList(),
          onChanged: (value) {
            setState(() {
              sortOrder = value!;
            });
          },
        ),
        //list of products
        Expanded(
          child: ListView.builder(
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) {
              final product = filteredProducts[index];
              return ListTile(
                title: Text(product['name']),
                subtitle: Text('Price: \$${product['price']} | Location: ${product['location']}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductPage(product: product),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class ProductPage extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['name']),
      ),
      body: Center(
        child: Text('Detailed View for ${product['name']}'),
      ),
    );
  }
}
