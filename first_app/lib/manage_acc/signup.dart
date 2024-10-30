
import 'package:flutter/material.dart'; // Import Flutter Material package for UI components
import 'package:first_app/databases/database_provider.dart'; // Import DatabaseProvider to manage database operations
import 'package:first_app/databases/user_model.dart';        // Import UserModel to define user data structure
import 'package:first_app/manage_acc/login.dart';             // Import the login page for navigation after sign-up

class SignUpScreen extends StatelessWidget { // Define a stateless widget for the sign-up screen
  // Text editing controllers for capturing user input
  final TextEditingController usernameController = TextEditingController(); 
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController retypePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) { // Build method to create the UI
    return SafeArea( // Ensure the UI is displayed within safe areas of the screen
      child: Scaffold( // Base layout structure for the sign-up screen
        backgroundColor: Colors.blue[100], // Set background color for the screen
        body: SingleChildScrollView( // Allow scrolling for smaller screens
          child: Container(
            margin: EdgeInsets.all(24), // Add margin around the container
            child: Column( // Vertical layout for child widgets
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distribute space evenly
              children: [
                SizedBox(height: 30,), // Add spacing at the top
                _header(context), // Call the header widget
                SizedBox(height: 150,), // Add spacing between header and input fields
                _inputFields(context), // Call the input fields widget
                _loginInfo(context), // Call the login info widget
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header(context) { // Widget for the header section
    return Column( // Layout for header content
      children: [
        Text(
          "Create Account", // Title of the header
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold), // Header style
        ),
        Text("Enter details to get started 😊"), // Subtitle below the header
      ],
    );
  }

  Widget _inputFields(context) { // Widget for input fields
    return Column( // Vertical layout for input fields
      crossAxisAlignment: CrossAxisAlignment.stretch, // Align fields to stretch across the width
      children: [
        TextField( // Input field for username
          controller: usernameController, // Controller to capture input
          decoration: InputDecoration( // Decoration for the input field
            hintText: "Username", // Placeholder text
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1), // Fill color with transparency
            filled: true, // Enable filled background
            prefixIcon: Icon(Icons.person), // Icon for the username field
            border: OutlineInputBorder( // Border styling
                borderRadius: BorderRadius.circular(18), // Rounded corners
                borderSide: BorderSide.none), // No border side
          ),
        ),
        SizedBox(height: 10), // Add spacing between fields
        TextField( // Input field for email
          controller: emailController, // Controller to capture input
          decoration: InputDecoration( // Decoration for the input field
            hintText: "Email id", // Placeholder text
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1), // Fill color with transparency
            filled: true, // Enable filled background
            prefixIcon: Icon(Icons.email_outlined), // Icon for the email field
            border: OutlineInputBorder( // Border styling
                borderRadius: BorderRadius.circular(18), // Rounded corners
                borderSide: BorderSide.none), // No border side
          ),
        ),
        SizedBox(height: 10), // Add spacing between fields
        TextField( // Input field for password
          controller: passwordController, // Controller to capture input
          decoration: InputDecoration( // Decoration for the input field
            hintText: "Password", // Placeholder text
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1), // Fill color with transparency
            filled: true, // Enable filled background
            prefixIcon: Icon(Icons.lock_outline), // Icon for the password field
            border: OutlineInputBorder( // Border styling
                borderRadius: BorderRadius.circular(18), // Rounded corners
                borderSide: BorderSide.none), // No border side
          ),
          obscureText: true, // Hide password input
        ),
        SizedBox(height: 10), // Add spacing between fields
        TextField( // Input field for retyping password
          controller: retypePasswordController, // Controller to capture input
          decoration: InputDecoration( // Decoration for the input field
            hintText: "Retype Password", // Placeholder text
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1), // Fill color with transparency
            filled: true, // Enable filled background
            prefixIcon: Icon(Icons.lock_outline), // Icon for the retype password field
            border: OutlineInputBorder( // Border styling
                borderRadius: BorderRadius.circular(18), // Rounded corners
                borderSide: BorderSide.none), // No border side
          ),
          obscureText: true, // Hide password input
        ),
        SizedBox(height: 50), // Add spacing before the button
        ElevatedButton( // Sign-up button
          onPressed: () => _signUp(context), // Call sign-up function on press
          child: Text(
            "Sign Up", // Button text
            style: TextStyle(fontSize: 20), // Text style for the button
          ),
          style: ElevatedButton.styleFrom( // Button styling
            shape: StadiumBorder(), // Rounded button shape
            padding: EdgeInsets.symmetric(vertical: 16), // Vertical padding for the button
          ),
        ),
      ],
    );
  }

  Widget _loginInfo(context) { // Widget for login info section
    return Row( // Horizontal layout for login info
      mainAxisAlignment: MainAxisAlignment.center, // Center the row contents
      children: [
        Text("Already have an account?"), // Prompt for users with existing accounts
        TextButton( // Button to navigate to login page
          onPressed: () { // Define button action
            Navigator.pushAndRemoveUntil( // Navigate to login page
              context,
              MaterialPageRoute(builder: (context) => LoginPage()), // Build login page
              (route) => false, // Remove previous routes from the stack
            );
          },
          child: Text("Login"), // Text for the button
        ),
      ],
    );
  }

  Future<void> _signUp(BuildContext context) async { // Function to handle sign-up logic
    String username = usernameController.text.trim(); // Get and trim username input
    String email = emailController.text.trim(); // Get and trim email input
    String password = passwordController.text.trim(); // Get and trim password input
    String retypePassword = retypePasswordController.text.trim(); // Get and trim retype password input

    // Simple validation
    if (username.isEmpty || email.isEmpty || password.isEmpty || retypePassword.isEmpty) { // Check for empty fields
      _showMessage(context, 'Please fill out all fields'); // Show message if fields are empty
      return; // Exit the function
    }

    if (password != retypePassword) { // Check if passwords match
      _showMessage(context, 'Passwords do not match'); // Show message if passwords do not match
      return; // Exit the function
    }

    // Create a new user model
    UserModel user = new UserModel(name: username, email: email, password: password); // Instantiate UserModel with input data

    // Insert the user into the database
    try {
      await DatabaseProvider.db.addUser(user); // Add user to the database
      _showMessage(context, 'Sign up successful!'); // Show success message

      // Navigate to the login page after successful sign-up
      Navigator.pushAndRemoveUntil( // Navigate to login page
        context,
        MaterialPageRoute(builder: (context) => LoginPage()), // Build login page
        (route) => false, // Remove previous routes from the stack
      );
    } catch (e) { // Catch any errors during sign-up
      _showMessage(context, 'Error signing up. Please try again.'); // Show error message
    }
  }

  void _showMessage(BuildContext context, String message) { // Function to display messages
    ScaffoldMessenger.of(context).showSnackBar( // Show a snackbar with the message
      SnackBar(content: Text(message)), // Create a snackbar with the message
    );
  }
}







