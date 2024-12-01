import 'package:market/main.dart';
import 'package:flutter/material.dart';
import 'package:market/screens/farmer.dart';

class FarmerRegisterPage extends StatefulWidget {
  const FarmerRegisterPage({super.key});

  @override
  State<FarmerRegisterPage> createState() => _FarmerRegisterPageState();
}

class _FarmerRegisterPageState extends State<FarmerRegisterPage> {
  //controllers for registration info
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController middlenameController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farmer Registration Page'),
      ),
      //for the form to be in center
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            shrinkWrap: true,
            children: [
              //username text field
              const Text('Username'),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Name',
                ),
              ),
              //some space between name and email
              const SizedBox(
                height: 10,
              ),
              //first name text field
              const Text('First Name'),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: firstnameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter First Name',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              //middle name text field
              const Text('Middle name'),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: middlenameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter middle name',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              //last name text field
              const Text('Last name'),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: lastnameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Last Name',
                ),
              ),
              //some space between email and mobile
              const SizedBox(
                height: 10,
              ),
              //password text field
              const Text('Password'),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Password',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              //phone number text field
              const Text('Phone number'),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: mobileController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Phone Number',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              //e-mail text field
              const Text('Email'),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Email',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              //create button for register
              ElevatedButton(
                onPressed: () {
                  //we will trying to print input
                  print(nameController.text);
                  print(emailController.text);
                  print(passwordController.text);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (
                        context) => const FarmerDashboard()), // Or FarmerDashboard(), depending on your response
                  );
                },
                child: const Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Already have an account?'),
              const SizedBox(
                height: 10,
              ),
              // button for login page
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: const Text(
                  'Log in',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

