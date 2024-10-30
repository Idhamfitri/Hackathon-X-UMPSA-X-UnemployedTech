import 'package:flutter/material.dart';

/// A stateless widget representing a button for selecting categories.
/// The button takes in a categoryName to display as text, 
/// and an onTap callback to handle the tap action.
class CategoryButton extends StatelessWidget {
  final String categoryName;
  final VoidCallback onTap;

  const CategoryButton({
    Key? key,
    required this.categoryName,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Executes the callback function when the button is tapped
      child: FittedBox(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 72, 130, 145), // Background color of the button
            borderRadius: BorderRadius.all(Radius.circular(100)), // Makes the button circular
          ),
          child: Center(
            child: Text(
              categoryName, // Displays the category name text
              style: const TextStyle(
                fontSize: 15,
                color: Color.fromARGB(255, 255, 255, 255), // Text color
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
