// import 'package:flutter/material.dart';

// class Holder extends StatelessWidget {
//   const Holder({super.key});

  
//   @override
//   Widget build(BuildContext context) {
//     CollectionReference message =
//         FirebaseFirestore.instance.collection(kCollectionName);

//     return StreamBuilder<QuerySnapshot>(
//       stream: message
//           .orderBy('createdAt')
//           .snapshots(), // Listen to real-time updates
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           List<MessageModel> messageList = snapshot.data!.docs.map((doc) {
//             return MessageModel.fromJson(doc);
//           }).toList();

//           return Scaffold(
//             appBar: AppBar(
//               automaticallyImplyLeading: false,
//               backgroundColor: kPrimaryColor,
//               title: Text(
//                 'Chat',
//                 style: TextStyle(color: Colors.white),
//               ),
//               centerTitle: true,
//             ),
//             body: Column(
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: messageList.length,
//                     itemBuilder: (context, index) {
//                       return ChatContainer(messageModel: messageList[index]);
//                     },
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: TextField(
//                     controller: controller,
//                     onSubmitted: (value) {
//                       message
//                           .add({'message': value, 'createdAt': DateTime.now()});
//                       controller.clear(); // Clear the text after sending
//                     },
//                     decoration: InputDecoration(
//                       hintText: 'Send Message',
//                       suffixIcon: Icon(
//                         Icons.send,
//                         color: kPrimaryColor,
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(16),
//                         borderSide: BorderSide(color: kPrimaryColor),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(16),
//                         borderSide: BorderSide(color: kPrimaryColor),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error loading messages.'));
//         } else {
//           return Center(
//               child:
//                   CircularProgressIndicator()); // Show a spinner instead of text
//         }
//       },
//     );
//   }
// }