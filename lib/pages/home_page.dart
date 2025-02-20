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
  void  initState() {
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
        title: const Text('Speech demo',
        style: TextStyle(
          color: Colors.white,
        ),),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(_speechToText.isListening ? "Listening..."
               : _speechEnabled ? "Tap the microphone to start listening.."
               : "Speech not enabled",
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            ),
            Expanded(
              
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Text(_wordsSpoken,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),),
            ),),
            if (_speechToText.isNotListening && _confidenceLevel > 0) 
            Padding(
              padding: const EdgeInsets.only(bottom:100),
              child: Text(
                  "confidence : ${(_confidenceLevel* 100).toStringAsFixed(1)}%",
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold)
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _speechToText.isListening ? _stoptListening : _startListening,
        tooltip: 'listen',
        child:  Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic,
        color: Colors.white,
        ),
        backgroundColor: Colors.green,
        ),
    );
  }
}
