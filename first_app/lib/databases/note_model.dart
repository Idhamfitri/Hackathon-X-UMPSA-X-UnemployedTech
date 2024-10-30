class NoteModel {
  // Fields that store data for each note.
  int?
      id; // The unique identifier for each note; can be null if auto-generated.
  String? title; // The title of the note, nullable.
  String? body; // The body/content of the note, nullable.
  DateTime?
      creation_date; // The creation date of the note, stored as DateTime, nullable.

  // Constructor for creating instances of NoteModel.
  NoteModel({this.id, this.title, this.body, this.creation_date});

  // Factory constructor that allows creating a NoteModel from a Map.
  // This is useful when reading data from the database, which returns a Map.
  factory NoteModel.fromMap(Map<String, dynamic> json) => NoteModel(
        id: json['id'], // Maps the id from the database to the id field.
        title: json[
            'title'], // Maps the title field from the database to the title.
        body:
            json['body'], // Maps the body field from the database to the body.
        creation_date: DateTime.parse(
            json['creation_date']), // Converts the string date to a DateTime.
      );

  // Method to convert NoteModel instances into a Map.
  // This is useful for inserting or updating the database.
  Map<String, dynamic> toMap() {
    return {
      "id": id, // Maps the id field.
      "title": title, // Maps the title field.
      "body": body, // Maps the body field.
      "creation_date":
          creation_date?.toString(), // Converts DateTime to a string format.
    };
  }
}
