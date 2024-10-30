import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// QuoteContainer widget displays a quote along with favorite and copy functionality.
class QuoteContainer extends StatelessWidget {
  final Future<Map<String, String>> quoteFuture; // Future holding the quote and author
  final bool isRed; // Indicates if the quote is marked as favorite
  final VoidCallback onFavoriteToggle; // Callback for toggling favorite status

  const QuoteContainer({
    Key? key,
    required this.quoteFuture,
    required this.isRed,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? quote;  // Holds the quote text
    String? author; // Holds the author name

    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      width: double.infinity, // Fills the available width
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 71, 143, 165), // Background color
        borderRadius: const BorderRadius.all(Radius.circular(10.0)), // Rounded corners
        border: Border.all(
          color: Colors.black, // Border color
          width: 1.0,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            offset: Offset(10, 10),
            blurRadius: 40,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Adjusts to content's height
        children: [
          // Row for static buttons at the top (Copy and Favorite)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  if (quote != null && author != null) {
                    // Copies the quote and author to clipboard
                    Clipboard.setData(
                        ClipboardData(text: '"$quote" - $author'));
                    // Shows feedback message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Quote copied to clipboard!')),
                    );
                  }
                },
                child: const Icon(
                  Icons.copy,
                  color: Color.fromARGB(255, 255, 255, 255),
                  size: 30,
                ),
              ),
              const SizedBox(width: 15),
              // Favorite button with toggle functionality
              IconButton(
                icon: Icon(isRed ? Icons.favorite : Icons.favorite_outline),
                iconSize: 30,
                splashRadius: 20,
                onPressed: onFavoriteToggle,
                color: isRed
                    ? Colors.red
                    : const Color.fromARGB(255, 226, 226, 226),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // FutureBuilder widget to display quote and author from future data
          FutureBuilder<Map<String, String>>(
            future: quoteFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Shows loading indicator while waiting for data
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                // Shows error message if data loading fails
                return Text(
                  'Failed to load quote: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red),
                );
              } else {
                // Retrieves quote and author from snapshot data
                quote = snapshot.data?['quote'];
                author = snapshot.data?['author'] ?? 'Unknown';

return Column(
                  mainAxisSize: MainAxisSize.min, // Adjusts to content's height
                  children: [
                    // Displays the quote text
                    Text(
                      '"${quote ?? "Loading..."}"',
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 202, 202, 202),
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        letterSpacing: 2,
                        wordSpacing: 5,
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            offset: Offset(1, 1),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 35),
                    // Displays the author name, aligned to the right
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '- ${author ?? "Loading..."}',
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 223, 223, 223),
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          letterSpacing: 2,
                          wordSpacing: 5,
                          shadows: [
                            Shadow(
                              color: Colors.black,
                              offset: Offset(1, 1),
                              blurRadius: 3,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
