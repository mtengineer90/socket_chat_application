import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socket_chat_application/utils/constants.dart';
import '../controller/chat_controller.dart';
import '../utils/widgets.dart';

class ChatScreen extends StatefulWidget {
  final String name;
  const ChatScreen({Key? key, required this.name}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //Getx ChatController
  final ChatController chatController = Get.put(ChatController());
  final messageController = TextEditingController();

  /* Socketsbay doesn't allow to see self messages, so I control for showing self messages with this userIter boolean variable */
  bool userIter = false;

  /* Dummy messages - 1 for user and 1 for Friend */
  void greetingsDummy() {
    classMessages.add(ClassOfMessage('Hello', false));
    classMessages.add(ClassOfMessage('Hi', true));
  }

  @override
  void initState() {
    super.initState();
    greetingsDummy();
  }

/* Enable user to send message */
  void sendUserMessage() {
    if (messageController.text.isNotEmpty) {
      setState(() {
        chatController.channel.sink.add(
          messageController.text.toString(),
        );
        classMessages
            .add(ClassOfMessage(messageController.text.toString(), true));
        userIter = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var time = DateTime.now().timeAgo;

    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        backgroundColor: primaryColor,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            text(widget.name.toString(), textColor: Colors.white),
            text(time.toString(),
                fontSize: textSizeSmall, textColor: Colors.white),
          ],
        ),
        centerTitle: true,
        actions: [
          const Icon(
            Icons.more_vert,
          ).paddingRight(10)
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: StreamBuilder(
                    stream: chatController.channel.stream,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      /* State Waiting */
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: CircularProgressIndicator(color: primaryColor));
                      }
                      /* State Error */
                      else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      /* State OK */
                      else {
                        /* Controlling User Iteraction and adding Dummy Data for initialization */
                        if (userIter != true || classMessages.length < 4) {
                          classMessages.add(ClassOfMessage(snapshot.data, false));
                        }
                        userIter = false;
                        return SingleChildScrollView(
                          reverse: true,
                          physics: const ScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: classMessages.length,
                                itemBuilder: (context, index) {
                                  if (classMessages[index].fromUser) {
                                    return MyChatBubbleCard(index);
                                  } else {
                                    return FriendChatCard(index);
                                  }
                                },
                              )
                            ],
                          ).paddingAll(20),
                        );
                      }
                    },
                  )),
              Row(
                children: <Widget>[
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.all(0),
                      margin: const EdgeInsets.only(
                          top: 5, left: 10, bottom: 5, right: 10),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                              bottomLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0)),
                          color: Colors.white,
                          border: Border.all(width: 0.5, color: Colors.grey)),
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: const Icon(
                              Icons.attach_file,
                              color: Colors.black38,
                            ),
                          ),
                          Flexible(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxHeight: 120.0,
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                reverse: true,
                                child: TextField(
                                  maxLines: null,
                                  autofocus: false,
                                  controller: messageController,
                                  decoration: const InputDecoration(
                                    hintText: "Type a message here...",
                                    contentPadding: EdgeInsets.fromLTRB(
                                        10.0, 10.0, 20.0, 10.0),
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (value) {},
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      sendUserMessage();
                      messageController.clear();
                    },
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(100.0)),
                            color: primaryColor,
                            border: Border.all(width: 0.5, color: Colors.grey)),
                        margin: const EdgeInsets.only(right: 15),
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 18,
                        )),
                  )
                ],
              ).paddingBottom(5),
            ],
          ),
        ],
      ),
    );
  }
}