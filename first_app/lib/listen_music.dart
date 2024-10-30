// import 'package:flutter/material.dart';

// class Listen_MusicPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.blue[50],
//         appBar: AppBar(
//           title: Text("Listen to Music"),
//           centerTitle: true,
//           backgroundColor: Colors.blue[400],
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _header(),
//               SizedBox(height: 20),
//               _description(),
//               SizedBox(height: 20),
             
//               _genreList(context),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _header() {
//     return Text(
//       "Explore Music",
//       style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue[800]),
//     );
//   }

//   Widget _description() {
//     return Text(
//       "Choose a genre to get started and find music to fit your mood!",
//       style: TextStyle(fontSize: 18, color: Colors.grey[700]),
//     );
//   }

//   Widget _genreList(BuildContext context) {
//     List<String> genres = ["Pop", "Classical", "Jazz", "Hip Hop", "Country"];

//     return Expanded(
//       child: ListView.builder(
//         itemCount: genres.length,
//         itemBuilder: (context, index) {
//           return Card(
//             color: Colors.blue[100],
//             margin: EdgeInsets.symmetric(vertical: 8),
//             child: ListTile(
//               title: Text(
//                 genres[index],
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.blue[900]),
//               ),
//               trailing: Icon(Icons.music_note, color: Colors.blue[900]),
//               onTap: () {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text("Coming soon: ${genres[index]} music")),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
  
 
// }






import 'package:flutter/material.dart';

class Listen_MusicPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
          title: Text("Listen to Music"),
          centerTitle: true,
          backgroundColor: Colors.blue[400],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _headerAndSearch(context),
              SizedBox(height: 20),
              _description(),
              SizedBox(height: 20),
              _genreList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerAndSearch(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Explore Music",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue[800]),
        ),
        SizedBox(
          width: 120, // Limit the width of the search field here
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search",
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(Icons.search, color: Colors.blue[400]),
              contentPadding: EdgeInsets.symmetric(vertical: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _description() {
    return Text(
      "Choose a genre to get started and find music to fit your mood!",
      style: TextStyle(fontSize: 18, color: Colors.grey[700]),
    );
  }

  Widget _genreList(BuildContext context) {
    List<String> genres = ["Pop", "Classical", "Jazz", "Hip Hop", "Country"];

    return Expanded(
      child: ListView.builder(
        itemCount: genres.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.blue[100],
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text(
                genres[index],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.blue[900]),
              ),
              trailing: Icon(Icons.music_note, color: Colors.blue[900]),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Coming soon: ${genres[index]} music")),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
