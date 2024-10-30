
import 'package:first_app/quotes/quote.dart'; // Imports the Quotes screen
import 'package:first_app/journals/journal_main.dart'; // Imports the Journal screen
import 'package:first_app/manage_acc/login.dart'; // Imports the Login screen
import 'package:first_app/Zecki.dart'; // Imports the Zecki screen
import 'package:flutter/material.dart'; // Imports the Flutter Material package for UI components
import 'package:first_app/listen_music.dart'; // Imports the Listen to Music page

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures binding is initialized before runApp() in async functions
  // await deleteDatabaseFile(); // Uncomment to delete the database for testing

  runApp(const MyApp()); // Launches the app with MyApp as the root widget
}

// Function to delete the database file for testing purposes
// Future<void> deleteDatabaseFile() async {
//   final path = join(await getDatabasesPath(), "journal_page.db");
//   await databaseFactory.deleteDatabase(path);
//   print("Database deleted.");      
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Defines the main structure and theme of the app
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false, // Hides the debug banner
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent), // Sets the color theme based on a seed color
        useMaterial3: false // Set to true if you want to enable Material 3 UI components
      ),
      home: LoginPage(), // Sets the initial screen to LoginPage
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState(); // Creates the state object for HomePage
}

class _HomePageState extends State<HomePage> {
  String login = 'log out'; // Defines a variable for logout option in the menu

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(164, 208, 245, 1), // Sets the background color
      appBar: AppBar(
        backgroundColor: Colors.lightBlue, // Sets the AppBar color
        elevation: 0, // Removes the AppBar shadow
        title: Text('SELF CARE ROUTINE'), // Sets the AppBar title
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('Log out'), // Adds 'Log out' option to the menu
                value: login,
              ),
              PopupMenuItem(
                child: Text('View Profile'), // Adds 'View Profile' option to the menu
                value: 2,
              ),
            ],
            onSelected: (value) {
              if (value == 'log out') {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()), // Navigates to LoginPage on logout
                  (route) => false, // Clears previous routes
                );
              } else {
                MaterialPageRoute(builder: (context) => LoginPage()); // Navigates to LoginPage if other menu items selected
              }
            },
          )
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView( // Wraps body in scrollable view to prevent overflow
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container( // Container directly under the AppBar
                width: double.infinity, // Expands to full width
                decoration: BoxDecoration(
                  color: Colors.transparent, // Sets background to transparent
                  borderRadius: BorderRadius.circular(20), // Adds rounded corners
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15), // Adds padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      ' Hye there  ', // Displays greeting text
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.waving_hand_rounded, // Adds a waving hand icon
                      color: const Color.fromARGB(255, 240, 225, 94),
                      size: 35,
                    ),
                  ]
                ),
              ),

              SizedBox(height: 10), // Adds spacing

              Padding(
                padding: const EdgeInsets.all(10.0), // Adds padding around inner content
                child: Column(
                  children: [
                    Text(
                      'How Are You Feeling Today?', // Displays a question prompt
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 87, 106, 124),
                      ),
                    ),
                    SizedBox(height: 15), // Adds spacing

                    Container(
                      height: 180, // Sets height for the mood options container
                      child: ListView(
                        scrollDirection: Axis.horizontal, // Enables horizontal scrolling
                        children: <Widget>[
                          promoCard('assets/images/happy_emoji.jpeg', 'happy'), // Adds "happy" mood card
                          promoCard('assets/images/sad_emoji.jpeg', 'sad'), // Adds "sad" mood card
                        ],
                      ),
                    ),
                    SizedBox(height: 50), // Adds spacing

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => JournalScreen()), // Navigates to JournalScreen
                        );
                      },
                      child: Container(
                        child: Text(
                          'Make Your Journal', // Button label
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        alignment: Alignment(0.0, 0.0), // Centers text
                        height: 100, // Sets button height
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(50), // Rounds button corners
                        ),
                      ),
                    ),

                    SizedBox(height: 10), // Adds spacing

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Listen_MusicPage()), // Navigates to Listen_MusicPage
                        );
                      },
                      child: Container(
                        child: Text(
                          'Listen to music', // Button label
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        alignment: Alignment(0.0, 0.0),
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),

                    SizedBox(height: 10), // Adds spacing

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyQuoteScreen()), // Navigates to MyQuoteScreen
                        );
                      },
                      child: Container(
                        child: Text(
                          'Quotes of the Day', // Button label
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        alignment: Alignment(0.0, 0.0),
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget promoCard(String image, String pageName) {
    return GestureDetector(
      onTap: () {
        // Navigation logic for mood promo cards
        if (pageName == 'happy') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Zecki()), // Navigates to Zecki screen if happy is selected
          );
        } else if (pageName == 'sad') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Zecki()), // Navigates to Zecki screen if sad is selected
          );
        }
        // Additional navigation logic for other pages can be added here
      },

      child: AspectRatio(
        aspectRatio: 5 / 3, // Sets aspect ratio for promo card
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20), // Adds horizontal margin between cards
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 162, 111, 39),
            borderRadius: BorderRadius.circular(20), // Rounds the corners of the card
            image: DecorationImage(
              fit: BoxFit.cover, // Covers entire card area with image
              image: AssetImage(image), // Loads the image asset for the mood
            ),
          ),
        ),
      ),
    );
  }
}
