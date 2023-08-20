import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../controller/chat_controller.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //Getx ChatController
  final ChatController chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Socket Chat')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Chat Data from Socket :',
                ),
                StreamBuilder(
                  stream: chatController.channel.stream,
                  builder: (context, snapshot) {
                    return Text(snapshot.hasData ? '${snapshot.data}' : '', style: Theme.of(context).textTheme.bodyLarge,);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}