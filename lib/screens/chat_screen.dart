import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  //Socketsbay socket service connection
  final channel = WebSocketChannel.connect(Uri.parse(
      'wss://socketsbay.com/wss/v2/1/demo/'
  ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Socket Chat')),
      body: StreamBuilder(
        stream: channel.stream,
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (dataSnapshot.hasError) {
            return Text(
              'ERROR: ${dataSnapshot.error}',
              style: const TextStyle(color: Colors.red),
            );
          }
          return Text(dataSnapshot.hasData ? '${dataSnapshot.data}' : '');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          channel.sink.add('Message Sent!');
        },
      ),
    );
  }
}