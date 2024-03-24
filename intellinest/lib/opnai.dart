// import 'package:firebase_database/firebase_database.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class OpenAIService {
//     final dbR = FirebaseDatabase.instance.ref();
//   bool isSwitchOn = false; // Add this variable
//   final List<Map<String, String>> messages = [];
//   Future<String> isArtPromptAPI(String prompt) async {
//     try {
//       final res = await http.post(
//         Uri.parse('https://api.openai.com/v1/chat/completions'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $openAIAPIKey',
//         },
//         body: jsonEncode({
//           "model": "gpt-3.5-turbo",
//           "messages": [
//             // {"role": "system", "content": "You are a helpful assistant."},
//             {
//               "role": "user",
//               "content":
//                   " Does this message wants to generate an AI picture, image, art or anything similar? $prompt . Simply answer with a yes on no.",
//             }
//           ]
//         }),
//       );
//       print(res.body);
//       if (res.statusCode == 200) {
//         String content =
//             jsonDecode(res.body)['choices'][0]['message']['content'];
//         content = content.trim();

//         switch (content) {
//           case 'Yes':
//           case 'yes':
//           case 'yes.':
//           case 'Yes.':
//             final res = await dallEAPI(prompt);
//             return res;
//           // default:
//           //   final res = await chatGPTAPI(prompt);
//           //   return res;
//         }
//       }
//       return 'An internal error occured';
//     } catch (e) {
//       return e.toString();
//     }
//   }

//   Future<String> chatGPTAPI(String prompt) async {
//     messages.add(
//       {'role': 'user', 'content': prompt},
//     );
//     try {
//       final res = await http.post(
//         Uri.parse('https://api.openai.com/v1/chat/completions'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $openAIAPIKey',
//         },
//         body: jsonEncode({
//           "model": "gpt-3.5-turbo",
//           "messages": [
//             // {"role": "system", "content": "You are a helpful assistant."},
//             {
//               "role": "user",
//               "content": messages,
//             }
//           ]
//         }),
//       );
//       // print(res.body);
//       if (res.statusCode == 200) {
//         String content =
//             jsonDecode(res.body)['choices'][0]['message']['content'];
//         content = content.trim();
//         messages.add({
//           'role': 'assistant',
//           'content': content,
//         });
//       }
//       return 'An internal error occured';
//     } catch (e) {
//       return e.toString();
//     }
//   }
// }
