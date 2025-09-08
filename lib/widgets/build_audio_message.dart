import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/widgets/build_message.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class BuildAudioMessage extends StatefulWidget {
  const BuildAudioMessage({
    super.key,
    required this.messageModel,
    this.userName,
  });
  final MessageModel messageModel;
  final String? userName;

  @override
  State<BuildAudioMessage> createState() => _BuildAudioMessageState();
}

class _BuildAudioMessageState extends State<BuildAudioMessage> {
  PlayerController? _playerController;
  bool isPlaying = false;
  String? localPath;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _playerController = PlayerController();

    _prepareVoiceMessage();
    _playerController!.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    _playerController!.onCompletion.listen((event) {
      _playerController!.stopPlayer();
      _playerController!.seekTo(0); // يرجع لأول الصوت
      setState(() {
        isPlaying = false;
      });
    });
  }

  final playerWaveStyle = PlayerWaveStyle(
    fixedWaveColor: const Color.fromARGB(255, 207, 207, 207),
    liveWaveColor: Colors.white,
    spacing: 6,
  );

  prepareAudio() async {
    await _playerController!.preparePlayer(
      path: localPath!,
      shouldExtractWaveform: true,
      noOfSamples: (MediaQuery.sizeOf(context).width * 0.4) ~/ 6,
    );
  }

  Future<void> _prepareVoiceMessage() async {
    if (widget.messageModel.voice == null) return;

    // Download voice from Firebase to local file
    final ref = FirebaseStorage.instance.refFromURL(widget.messageModel.voice!);
    final tempDir = await getTemporaryDirectory();
    final filePath =
        '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.m4a';
    final file = File(filePath);
    await ref.writeToFile(file);
    localPath = filePath;

    // Prepare waveform
    await prepareAudio();

    widget.messageModel.playerController = _playerController;
    widget.messageModel.localPath = localPath;
  }

  playVoice() async {
    if (_playerController!.playerState == PlayerState.stopped) {
      await prepareAudio();
    }
    if (_playerController != null && !isPlaying) {
      await _playerController!.startPlayer();
    }

    setState(() {
      isPlaying = true;
    });
  }

  pauseVoice() async {
    if (_playerController != null) {
      await _playerController!.pausePlayer();
    }
    setState(() {
      isPlaying = false;
    });
  }

  @override
  void dispose() {
    _playerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildAudioMessage(
        userName: widget.userName,
        context: context,
        isPlaying: isPlaying,
        playVoice: playVoice,
        pauseVoice: pauseVoice,
        playerController: _playerController,
        playerWaveStyle: playerWaveStyle,
        messageModel: widget.messageModel);
  }
}
