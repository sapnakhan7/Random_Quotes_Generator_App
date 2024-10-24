import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:quote_app/models/quotes_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Quotes> quotes = [];
  int currentIndex = 0;


  final List<String> backgroundImages = [
    'assets/abdul klam.jpeg',
    'assets/Abraham Lincoln.jpeg',
    'assets/Albert Einstein.jpeg',
    'assets/Aristotle.jpeg',
    'assets/bill gates.jpeg',
    'assets/mohammad ali.jpeg',
    'assets/Mother Teresa.jpeg',
    'assets/Nelson Mandela.jpeg',
    'assets/Oprah Winfrey.jpeg',
    'assets/rumi.jpg',
    'assets/Walt Disney.jpeg',
    'assets/William Shakespeare.jpeg',
  ];

  Future<QuotesModel> fetchQuote() async {
    final url = 'https://dummyjson.com/quotes';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      QuotesModel quotesModel = QuotesModel.fromJson(jsonData);
      return quotesModel;
    } else {
      throw Exception('Failed to load quote');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchQuote().then((quotesModel) {
      setState(() {
        quotes = quotesModel.quotes!;
      });
    });
  }

  void showNextQuote() {
    setState(() {
      currentIndex = (currentIndex + 1) % quotes.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("QUOTES", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,fontStyle: FontStyle.italic)),
        centerTitle: true,
      ),
      body: quotes.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              backgroundImages[currentIndex % backgroundImages.length],
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.8),
              colorBlendMode: BlendMode.darken,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    quotes[currentIndex].quote!,
                    style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    quotes[currentIndex].author!,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    side: BorderSide(color: Colors.black, width: 2),
                  ),
                  onPressed: showNextQuote,
                  child: Text("New Quote"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

















































































































































































































































































































































































































// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import 'package:quotes_generator_app/models/quotes_model.dart';
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   List<String> images=[];
//
//   // Future<Map<String, dynamic>>? _futureQuote;
//
//   Future<QuotesModel> fetchQuote() async {
//     final url='https://dummyjson.com/quotes';
//     final response = await http.get(Uri.parse(url));
//     print(response.statusCode);
//
//     if (response.statusCode == 200) {
//       var jsonData = json.decode(response.body);
//       print(jsonData);
//       QuotesModel quotesModel= QuotesModel.fromJson(jsonData);
//       print(quotesModel.quotes);
//       return quotesModel;
//     } else {
//       throw Exception('Failed to load quote');
//     }
//   }
//   @override
//   void initState() {
//     super.initState();
//     fetchQuote();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:Center(
//         child: FutureBuilder<QuotesModel>(
//           future: fetchQuote(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return CircularProgressIndicator();
//             }
//             if (snapshot.hasData) {
//               final quotes = snapshot.data!.quotes!;
//               return ListView.builder(
//                   itemCount: quotes.length,
//                   itemBuilder: (context,index){
//                     return Text(quotes![index].quote!);
//                   });
//             }
//
//             return Text('Error fetching quote');
//           },
//         ),
//       ),
//     );
//   }
// }
