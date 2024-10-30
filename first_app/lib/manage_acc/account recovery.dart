import 'package:first_app/manage_acc/login.dart';
import 'package:flutter/material.dart';

class RecoveryPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  RecoveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[100],
        body: Center(
          child: Container(
            margin: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _header(context),
                _inputField(context),
                _submitButton(context),
                _return_login(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header(context) {
    return Column(
      children: [
        Center(
          child: Text(
            "Account Recovery",
             style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            )
          
         
        ),
        Text("Enter your email to recover your account"),
      ],
    );
  }

  Widget _inputField(context) {
    return TextField(
      controller: emailController,
      decoration: InputDecoration(
        hintText: "Email",
        fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
        filled: true,
        prefixIcon: Icon(Icons.email_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _submitButton(context) {
    return ElevatedButton(
      onPressed: () => _recoverAccount(context),
      child: Text(
        "Recover Account",
        style: TextStyle(fontSize: 20),
      ),
      style: ElevatedButton.styleFrom(
        shape: StadiumBorder(),
        padding: EdgeInsets.symmetric(vertical: 13, horizontal: 60),
      ),
    );
  }

  void _recoverAccount(BuildContext context) {
    String email = emailController.text.trim();

    if (email.isEmpty) {
      _showMessage(context, 'Please enter your email');
      return;
    }

    // Call a recovery function here. It could verify if the email exists, then send a recovery link.
    _sendRecoveryLink(email);

    _showMessage(context, 'If an account exists for $email, a recovery link has been sent.');

    emailController.clear();  // clear the textfield after press button 
  }

  void _sendRecoveryLink(String email) {
    // Replace this method with actual functionality to send a recovery email.
    print("Sending recovery link to $email");
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
  
 Widget _return_login(BuildContext context) {
  return TextButton(
    onPressed: () { 
       Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()), // HomePage screen after login
        (route) => false,
      );
     },
    child: Text('Return to Login Page'),

  );


  }
}
