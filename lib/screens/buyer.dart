import 'package:flutter/material.dart';
import 'products.dart';
import 'buyer_cart_page.dart';
import 'orders_page.dart';
import 'chat_page_buyer.dart';
import 'cart_item.dart';
import 'product_list_page.dart';
import 'order_confirmation.dart'; // Import ConfirmationPage

class BuyerPage extends StatefulWidget {
  const BuyerPage({super.key});

  @override
  State<BuyerPage> createState() => _BuyerPageState();
}

class _BuyerPageState extends State<BuyerPage> {
  int _currentIndex = 0;
  final List<CartItem> cartItems = []; // Shared cart items
  final List<Map<String, dynamic>> orders = []; // Shared orders list

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      ProductListPage(cartItems: cartItems), // Products
      CartPage(
        cartItems: cartItems,
        onCheckout: (confirmedOrder) {
          setState(() {
            orders.add(confirmedOrder);
          });
          setState(() => _currentIndex = 3); // Redirect to Orders Page
        },
      ), // Cart
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


