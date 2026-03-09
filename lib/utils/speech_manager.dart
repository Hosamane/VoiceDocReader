import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechManager {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool isListening = false;

  Future<bool> init() async {
    return await _speech.initialize(
      onStatus: (status) => isListening = status == 'listening',
      onError: (error) => isListening = false,
    );
  }

  Future<void> startListening(Function(String) onResult) async {
    if (!isListening) {
      await _speech.listen(
        onResult: (result) {
          if (result.finalResult) {
            onResult(result.recognizedWords);
          }
        },
      );
    }
  }

  Future<void> stopListening() async {
    await _speech.stop();
    isListening = false;
  }
}
