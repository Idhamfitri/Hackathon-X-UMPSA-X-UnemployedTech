

class UserModel {
  // Fields that store data for each user.
  int? id; // The unique identifier for each user; can be null if auto-generated.
  String? name; // The username of the user, nullable.
  String? email; // The email of the user, nullable.
  String? password; // The password of the user, nullable.

  // Constructor for creating instances of UserModel.
  UserModel({this.id, this.name, this.email, this.password});

  // Factory constructor that allows creating a UserModel from a Map.
  // This is useful when reading data from the database, which returns a Map.
  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        id: json['id'], // Maps the id from the database to the id field.
        name: json['name'], // Maps the name field from the database to the name.
        email: json['email'], // Maps the email field from the database to the email.
        password: json['password'], // Maps the password field from the database to the password.
      );

  // Method to convert UserModel instances into a Map.
  // This is useful for inserting or updating the database.
  Map<String, dynamic> toMap() {
    return {
      "id": id, // Maps the id field.
      "name": name, // Maps the name field.
      "email": email, // Maps the email field.
      "password": password, // Maps the password field.
    };
  }



  static bool validateUser(String username, String password) {

     return username == username && password == password;    // if the username and password in database and textfield are matches

   }
}
