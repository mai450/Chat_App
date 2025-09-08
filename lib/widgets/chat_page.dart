import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:chat_app/constants/const.dart';
import 'package:chat_app/functions/prepare_voice.dart';
import 'package:chat_app/views/cubits/group_chat_cubit/group_chat_cubit.dart';
import 'package:chat_app/views/cubits/one_to_one_chat_cubit/one_to_one_chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:uuid/uuid.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    required this.title,
    this.senderUserName,
    required this.child,
    required this.listController,
    this.senderEmail,
    this.reciverEmail,
    required this.isGroup,
    this.reciverUserName,
    this.groupId,
    required this.appBar,
    required this.textField,
    required this.controller,
  });
  final String title;
  final String? senderEmail, reciverEmail, senderUserName, reciverUserName;
  final Widget child;
  final ScrollController listController;
  final bool isGroup;
  final String? groupId;
  final PreferredSizeWidget appBar;
  final Widget textField;
  final TextEditingController controller;
  static String id = 'chat view';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late AudioRecorder audioRecorder;
  late AudioPlayer audioPlayer;
  String path = '';
  String url = "";
  bool isRecording = false;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {});
    });

    audioRecorder = AudioRecorder();
    audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    audioRecorder.dispose();
    audioPlayer.dispose();
    widget.controller.dispose();
    super.dispose();
  }

  Future<void> startRecording() async {
    final location = await getApplicationDocumentsDirectory();
    String name = Uuid().v1();
    if (await audioRecorder.hasPermission()) {
      await audioRecorder.start(RecordConfig(),
          path: '${location.path}$name.m4a');

      setState(() {
        isRecording = true;
      });
    }
  }

  Future<String?> stopRecording() async {
    String? finalPath = await audioRecorder.stop();

    setState(() {
      path = finalPath!;
      isRecording = false;
    });
    return finalPath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: widget.appBar,
        body: Column(
          children: [
            widget.child,
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  widget.textField,
                  SizedBox(
                    width: 10,
                  ),
                  widget.controller.text.isEmpty
                      ? CircleAvatar(
                          backgroundColor: kPrimaryColor,
                          child: IconButton(
                              onPressed: () async {
                                if (isRecording) {
                                  String? recordedPath = await stopRecording();
                                  if (recordedPath != null &&
                                      File(recordedPath).existsSync()) {
                                    String voiceUrl =
                                        await uploadVoice(voicePath: path);

                                    widget.isGroup
                                        ? BlocProvider.of<GroupChatCubit>(
                                                context)
                                            .sendMessage(
                                                groupId: widget.groupId!,
                                                email: widget.senderEmail!
                                                    .toString(),
                                                senderUserName:
                                                    widget
                                                        .senderUserName!
                                                        .toString(),
                                                url: voiceUrl)
                                        : BlocProvider.of<
                                                OneToOneChatCubit>(context)
                                            .setOneToOneMessage(
                                                senderEmail:
                                                    widget
                                                        .senderEmail
                                                        .toString(),
                                                receiverEmail:
                                                    widget
                                                        .reciverEmail
                                                        .toString(),
                                                receiverUserName:
                                                    widget
                                                        .reciverUserName
                                                        .toString(),
                                                senderUserName: widget
                                                    .senderUserName
                                                    .toString(),
                                                url: voiceUrl);
                                    setState(() {
                                      url = voiceUrl;
                                    });
                                  }
                                } else {
                                  startRecording();
                                }
                              },
                              icon: isRecording
                                  ? Icon(Icons.stop)
                                  : Icon(Icons.mic),
                              color: Colors.white))
                      : IconButton(
                          onPressed: () {
                            if (widget.controller.text.trim().isNotEmpty) {
                              widget.isGroup
                                  ? BlocProvider.of<GroupChatCubit>(context)
                                      .sendMessage(
                                          groupId: widget.groupId!,
                                          message:
                                              widget.controller.text.trim(),
                                          email: widget.senderEmail.toString(),
                                          senderUserName:
                                              widget.senderUserName!.toString())
                                  : BlocProvider.of<OneToOneChatCubit>(context)
                                      .setOneToOneMessage(
                                          senderEmail:
                                              widget.senderEmail.toString(),
                                          receiverEmail:
                                              widget.reciverEmail.toString(),
                                          receiverUserName:
                                              widget.reciverUserName.toString(),
                                          senderUserName:
                                              widget.senderUserName.toString(),
                                          message:
                                              widget.controller.text.trim());
                              widget.controller.clear();
                              widget.listController.animateTo(0,
                                  duration: Duration(microseconds: 500),
                                  curve: Curves.easeIn);
                            }
                          },
                          icon: Icon(
                            Icons.send,
                            color: kPrimaryColor,
                          ),
                        ),
                ],
              ),
            )
          ],
        ));
  }
}
