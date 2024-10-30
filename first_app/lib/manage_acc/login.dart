// all these files was totally made by human :)

// all import files include here :
import 'package:first_app/main.dart';
import 'package:first_app/manage_acc/account%20recovery.dart';
import 'package:first_app/manage_acc/signup.dart';
import 'package:flutter/material.dart'; 
import 'package:first_app/databases/database_provider.dart'; 

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Controllers for text input fields
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[100],
        body: Container(
          margin: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _inputField(context),
              _forgotPassword(context),
              _signup(context),
            ],
          ),
        ),
      ),
    );
  }

  _header(context) {
    return Column(
      children: [
        Text(
          "Welcome Back",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Enter your credentials to login"),
      ],
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: usernameController,
          decoration: InputDecoration(
            hintText: "Username",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon: Icon(Icons.person),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          obscureText: visible,
          controller: passwordController,
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon: Icon(Icons.lock_open_sharp),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  visible = !visible;
                });
              },
              icon: Icon(Icons.visibility),
            ),
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () => _login(context), // Calls _login function
          child: Text(
            "Login",
            style: TextStyle(fontSize: 20),
          ),
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ],
    );
  }

  // Modified _login function to validate user from database
  _login(BuildContext context) async {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    bool isUserValid = await DatabaseProvider.db.validateUser(username, password);

    if (isUserValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login successful! Welcome, $username!')),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()), // HomePage screen after login
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid credentials. Please try again.')),
      );
    }
  }

  _forgotPassword(context) {
    return TextButton(
      onPressed: () {
         Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RecoveryPage()),
            );
      },
      child: Text("Forgot password?"),
    );
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Don't have an account? "),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUpScreen()),
            );
          },
          child: Text("Sign Up"),
        ),
      ],
    );
  }
}









