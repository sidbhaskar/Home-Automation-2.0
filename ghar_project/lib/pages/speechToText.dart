import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:permission_handler/permission_handler.dart';

class Speechtotext extends StatefulWidget {
  const Speechtotext({super.key});

  @override
  State<Speechtotext> createState() => _SpeechtotextState();
}

class _SpeechtotextState extends State<Speechtotext> {
  var textSpeech = "click on the mic";
  SpeechToText speechToText = SpeechToText();

  var isListening = false;

  void checkMic() async {
    var status = await Permission.microphone.status;
    if (!status.isGranted) {
      status = await Permission.microphone.request();
    }

    if (status.isGranted) {
      try {
        bool micAvailable = await speechToText.initialize();
        if (micAvailable) {
          print("Mic available");
        } else {
          print('Mic not available');
        }
      } catch (e) {
        print('Error initializing speech recognition: $e');
      }
    } else {
      print('Microphone permission denied');
    }
  }

  @override
  void initState() {
    super.initState();
    checkMic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(textSpeech),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (!isListening) {
            bool micAvailable = await speechToText.initialize();
            if (micAvailable) {
              setState(() {
                isListening = true;
              });

              speechToText.listen(
                listenFor: Duration(seconds: 10),
                onResult: (result) {
                  setState(() {
                    textSpeech = result.recognizedWords;
                  });
                },
              );
            }
          } else {
            setState(() {
              isListening = false;
              speechToText.stop();
            });
          }
        },
        child: isListening ? Icon(Icons.record_voice_over) : Icon(Icons.mic),
        shape: CircleBorder(),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
