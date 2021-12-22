


import 'package:flutter_sound/public/flutter_sound_recorder.dart';

import 'package:permission_handler/permission_handler.dart';

final path='audio_example.aac';

class SoundRecorder{
  FlutterSoundRecorder? _recorder;
  bool _isRecorderInitialized=false;
  bool get isRecording=>_recorder!.isRecording;
  Future _record()async {
    // Directory dir=await getApplicationDocumentsDirectory();
    // String filepath=dir.path+'.aac';
    if(!_isRecorderInitialized) return;
    await _recorder!.startRecorder(toFile: path);
  }
  Future _stop() async {
    if(!_isRecorderInitialized) return;
    await _recorder!.stopRecorder();
  }
  Future toggleRecorder()async{
    if(_recorder!.isStopped)
      await _record();
    else
      await _stop();
  }
  Future init() async{
    _recorder=FlutterSoundRecorder();
    final status=await Permission.microphone.request();
    if(status != PermissionStatus.granted){
      print("sex");
      throw RecordingPermissionException('Microphone Permission Required');
    }
    await _recorder!.openAudioSession();
    _isRecorderInitialized=true;
  }
  void dispose(){
    if(!_isRecorderInitialized) return;
    _recorder!.closeAudioSession();
    _recorder=null;
    _isRecorderInitialized=false;
  }
}