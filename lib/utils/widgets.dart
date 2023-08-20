import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'constants.dart';

//User Chat Bubble Widget
class MyChatBubbleCard extends StatefulWidget {
  final index;

  MyChatBubbleCard(this.index);

  @override
  _MyChatBubbleCardState createState() => _MyChatBubbleCardState();
}

class _MyChatBubbleCardState extends State<MyChatBubbleCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Container(
        margin: const EdgeInsets.only(left: 0, right: 0, top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(top: 4, left: 70),
                    decoration: BoxDecoration(
                      color: myChatBubbleColor,
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      border: Border.all(width: 0.2, color: Colors.grey),
                    ),
                    child: Text(
                      classMessages[widget.index].info,
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        ////// <<<<< Time & date >>>>> //////
                        Text(
                          DateTime.now().timeAgo,
                          style:
                          const TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                        Container(
                            margin: const EdgeInsets.only(left: 3),
                            child: classMessages.length == widget.index + 1
                            ////// <<<<< Sent >>>>> //////
                                ? const Icon(
                              Icons.done,
                              size: 15,
                              color: Colors.grey,
                            )
                            ////// <<<<< Seen >>>>> //////
                                : const Icon(
                              Icons.done_all,
                              size: 15,
                              color: Colors.blueAccent,
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Friend Chat Bubble Widget
class FriendChatCard extends StatefulWidget {
  final index;

  FriendChatCard(this.index);

  @override
  _FriendChatCardState createState() => _FriendChatCardState();
}

class _FriendChatCardState extends State<FriendChatCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Container(
        margin: const EdgeInsets.only(left: 0, right: 0, top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(top: 4, right: 70),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      border: Border.all(width: 0.2, color: Colors.grey),
                    ),
                    child: Text(
                      classMessages[widget.index].info,
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          DateTime.now().timeAgo,
                          style:
                          const TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Simple Text Widget for UI
Widget text(String? text,
    {var fontSize = textSizeMedium,
      Color? textColor,
      var fontFamily = 'Poppins',
      var isCentered = false,
      var maxLine = 1,
      TextOverflow? overflow,
      var latterSpacing = 0.5,
      bool textAllCaps = false,
      var isLongText = false,
      bool lineThrough = false,
      var fontWeight = FontWeight.w400}) {
  return Text(
    textAllCaps ? text!.toUpperCase() : text!,
    textAlign: isCentered ? TextAlign.center : TextAlign.start,
    maxLines: isLongText ? null : maxLine,
    overflow: overflow,
    style: TextStyle(
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: textColor ?? textColorPrimary,
      height: 1.5,
      letterSpacing: latterSpacing,
      decoration:
      lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
    ),
  );
}

/* Widget for user input */
Widget inputWidgetUser(TextEditingController userInput, String hintTitle,
    TextInputType keyboardType) {
  return Container(
    height: 55,
    margin: const EdgeInsets.only(bottom: 15),
    decoration: BoxDecoration(
        color: Colors.blueGrey.shade100,
        borderRadius: BorderRadius.circular(30)),
    child: Padding(
      padding: const EdgeInsets.only(left: 25.0, top: 15, right: 25),
      child: TextField(
        controller: userInput,
        autocorrect: false,
        enableSuggestions: false,
        autofocus: false,
        decoration: InputDecoration.collapsed(
          hintText: hintTitle,
          hintStyle: const TextStyle(
              fontSize: 18, color: Colors.white70, fontStyle: FontStyle.italic),
        ),
        keyboardType: keyboardType,
      ),
    ),
  );
}

/*Message Class Modal*/
class ClassOfMessage {
  final String info;
  final bool fromUser;

  ClassOfMessage(this.info, this.fromUser);
}