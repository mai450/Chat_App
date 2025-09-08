import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';

Widget buildTextMessage(
    {required MessageModel messageModel, String? userName}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (userName != null && userName != 'You')
        Text(
          userName,
          style: TextStyle(color: Colors.red),
        ),
      Row(
        children: [
          Text(
            messageModel.message!,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            formatTime(messageModel.time),
            style: TextStyle(
                color: const Color.fromARGB(255, 207, 207, 207), fontSize: 11),
          ),
        ],
      ),
    ],
  );
}

Widget buildAudioMessage({
  required BuildContext context,
  required bool isPlaying,
  required VoidCallback playVoice,
  required VoidCallback pauseVoice,
  required PlayerController? playerController,
  required PlayerWaveStyle playerWaveStyle,
  required MessageModel messageModel,
  String? userName,
}) {
  return SizedBox(
    width: MediaQuery.sizeOf(context).width * 0.7,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (userName != null && userName != 'You')
          Text(
            userName,
            style: TextStyle(color: Colors.red),
          ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                if (isPlaying) {
                  pauseVoice();
                } else {
                  playVoice();
                }
              },
              icon: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
              ),
            ),
            if (playerController != null)
              Expanded(
                child: AudioFileWaveforms(
                    size: Size(MediaQuery.sizeOf(context).width * 0.4, 30),
                    playerController: playerController,
                    enableSeekGesture: true,
                    //continuousWaveform: false,
                    // waveformData: waveformData!,
                    // [
                    //   1,
                    //   5,
                    //   10,
                    //   15,
                    //   20,
                    //   15,
                    //   10,
                    //   5,
                    //   1,
                    //   0,
                    //   3,
                    //   7,
                    //   12,
                    //   17,
                    //   22,
                    //   17,
                    //   12,
                    //   7,
                    //   3,
                    //   1
                    // ],
                    waveformType: WaveformType.fitWidth,
                    playerWaveStyle: playerWaveStyle),
              )
            else
              const SizedBox(
                width: 150,
                height: 50,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                formatTime(messageModel.time),
                style: const TextStyle(
                    color: Color.fromARGB(255, 207, 207, 207), fontSize: 12),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
