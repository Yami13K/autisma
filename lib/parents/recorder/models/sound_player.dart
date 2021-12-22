import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
final path="audio_example.aac";
class SoundPlayer{
  FlutterSoundPlayer? _player;
  Future init() async{
    _player=FlutterSoundPlayer();
    await _player!.openAudioSession();
  }
  bool get isPlaying=>_player!.isPlaying;
  void dispose(){
    _player!.closeAudioSession();
    _player=null;
  }
  Future _play(VoidCallback whenfinished)async{
    await _player!.startPlayer(fromURI: path,whenFinished: whenfinished);
  }
  Future _stop() async{
    await _player!.stopPlayer();
  }
  Future togglePlayer({required VoidCallback whenfinished}) async{
    if(_player!.isStopped)
      await _play(whenfinished);
    else
      await _stop();
  }
}