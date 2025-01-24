import 'package:chat_app/constants/const.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/views/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/widgets/chat_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  static String id = 'chat view';

  final ScrollController listController = ScrollController();
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // CollectionReference message =
    //     FirebaseFirestore.instance.collection(kCollectionName);
    var email = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kPrimaryColor,
          title: Text(
            'Chat',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatCubit, ChatState>(
                builder: (context, state) {
                  List<MessageModel> messagesList =
                      BlocProvider.of<ChatCubit>(context).messagesList;
                  return ListView.builder(
                    reverse: true,
                    controller: listController,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email
                          ? ChatContainer(messageModel: messagesList[index])
                          : ChatContainerForFriend(
                              messageModel: messagesList[index]);
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: controller,
                // onSubmitted: (value) {
                //   message.add(
                //     {
                //       'message': value,
                //       'createdAt': DateTime.now(),
                //       'id': email
                //     },
                //   );
                //   controller.clear();
                //   listController.animateTo(0,
                //       duration: Duration(seconds: 1),
                //       curve: Curves.bounceIn);
                // },

                decoration: InputDecoration(
                    hintText: 'Send Message',
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (controller.text.trim().isNotEmpty) {
                          // message.add({
                          //   kMessage: controller.text.trim(),
                          //   kTime: DateTime.now(),
                          //   kId: email
                          // });
                          BlocProvider.of<ChatCubit>(context).sendMessage(
                              message: controller.text.trim(),
                              email: email.toString());
                          controller.clear();
                          listController.animateTo(0,
                              duration: Duration(microseconds: 500),
                              curve: Curves.easeIn);
                        }
                      },
                      icon: Icon(
                        Icons.send,
                        color: kPrimaryColor,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: kPrimaryColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: kPrimaryColor),
                    )),
              ),
            )
          ],
        ));

    // StreamBuilder<QuerySnapshot>(
    //   stream: message.orderBy(kTime, descending: true).snapshots(),
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       List<MessageModel> messageList = [];
    //       for (var doc in snapshot.data!.docs) {
    //         messageList.add(MessageModel.fromJson(doc));
    //       }
    //       // List<MessageModel> messageList = snapshot.data!.docs.map((doc) {
    //       //   return MessageModel.fromJson(doc);
    //       // }).toList();

    //       return Scaffold(
    //           appBar: AppBar(
    //             automaticallyImplyLeading: false,
    //             backgroundColor: kPrimaryColor,
    //             title: Text(
    //               'Chat',
    //               style: TextStyle(color: Colors.white),
    //             ),
    //             centerTitle: true,
    //           ),
    //           body: Column(
    //             children: [
    //               Expanded(
    //                 child: ListView.builder(
    //                   reverse: true,
    //                   controller: listController,
    //                   itemCount: messageList.length,
    //                   itemBuilder: (context, index) {
    //                     return messageList[index].id == email
    //                         ? ChatContainer(messageModel: messageList[index])
    //                         : ChatContainerForFriend(
    //                             messageModel: messageList[index]);
    //                   },
    //                 ),
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.all(16.0),
    //                 child: TextField(
    //                   controller: controller,
    //                   // onSubmitted: (value) {
    //                   //   message.add(
    //                   //     {
    //                   //       'message': value,
    //                   //       'createdAt': DateTime.now(),
    //                   //       'id': email
    //                   //     },
    //                   //   );
    //                   //   controller.clear();
    //                   //   listController.animateTo(0,
    //                   //       duration: Duration(seconds: 1),
    //                   //       curve: Curves.bounceIn);
    //                   // },

    //                   decoration: InputDecoration(
    //                       hintText: 'Send Message',
    //                       suffixIcon: IconButton(
    //                         onPressed: () {
    //                           if (controller.text.trim().isNotEmpty) {
    //                             message.add({
    //                               kMessage: controller.text.trim(),
    //                               kTime: DateTime.now(),
    //                               kId: email
    //                             });
    //                             controller.clear();
    //                             listController.animateTo(0,
    //                                 duration: Duration(microseconds: 500),
    //                                 curve: Curves.easeIn);
    //                           }
    //                         },
    //                         icon: Icon(
    //                           Icons.send,
    //                           color: kPrimaryColor,
    //                         ),
    //                       ),
    //                       border: OutlineInputBorder(
    //                         borderRadius: BorderRadius.circular(16),
    //                         borderSide: BorderSide(color: kPrimaryColor),
    //                       ),
    //                       enabledBorder: OutlineInputBorder(
    //                         borderRadius: BorderRadius.circular(16),
    //                         borderSide: BorderSide(color: kPrimaryColor),
    //                       )),
    //                 ),
    //               )
    //             ],
    //           ));
    //     } else {
    //       return ModalProgressHUD(
    //         inAsyncCall: true,
    //         child: Scaffold(
    //           body: Column(),
    //         ),
    //       );
    //     }
    //   },
    // );
  }
}
