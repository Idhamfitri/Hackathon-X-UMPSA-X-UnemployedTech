import 'package:flutter/material.dart';
import 'package:first_app/databases/database_provider.dart';
import 'package:first_app/databases/note_model.dart';
import 'package:first_app/journals/add_note.dart';
import 'package:first_app/journals/display_note.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  Key _futureBuilderKey = UniqueKey();

  void refreshNotes() {
    setState(() {
      _futureBuilderKey = UniqueKey();
    });
  }

  getNotes() async {
    //This function fetches all saved journal entries from the database by calling DatabaseProvider.db.getNotes().
    final notes = await DatabaseProvider.db.getNotes();
    return notes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 77, 144, 175),
        centerTitle: true,
        title: Text(
          "  Y O U R  J O U R N A L",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        key: _futureBuilderKey,
        future: DatabaseProvider.db
            .getNotes(), //Wraps the getNotes() function to asynchronously fetch and display the notes once loaded.
        builder: (context, noteData) {
          // Uses noteData.connectionState to manage various connection states:
          switch (noteData.connectionState) {
            // none: Displays a placeholder text indicating no connection.
            case ConnectionState
                  .none: // waiting and active: Shows a loading spinner while waiting for data.
              return const Center(
                // done: Once data is received, checks if any notes exist and displays them in a list, or shows a message if no notes are found.
                child: Text("No connection started."),
              );
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.active:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              {
                print("Data received: ${noteData.data}");
                if (noteData.data == null) {
                  return Center(
                    child: Text("You dont have any memories yet, create one"),
                  );
                } else {
                  final notes = noteData.data as List<Map<String, dynamic>>;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      //When noteData.connectionState is done and notes are available, a ListView.builder is used to display each entry.
                      itemCount: notes.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: const Color.fromARGB(255, 77, 144,
                              175), //Title and Content Display: Displays the note title and body in a stylized Card.
                          shadowColor: Colors.blueGrey,
                          elevation: 10,
                          child: ListTile(
                            title: Text(notes[index]['title'] ?? 'No Title'),
                            titleTextStyle: TextStyle(
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                color: (const Color.fromARGB(153, 22, 22, 22))),
                            subtitle: Text(
                              notes[index]['body'] ?? 'No Content',
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              final note = NoteModel(
                                //Note Tapping: Tapping on a note navigates to the ShowNote screen, passing the NoteModel object as an argument. The model is created using values from the database response, converting creation_date from string to DateTime format.
                                id: notes[index]['id'],
                                title: notes[index]['title'],
                                body: notes[index]['body'],
                                creation_date: DateTime.parse(
                                    notes[index]['creation_date']),
                              );

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShowNote(),
                                  settings: RouteSettings(arguments: note),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                }
              }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 77, 144, 175),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    AddNote()), //The button navigates to the AddNote screen. After returning, it checks if a new note was added (result == true) and calls setState() to refresh the notes list.
          );
          if (result == true) {
            // setState(() {});
            refreshNotes();
          }
        },
        child: Icon(
          Icons.note_add,
          color: Colors.white,
        ),
      ),
    );
  }
}
