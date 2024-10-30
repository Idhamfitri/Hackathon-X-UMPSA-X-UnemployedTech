import 'package:first_app/databases/user_model.dart';
import 'package:path/path.dart';
import 'package:first_app/databases/note_model.dart';
import 'package:sqflite/sqflite.dart';

// Singleton class to manage database operations.
class DatabaseProvider {
  // Creates a single instance of DatabaseProvider.
  static final DatabaseProvider db = DatabaseProvider._();

  // Private variable to store the database instance.
  static Database? _database;

  // Private constructor for the singleton pattern.
  DatabaseProvider._();

  // Getter for the database. Initializes the database if not already initialized.
  Future<Database> get database async {
    if (_database != null) {
      return _database!;     // ifvdatabase is initialized, return it 
    }
    _database = await initDB(); // Initializes the database.
    return _database!;   // return the  new initialized databas 
  }



// void deleteDatabaseFile() async {
//   final path = join(await getDatabasesPath(), "journal_page.db");
//   await databaseFactory.deleteDatabase(path);
//   print("Database deleted.");
// }



  initDB() async {
   return await openDatabase(
     join(await getDatabasesPath(), "journal_page.db"),
     onCreate: (db, version) async {
       // Creating the notes table
       await db.execute('''
         CREATE TABLE  notes (
           id INTEGER PRIMARY KEY AUTOINCREMENT,  
           title TEXT,                             
           body TEXT,                             
           creation_date DATE
         )
       ''');
       print("Notes table created.");

        // Drop the user table if it exists
    //  await db.execute('DROP TABLE IF EXISTS user');

       // Creating the user table
       await db.execute('''
         CREATE TABLE IF NOT EXISTS user (
           id INTEGER PRIMARY KEY AUTOINCREMENT,
           name TEXT UNIQUE,
           email TEXT NOT NULL,
           password TEXT NOT NULL
         )
       ''');
       print("User table created.");
     },


    //  onUpgrade: (db, oldVersion, newVersion) async {
    //    if (oldVersion < 3) {
    //      await db.execute('''
    //        CREATE TABLE IF NOT EXISTS user (
    //          id INTEGER PRIMARY KEY AUTOINCREMENT,
    //          name TEXT UNIQUE,
    //          email TEXT NOT NULL,
    //          password TEXT NOT NULL
    //        )
    //      ''');
    //      print("User table created during upgrade.");
    //    }
    //  },

     version: 1, // Increment this version number for changes manually
   );
}


  // Inserts a new note into the 'notes' table.
  addNewNote(NoteModel note) async {
    final db = await database;
    db.insert(
      "notes",
      note.toMap(), // Converts the NoteModel to a Map for insertion.
      conflictAlgorithm: ConflictAlgorithm
          .replace, // Replaces any existing note with the same ID.
    );
  }

  // Retrieves all notes from the 'notes' table.
  Future<List<Map<String, dynamic>>> getNotes() async {
    final db = await database;
    var res = await db.query("notes"); // Executes a query to fetch all notes.
    if (res.isEmpty) {
      return []; // Returns an empty list if no notes are found.
    } else {
      return res
          .toList(); // Converts the query result to a list and returns it.
    }
  }

  // Deletes a note by its ID from the 'notes' table.
  Future<int> deleteNote(int id) async {
    final db = await database;
    return await db.delete(
      "notes",
      where: "id = ?", // SQL condition to match the note ID.
      whereArgs: [id], // Arguments to replace '?' in the where clause.
    );
  }






// Function to add a new user to the 'user' table.
  Future<int> addUser(UserModel user) async {
    final db = await database;
    try {
      return await db.insert(
        "user",
        user.toMap(), // Converts the UserModel to a Map for insertion.
        conflictAlgorithm: ConflictAlgorithm.replace, // Replaces if user exists.
      );
    } catch (e) {
      print("Error adding user: $e");
      return -1; // Return -1 to indicate failure.
    }
  }



 // Validate if user with given username and password exists
  Future<bool> validateUser(String username, String password) async {
    final db = await database;
    var res = await db.query(
      "user",
      where: "name = ? AND password = ?",
      whereArgs: [username, password],
    );
    return res.isNotEmpty;
  }



}
