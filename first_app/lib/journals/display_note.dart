
import 'package:first_app/main.dart';
import 'package:flutter/material.dart';
import 'package:first_app/databases/database_provider.dart';
import 'package:first_app/databases/note_model.dart';

class ShowNote extends StatelessWidget {
  const ShowNote({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieves the note passed as an argument from the previous screen.
    final note = ModalRoute.of(context)?.settings.arguments as NoteModel;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 77, 144, 175),
        title: const Text(
          'M E M O R I E S',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              DatabaseProvider.db
                  .deleteNote(note.id!); // Deletes the note by its ID.
               Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (route) => false, // Remove all previous routes
          );
            },
            icon: const Icon(Icons.delete),
            color: Colors.white,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/five.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3),
              BlendMode.darken,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  note.title ?? "No Title",
                  style: const TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 53, 66, 73),
                  ),
                ),
              ),
              const SizedBox(
                  height: 20.0), // Adds spacing between title and content.
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: Offset(0, 3),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      note.body ?? "No Content",
                      style: const TextStyle(
                        fontSize: 18.0,
                        height: 1.5,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Created on: ${note.creation_date?.toLocal().toString().split(' ')[0] ?? 'Unknown'}',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
