import 'package:flutter_tts/flutter_tts.dart';

class TTSManager {
  final FlutterTts _flutterTts = FlutterTts();
  bool isPlaying = false;

  Future<void> init() async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);

    _flutterTts.setStartHandler(() => isPlaying = true);
    _flutterTts.setCompletionHandler(() => isPlaying = false);
    _flutterTts.setErrorHandler((msg) => isPlaying = false);
  }

  Future<void> speak(String text) async {
    if (text.isNotEmpty) {
      await _flutterTts.speak(text);
    }
  }

  Future<void> pause() async {
    await _flutterTts.pause();
    isPlaying = false;
  }

  Future<void> stop() async {
    await _flutterTts.stop();
    isPlaying = false;
  }

  Future<void> setRate(double rate) async {
    await _flutterTts.setSpeechRate(rate);
  }
}
