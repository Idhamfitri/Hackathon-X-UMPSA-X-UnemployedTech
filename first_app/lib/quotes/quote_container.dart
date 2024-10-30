import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuoteContainer extends StatelessWidget {
  final Future<Map<String, String>> quoteFuture;
  final bool isRed;
  final VoidCallback onFavoriteToggle;

  const QuoteContainer({
    Key? key,
    required this.quoteFuture,
    required this.isRed,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? quote;
    String? author;

    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      width: double.infinity, // Ensures it fills the available width
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 71, 143, 165),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        border: Border.all(
          color: Colors.black,
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
        mainAxisSize: MainAxisSize.min, // Important to avoid unbounded height
        children: [
          // Static buttons at the top of the container
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  if (quote != null && author != null) {
                    Clipboard.setData(
                        ClipboardData(text: '"$quote" - $author'));
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

          // FutureBuilder for quote and author text
          FutureBuilder<Map<String, String>>(
            future: quoteFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text(
                  'Failed to load quote: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red),
                );
              } else {
                quote = snapshot.data?['quote'];
                author = snapshot.data?['author'] ?? 'Unknown';

                return Column(
                  mainAxisSize: MainAxisSize.min, // Avoids unbounded height
                  children: [
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
