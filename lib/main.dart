// import 'package:shared_preferences/shared_preferences.dart';
import 'screens/buyer_reg.dart';
import 'screens/farmer_reg.dart';
import 'screens/farmer.dart';
import 'screens/buyer.dart';
import 'dart:convert';  // For encoding and decoding JSON
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';




void main() {
  runApp(const MyApp()); // This line initializes the app
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),  // The LoginPage will be the starting page
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // API endpoint URL for login
  final String apiUrl =
      "https://farmersmarketapi-e0c4d5dpc7e7fwbd.northeurope-01.azurewebsites.net/api/v1/Authenticate/login";

  Future<void> login() async {
    // Get the values entered by the user
    String username = nameController.text;
    String password = passwordController.text;

    // Check if the fields are not empty
    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both username and password')),
      );
      return;
    }

    // Create the request payload
    Map<String, String> body = {
      'username': username,
      'password': password,
    };

    // Send POST request to the API
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: json.encode(body),
        headers: {'Content-Type': 'application/json', 'accept': '*/*'},
      );

      // Check if the response is successful
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Response Data: $data'); // Debugging

        // Check if the token exists in the response to validate success
        if (data['token'] != null) {
          // If token exists, consider login successful
          if (data['roles'][0] == 'Farmer') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (
                  context) => const FarmerDashboard()), // Or FarmerDashboard(), depending on your response
            );
          }
          else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (
                  context) => const BuyerPage()), // Or FarmerDashboard(), depending on your response
            );
          }
        } else {
          // If token doesn't exist, show error
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid credentials')),
          );
        }
      } else {
        // Handle server error or failure
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to connect to the server')),
        );
      }
    } catch (e) {
      // Handle any errors (e.g., network errors)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            shrinkWrap: true,
            children: [
              const Text('Username'),
              const SizedBox(height: 5),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Name',
                ),
              ),
              const SizedBox(height: 10),
              const Text('Password'),
              const SizedBox(height: 5),
              TextField(
                controller: passwordController,
                obscureText: true, // Hide the password text
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Password',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Call login function when button is pressed
                  login();
                },
                child: const Text(
                  'Log in',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              const SizedBox(height: 10),
              const Text('Don\'t have an account?'),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FarmerRegisterPage()),
                  );
                },
                child: const Text(
                  'Register as a Farmer',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BuyerRegisterPage()),
                  );
                },
                child: const Text(
                  'Register as a Buyer',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

