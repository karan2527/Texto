import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final SpeechToText _speechToText = SpeechToText();

  bool _speechEnabled = false;
  String _wordsSpoken = "";
  double _confidenceLevel = 0;
  void initState() {
    super.initState();
    initSpeech();
  }

  void initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {
      _confidenceLevel = 0;
    });
  }
  void _stoptListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(result) {
    setState(() {
      _wordsSpoken = "${result.recognizedWords}";
      _confidenceLevel = result.confidence;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Speech demo',
        style: TextStyle(
          color: Colors.white,
        ),),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                child: Text(_speechToText.isListening ? "Listening..."
                 : _speechEnabled ? "Tap the microphone to start listening.."
                 : "Speech not enabled",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _speechToText.isListening ? _stoptListening : _startListening,
        tooltip: 'listen',
        child: Icon(_speechToText.isListening ? Icons.mic_off : Icons.mic,
        color: Colors.white,
        ),
        backgroundColor: Colors.red,
        ),
    );
  }
}
