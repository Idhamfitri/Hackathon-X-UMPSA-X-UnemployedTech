
import 'package:google_generative_ai/google_generative_ai.dart';    // iport Gemini AI library and also it dependency 
import 'package:flutter/material.dart';             

class Zecki extends StatefulWidget {
  const Zecki({Key? key}) : super(key: key);

  @override
  _ZeckiState createState() => _ZeckiState();
}


class _ZeckiState extends State<Zecki> {
  final TextEditingController _controller = TextEditingController();     // controll the text input & output
  List<String> _aiResponses = [];      // create dynamic list to provide gemini chatbox
  List<String> _userMSG = [];             // create dynamic list to provide user chatbox
  late final GenerativeModel model;                                    // define Generative model for Gemini AI 


  @override
  void initState() {                                                   
    super.initState();

    // Initialize the Gemini API model here
    model = GenerativeModel(         
      model: 'gemini-1.5-pro',
      apiKey: 'AIzaSyASGzh4jtDj1XuHcE4aPowpx1T5kQYiGAA', // Replace with your actual API key
      generationConfig: GenerationConfig(
        temperature: 1,                // set temperature of AI to 1
        topK: 64,                 
        topP: 0.95,
        maxOutputTokens: 8192,
        responseMimeType: 'text/plain',
      ),
      systemInstruction: Content.system(     // provide instruction for Gemini AI to ensure maximum satisfaction response 
        'chat like member of user ,provide support or problem solving if needed  ',
      ),
    );
  }



  Future<void> _getSuggestions() async {              // getsuggest function to let  receive output from AI
    final message = _controller.text;
    final content = Content.text(message);

    try {                                            // test to catch some error in bracket , if no error execute normally
      final chat = model.startChat();                // starting the chat 
      final response = await chat.sendMessage(content);

      setState(() {
        _userMSG.add(message);                     
        _aiResponses.add(response.text ?? "Sorry, I couldn't get a response.");
        _controller.clear();                        // clear the input texfield after user push submit button
      });
    } 
    catch (e) {
      setState(() {
        _aiResponses.add("Error getting response: ");  // display error when there is an error within bracket
      });
    }
  }

  @override
  void dispose() {      //clear data in storage address
    _controller.dispose();    //clear text
    super.dispose();        // to ensure it is clearly disposed to optimized storage 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(                      // application bar
        backgroundColor: Colors.blue[700],
        elevation: 1,
        toolbarHeight: 60,               // height of the toolbar
        centerTitle: true,           
        title: const Text(                // title of the page 
          "Share Your Thoughts",       
          style: TextStyle(          
            fontSize: 24,           
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(      // enable scrolling in this widget
        child: Padding(                 // padding
          padding: const EdgeInsets.all(16.0), 
          child: Column(
            children: [
              // Introductory text with icon
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),    // set edgeinsect to 16 , 20 for hori and vertical
                decoration: BoxDecoration(              // declare decoration for container
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(12),    //  shape of the radius / corner 
                ),
                child: Row(
                  children: [
                    Icon(Icons.sentiment_satisfied_alt_rounded, size: 40, color: Colors.blue[800]),   // some smiley face man that geet you 
                    const SizedBox(width: 10),                // make space 
                    Expanded(
                      child: Text(
                        'how was your day today? We\'re glad to hear a happy news from you.',
                        style: TextStyle(color: Colors.blue[900], fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),      //make space

              // Displaying user and AI responses with avatars
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),       // disable scroll
                itemCount: _userMSG.length + _aiResponses.length,    // count the number of response ( usually 2 )
                itemBuilder: (context, index) { 
                  if (index.isEven) {                               // if there has a 2 way communication between user and AI
                    // User message with user icon
                    return Row(                                   
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.blue[300],
                          child: Icon(Icons.person, color: Colors.blue[900]),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.all(12.0),
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.blue[200],
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Text(
                              _userMSG[index ~/ 2],        // limit the index allow fewer message to displayed 
                              style: TextStyle(color: Colors.blue[900], fontSize: 16), //  adjust the style of the Text
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    // AI response with AI icon
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.blue[100],
                          child: Icon(Icons.chat_bubble, color: Colors.blue[700]),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.all(12.0),
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Text(
                              _aiResponses[index ~/ 2],
                              style: TextStyle(color: Colors.blue[900], fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
              const SizedBox(height: 20),

              // User input field with icon
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.edit, color: Colors.blue[700]),
                    hintText: "Share what’s on your mind...",
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 350),

              // Action button with icon
              ElevatedButton.icon(
                icon: const Icon(Icons.send, color: Colors.white),
                label: const Text(
                  "See Suggestions",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  shape: RoundedRectangleBorder(           // shape of the elevatedbutton
                    borderRadius: BorderRadius.circular(30),
                  ),
                  fixedSize: Size(500, 55)       //size of the elevated button 
                ),
                onPressed: _getSuggestions,    // when pressed button  refer to getsuggestion function 
              ),
            ],
          ),
        ),
      ),
    );
  }
}