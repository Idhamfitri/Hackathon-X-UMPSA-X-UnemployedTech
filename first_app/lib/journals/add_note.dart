import 'package:flutter/material.dart';
import 'package:first_app/databases/database_provider.dart';
import 'package:first_app/main.dart';
import 'package:first_app/databases/note_model.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  // Variables to store user input and note date.
  String? title;
  String? body;
  DateTime? date;

  // Controllers to manage the input in the TextFields for title and body.
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  // Method to add a new note to the database.
  addNote(NoteModel note) async {
    await DatabaseProvider.db
        .addNewNote(note); // Calls the database provider to add the note.
    print("Journal added successfully"); // Logs the success message.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 77, 144, 175),
        centerTitle: true,
        title: Text(
          "A D D  M E M O R Y",
          style: TextStyle(color: Colors.white),
        ), // App bar title.
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Column(
          children: [
            // TextField for the journal title.
            TextField(
              controller: titleController, // Uses the title controller.
              decoration: InputDecoration(
                border: InputBorder.none, // No border style.
                hintText: "Journal Title", // Placeholder text.
              ),
              style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
            ),
            // Expanded TextField for the journal body content.
            Expanded(
              child: TextField(
                controller: bodyController, // Uses the body controller.
                keyboardType: TextInputType.multiline, // Multiline input.
                maxLines: null, // No max lines limit.
                decoration: InputDecoration(
                  border: InputBorder.none, // No border style.
                  hintText: "Express Here", // Placeholder text.
                ),
              ),
            ),
          ],
        ),
      ),
      // Floating action button to save the journal entry.
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color.fromARGB(255, 77, 144, 175),
        hoverColor: Colors.blueGrey,
        onPressed: () async {
          setState(() {
            // Assigns the values from the controllers to the variables.
            title = titleController.text;
            body = bodyController.text;
            date = DateTime.now(); // Sets the current date and time.
          });

          // Creates a new NoteModel instance with the collected data.
          NoteModel note =
              NoteModel(title: title, body: body, creation_date: date);
          await addNote(note); // Adds the note to the database.

          // Show a SnackBar message confirming the addition of the journal
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Journal added, Go to Journal page to view!"),
              duration: Duration(seconds: 2),
            ),
          );

          // Navigator.pop(
          //     context); //It will return to previous screen when saved button are pressed but it will not appear. Need to go to main page and click journal button again to appear.

          // Navigates back to the JournalScreen after saving the note but if click back it will go back to the page before which is writing the note but it will still save the note just go back until the main screen.
         Navigator.pushAndRemoveUntil( // Navigate to login page
        context,
        MaterialPageRoute(builder: (context) => HomePage()), // Build login page
        (route) => false, // Remove previous routes from the stack
      );
        },
        label: Text(
          "Save Journal",
          style: TextStyle(color: Colors.white),
        ), // Text for the button.
        icon: Icon(
          Icons.save,
          color: Colors.white,
        ), // Save icon.
      ),
    );
  }
}
