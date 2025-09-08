import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class VoicePlayerHelper {
  static Future<String?> prepareVoiceMessage({
    required String voiceUrl,
    required PlayerController playerController,
    bool extractWaveform = true,
    int noOfSamples = 50,
  }) async {
    final ref = FirebaseStorage.instance.refFromURL(voiceUrl);
    final tempDir = await getTemporaryDirectory();
    final filePath =
        '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.m4a';
    final file = File(filePath);
    await ref.writeToFile(file);

    await playerController.preparePlayer(
      path: filePath,
      shouldExtractWaveform: extractWaveform,
      noOfSamples: noOfSamples,
    );

    return filePath;
  }

  static Future<void> playVoice({
    required PlayerController playerController,
    required VoidCallback onCompleted,
  }) async {
    await playerController.startPlayer();
    playerController.onCompletion.listen((_) {
      playerController.stopPlayer();
      playerController.seekTo(0);
      onCompleted();
    });
  }

  static Future<void> pauseVoice({
    required PlayerController playerController,
  }) async {
    await playerController.pausePlayer();
  }
}

mixin VoiceMessageMixin<T extends StatefulWidget> on State<T> {
  PlayerController? playerController;
  bool isPlaying = false;
  String? localPath;
  MessageModel? messageModel;
  bool playerInitialized = false;

  void initializePlayer(MessageModel messageModel) {
    if (!playerInitialized) {
      playerController = PlayerController();
      _initVoiceMessage(messageModel);

      playerController!.onPlayerStateChanged.listen((state) {
        setState(() {
          isPlaying = state == PlayerState.playing;
        });
      });
      playerInitialized = true;
    }
  }

  Future<void> _initVoiceMessage(MessageModel messageModel) async {
    if (messageModel.voice != null && playerController != null) {
      localPath = await VoicePlayerHelper.prepareVoiceMessage(
        voiceUrl: messageModel.voice!,
        playerController: playerController!,
      );
      messageModel.localPath = localPath;
      messageModel.playerController = playerController;
    }
  }

  void playVoice() async {
    if (playerController != null) {
      await VoicePlayerHelper.playVoice(
        playerController: playerController!,
        onCompleted: () {
          setState(() {
            isPlaying = false;
          });
        },
      );
      setState(() {
        isPlaying = true;
      });
    }
  }

  void pauseVoice() async {
    if (playerController != null) {
      await VoicePlayerHelper.pauseVoice(playerController: playerController!);
      setState(() {
        isPlaying = false;
      });
    }
  }

  void disposePlayer() {
    playerController?.dispose();
  }
}

uploadVoice({required String voicePath}) async {
  final storageRef = FirebaseStorage.instance
      .ref()
      .child('voices/${DateTime.now().millisecondsSinceEpoch}.m4a');
  await storageRef.putFile(File(voicePath));
  String voiceUrl = await storageRef.getDownloadURL();
  return voiceUrl;
}
