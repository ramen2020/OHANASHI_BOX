import 'package:chat_sample/screens/chat/messages_list.dart';
import 'package:chat_sample/screens/chat/send_message_form.dart';
import 'package:chat_sample/themes/chat_themes.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'real time chat',
            style: appBarTextStyle,
          ),
          backgroundColor: Colors.teal[400],
        ),
        body: Column(
          children: <Widget>[
            SizedBox(height: 10.0),
            SendMessageForm(),
            SizedBox(height: 10.0),
            MessagesList(),
            SizedBox(height: 10.0),
          ],
        ));
  }
}
