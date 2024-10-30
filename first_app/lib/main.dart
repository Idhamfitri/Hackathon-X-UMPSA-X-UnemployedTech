
 import 'package:first_app/quotes/quote.dart';
import 'package:first_app/journals/journal_main.dart';
import 'package:first_app/manage_acc/login.dart';
import 'package:first_app/Zecki.dart';
 import 'package:flutter/material.dart';
 import 'package:first_app/listen_music.dart';


 void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 // await deleteDatabaseFile(); // Call it here for testing

   runApp(const MyApp());

 }

// The deleteDatabaseFile function can be defined above or below the main function.

// Future<void> deleteDatabaseFile() async {
//   final path = join(await getDatabasesPath(), "journal_page.db");
//   await databaseFactory.deleteDatabase(path);
//   print("Database deleted.");      
// }



 class MyApp extends StatelessWidget {
   const MyApp({super.key});

   // This widget is the root of your application.
   @override
   Widget build(BuildContext context) {
     return MaterialApp(
       title: 'Flutter Demo',
       debugShowCheckedModeBanner: false, //rive
       theme: ThemeData(
       
       
         colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
         useMaterial3: false//true,
       ),
       home:  LoginPage(),           //try test here                                       //const MyHomePage(title: 'University Sains Malaysia'),
     );
   }
 }






class HomePage extends StatefulWidget {
  HomePage({super.key} );

  @override
  State<HomePage> createState() => _HomePageState();

}




class _HomePageState extends State<HomePage> {

  String login = 'log out';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(164, 208, 245, 1),
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        elevation: 0,
        title: Text('SELF CARE ROUTINE'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [

            PopupMenuItem(
              child: Text('Log out'),
              value: login,
               ),

             PopupMenuItem(
              child: Text('View Profile'),
              value: 2,
               ),

            ],
            onSelected:(value) {
              if( value == 'log out'){
              Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
              (route) => false, // Remove all previous routes
          );
              } 
              else {
                MaterialPageRoute(builder: (context) => LoginPage());
              }

            }
          )
        ],



      ),



      body: SafeArea(
        child: SingleChildScrollView( // enable scrolling 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[ 
              
              Container(        // container below APPbar
                
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      
                      Text(

                        ' Hye there  ',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.waving_hand_rounded,
                        color: const Color.fromARGB(255, 240, 225, 94),
                        size: 35,
                      ),
                    ]),
              ),

              SizedBox(
                height: 10,
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text(
                      'How Are You Feeling Today?',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 87, 106, 124)),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 180,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          promoCard('assets/images/happy_emoji.jpeg', 'happy'),
                          promoCard('assets/images/sad_emoji.jpeg', 'sad'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => JournalScreen()),
                        );
                      },
                      child: Container(
                        child: Text(
                          'Make Your Journal',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w300),
                        ),
                        alignment: Alignment(0.0, 0.0),
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    ),


                    SizedBox(
                      height: 10,
                    ),

                
                   GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Listen_MusicPage()),
                        );
                      },
                      child: Container(
                        child: Text(
                          'Listen to music',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w300),
                        ),
                        alignment: Alignment(0.0, 0.0),
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    ),


                  SizedBox(height: 10,),
                  


                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyQuoteScreen()),
                        );
                      },
                      child: Container(
                        child: Text(
                          'Quotes of the Day',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w300),
                        ),
                        alignment: Alignment(0.0, 0.0),
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(50)),
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
        // all promocards will redirect to AI pages
        if (pageName == 'happy') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Zecki()),
          );
        } else if (pageName == 'sad'){
          Navigator.push(
            context ,
            MaterialPageRoute(builder: (context) =>  Zecki()),
          );
        }   
        // Additional navigation logic for other pages can be added here
      },
      

      child: AspectRatio(
        aspectRatio: 5 / 3,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 162, 111, 39),
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage(image)),
          ),
        ),
      ),




    );
  }
  
 

}