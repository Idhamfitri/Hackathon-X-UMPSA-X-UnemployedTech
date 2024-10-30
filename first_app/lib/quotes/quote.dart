import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:first_app/quotes/category_button.dart';
import 'package:first_app/quotes/quote_container.dart';

class MyQuoteScreen extends StatefulWidget {
  const MyQuoteScreen({super.key});

  @override
  State<MyQuoteScreen> createState() => _MyQuoteScreenState();
}

class _MyQuoteScreenState extends State<MyQuoteScreen> {
  final List<String> categories = [
    'Inspiration',
    'Relationship',
    'Stress',
    'Self-Care',
    'Study',
    'Spiritual',
    'Islamic',
  ];

  late List<Future<Map<String, String>>> quoteFutures;
  String selectedCategory = 'All'; // Default category
  final List<bool> isRedList = [false, false, false, false];

  @override
  void initState() {
    super.initState();
    fetchQuote(selectedCategory); // Fetch quotes for the default category
  }

  void toggleFavorite(int index) {
    setState(() {
      isRedList[index] = !isRedList[index];
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isRedList[index]
            ? 'You like this quote!'
            : 'You unlike this quote!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 55, 114, 141),
      appBar: AppBar(
        title: const Text('Quotes'),
      ),
      body: SingleChildScrollView(
        // Wrap the main content in a SingleChildScrollView
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                'QUOTES OF THE DAY!',
                textAlign: TextAlign.center,
                style: GoogleFonts.lobster(
                  fontSize: 35,
                  color: Color.fromARGB(255, 221, 222, 223),
                  fontWeight: FontWeight.normal,
                  letterSpacing: 5,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      offset: Offset(2, 2),
                      blurRadius: 3,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                '"Hello! Here’s a sprinkle of wisdom and positivity to start your day right. 🌞"',
                textAlign: TextAlign.center,
                style: GoogleFonts.dancingScript(
                  fontSize: 25,
                  color: Color.fromARGB(255, 202, 202, 202),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  shadows: [
                    Shadow(
                        color: Colors.black,
                        offset: Offset(1, 1),
                        blurRadius: 3)
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categories.map((category) {
                    return CategoryButton(
                      categoryName: category,
                      onTap: () {
                        fetchQuote(category);
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 10, bottom: 0),
                child: Container(
                  margin: const EdgeInsets.all(0),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    selectedCategory,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              // Remove the Expanded widget for ListView and replace it with a regular Column
              ListView.builder(
                padding: const EdgeInsets.all(8.0),
                shrinkWrap:
                    true, // Allows ListView to take only the necessary space
                physics:
                    const NeverScrollableScrollPhysics(), // Disable ListView scrolling
                itemCount: quoteFutures.length,
                itemBuilder: (context, index) {
                  return FutureBuilder<Map<String, String>>(
                    future: quoteFutures[index],
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data == null) {
                        return const Center(child: Text('No quote available.'));
                      } else {
                        return QuoteContainer(
                          quoteFuture: Future.value(snapshot.data),
                          isRed: isRedList[index],
                          onFavoriteToggle: () => toggleFavorite(index),
                        );
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Map<String, String>> generateRandomQuote([String? category]) async {
    final model = GenerativeModel(
      model: 'gemini-1.5-pro',
      apiKey:
          'AIzaSyB1RcRjogMb0hkl6THWw203l1fN3t4ngWo', // Replace with your actual API key
    );

    String mainCategory = category?.split(' -')[0] ?? '';

    String prompt;
    switch (mainCategory) {
      case 'Inspiration':
        prompt =
            'Generate an inspiring quote with the author’s name except Steve Jobs\'s quote in the format: "Quote text" - Author Name';
        break;
      case 'Relationship':
        prompt =
            'Generate a quote about Relationship with the author’s name in the format: "Quote text" - Author Name';
        break;
      case 'Stress':
        prompt =
            'Generate a quote about stress with the author’s name in the format: "Quote text" - Author Name';
        break;
      case 'Self-Care':
        prompt =
            'Generate a quote about self-care with the author’s name in the format: "Quote text" - Author Name';
        break;
      case 'Study':
        prompt =
            'Generate a quote about study with the author’s name in the format: "Quote text" - Author Name';
        break;
      case 'Spiritual':
        prompt =
            'Generate a quote about spirituality with the author’s name in the format: "Quote text" - Author Name';
        break;
      case 'Islamic':
        prompt =
            'Generate an Islamic quote with the author’s name in the format: "Quote text" - Author Name';
        break;
      default:
        prompt =
            'Generate a random quote with the author’s name in the format: "Quote text" - Author Name';
        break;
    }

    final response = await model.generateContent([
      Content.multi([TextPart(prompt)])
    ]);

    final quoteResponse =
        response.text ?? 'An error occurred generating the quote.';
    final splitQuote = quoteResponse.split(' -');

    return {
      'quote': splitQuote[0].trim(),
      'author': splitQuote.length > 1 ? splitQuote[1].trim() : 'Unknown'
    };
  }

  void fetchQuote(String category) {
    setState(() {
      quoteFutures = [
        generateRandomQuote('$category - Unique 1'),
        generateRandomQuote('$category - Unique 2'),
        generateRandomQuote('$category - Unique 3'),
        generateRandomQuote('$category - Unique 4'),
      ];
    });
  }
}
