import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isVisible = false;
  late AudioPlayer player;
  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void toggleShowText() {
    isVisible = !isVisible;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: isVisible,
                child: Image.asset('assets/images/yazyuu.jpeg'),
              ),
              ElevatedButton(
                onPressed: () async {
                  setState(toggleShowText);
                  await player.setAsset('assets/audio/yarimasune.mp3');
                  player.play();
                },
                child: const Text('やりますね~'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
