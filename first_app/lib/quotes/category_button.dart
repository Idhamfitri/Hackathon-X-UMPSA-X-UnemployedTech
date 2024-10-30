import 'package:flutter/material.dart';

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
      onTap: onTap,
      child: FittedBox(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 72, 130, 145),
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
          child: Center(
            child: Text(
              categoryName,
              style: const TextStyle(
                fontSize: 15,
                color: Color.fromARGB(255, 255, 255, 255),
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
