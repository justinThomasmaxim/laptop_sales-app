// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/widgets/HomeAppBar.dart';

// class GeminiPageWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             HomeAppBar(),
//             Text("Gemini"),
//           ],
//         ),
//         Container(
//           height: 630,
//           padding: EdgeInsets.only(top: 15),
//           decoration: BoxDecoration(
//             color: Color(0xFFEDECF2),
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(35),
//               topRight: Radius.circular(35),
//             )
//           ),
//           child: Column(
//           children: [
//             // Container(
//             //   margin: EdgeInsets.symmetric(horizontal: 15),
//             //   padding: EdgeInsets.symmetric(horizontal: 15),
//             //   height: 50,
//             //   decoration: BoxDecoration(
//             //     color: Colors.white,
//             //     borderRadius: BorderRadius.circular(30),
//             //   ),
//             Column(
//               children: [
//                 Container(
//                   width: 800,
//                   margin: EdgeInsets.symmetric(horizontal: 15),
//                   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                   decoration: BoxDecoration(
//                     color: Colors.purple,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(10),
//                       topRight: Radius.circular(10),
//                     )
//                   ),
//                   child: Container(
//                     alignment: Alignment.center,
//                     child:  Text("Chat Bot", style: TextStyle(color: Colors.white),),
//                   ),
//                 ),

//                 // Tambahkan scroll
//                 SingleChildScrollView(
//                   child: Container(
//                     width: 800,
//                     height: 500,
//                     margin: EdgeInsets.symmetric(horizontal: 15),
//                     padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                     decoration: BoxDecoration(
//                       color: Color.fromRGBO(250, 250, 250, 1),
//                       borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(10),
//                         bottomRight: Radius.circular(10),
//                       )
//                     ),
//                     child: Column(
//                       children: [

//                         Text("Chat Bot", style: TextStyle(color: Colors.white),),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ]
//         ),
//         )
//       ]
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Chatbot',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: GeminiPageWidget(),
//     );
//   }
// }

// class GeminiPageWidget extends StatefulWidget {
//   @override
//   _GeminiPageWidgetState createState() => _GeminiPageWidgetState();
// }

// class _GeminiPageWidgetState extends State<GeminiPageWidget> {
//   final List<Message> _messages = [];
//   final TextEditingController _controller = TextEditingController();

//   void _sendMessage(String text) async {
//     if (text.isEmpty) return;

//     setState(() {
//       _messages.add(Message(text: text, isUser: true));
//     });

//     _controller.clear();

//     try {
//       String response = await fetchResponse(text);
//       setState(() {
//         _messages.add(Message(text: response, isUser: false));
//       });
//     } catch (e) {
//       setState(() {
//         _messages.add(Message(text: "Error fetching response", isUser: false));
//       });
//     }
//   }

//   Future<String> fetchResponse(String prompt) async {
//     final response = await http.post(
//       Uri.parse('https://gemini-chatbot-api-guip.vercel.app/gemini?prompt=${Uri.encodeComponent(prompt)}'),
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       return data['response']; // Adjust according to your API response structure
//     } else {
//       throw Exception('Failed to load response');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Gemini Chatbot"),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: _messages.map((message) {
//                   return Container(
//                     alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
//                     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                     margin: EdgeInsets.symmetric(vertical: 5),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: message.isUser ? Colors.blue[100] : Colors.grey[300],
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       padding: EdgeInsets.all(10),
//                       child: Text(message.text),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _controller,
//                     decoration: InputDecoration(
//                       hintText: 'Type a message',
//                     ),
//                     onSubmitted: _sendMessage,
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: () => _sendMessage(_controller.text),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class Message {
//   final String text;
//   final bool isUser;

//   Message({required this.text, required this.isUser});
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatbot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GeminiPageWidget(),
    );
  }
}

class GeminiPageWidget extends StatefulWidget {
  @override
  _GeminiPageWidgetState createState() => _GeminiPageWidgetState();
}

class _GeminiPageWidgetState extends State<GeminiPageWidget> {
  final List<Message> _messages = [];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage(String text) async {
    if (text.isEmpty) return;

    setState(() {
      _messages.add(Message(text: text, isUser: true));
    });

    _controller.clear();

    // String response = await fetchResponse(text);
    // setState(() {
    //   _messages.add(Message(text: response, isUser: false));
    // });

    // print(response);

    try {
      String response = await fetchResponse(text);
      setState(() {
        _messages.add(Message(text: response, isUser: false));
      });
    } catch (e) {
      setState(() {
        _messages.add(Message(text: "Error fetching response", isUser: false));
      });
    }
  }

  Future<String> fetchResponse(String prompt) async {
    final response = await http.post(
      Uri.parse(
          'https://gemini-chatbot-api-guip.vercel.app/gemini?prompt=${Uri.encodeComponent(prompt)}'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['text']; // Sesuaikan dengan struktur respons API Anda
    } else {
      throw Exception('Failed to load response');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gemini Chatbot"),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: _messages.map((message) {
                  return Container(
                    alignment: message.isUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: message.isUser
                            ? Colors.blue[100]
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Text(message.text),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                    ),
                    onSubmitted: _sendMessage,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => _sendMessage(_controller.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  String text;
  bool isUser;

  Message({required this.text, required this.isUser});
}
