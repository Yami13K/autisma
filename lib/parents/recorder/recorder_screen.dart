import 'package:autisma/parents/recorder/models/sound_recorder.dart';
import 'package:flutter/material.dart';

import 'models/sound_player.dart';

class Recorder extends StatefulWidget {
  const Recorder({Key? key}) : super(key: key);

  @override
  _RecorderState createState() => _RecorderState();
}

class _RecorderState extends State<Recorder> {
  final recorder=SoundRecorder();
  final player=SoundPlayer();

  @override
  void initState() {
    // TODO: implement initState

    recorder.init();
    player.init();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    player.dispose();
    recorder.dispose();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Recorder"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RecordButton(),
            SizedBox(height: 30,),
            PlayButton()
          ],
        ),
      ),
    );
  }

  ElevatedButton RecordButton() {
    final isRecording=recorder.isRecording;
    final icon=isRecording ? Icons.stop : Icons.mic;
    final text =isRecording ? 'Stop' : 'Start';
    final primary= isRecording ? Colors.red :Colors.white;
    final onPrimary= isRecording ? Colors.white : Colors.black;
    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(175,50),
          primary: primary,
          onPrimary: onPrimary
        ),
        icon: Icon(icon),
        label: Text(text,style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold
        ),),
        onPressed: () async{
          await recorder.toggleRecorder();
          setState(() {});
        },
      );
  }
  ElevatedButton PlayButton(){
    final isPlaying=player.isPlaying;
    final icon=isPlaying ? Icons.stop : Icons.play_arrow;
    final text=isPlaying ? 'Stop Playing' :'Play Recording';
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          minimumSize: Size(175,50),
          primary: Colors.white,
          onPrimary: Colors.black,
      ),
      icon: Icon(icon),
      label: Text(text,style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold
      ),),
      onPressed: () async{
        await player.togglePlayer(whenfinished:()=>setState(() {
        }) );
        setState(() {

        });
      },
    );
  }
}
