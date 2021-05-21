import 'package:chat_sample/blocs/rtm/rtm_bloc.dart';
import 'package:chat_sample/blocs/rtm/rtm_state.dart';
import 'package:chat_sample/model/chat.dart';
import 'package:chat_sample/themes/chat_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagesList extends StatefulWidget {
  @override
  _MessagesListState createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RtmBloc, RtmState>(
      builder: (context, state) {
        print("今の状態：$state");
        if (state is NotInitialized || state == null || state is NotLogin) {
          return Center(child: CircularProgressIndicator());
        } else if (state is JoinedRoomState) {
          return Text("ようこそ！");
        } else {
          final receivedMessagesState = state as ReceivedMessagesState;
          final messages = receivedMessagesState.messages;
          return buildMessagesList(messages);
        }
      },
    );
  }
}

Widget buildMessagesList(List messages) {
  return Expanded(
    child: ListView.separated(
      itemBuilder: (BuildContext context, index) {
        print(messages);
        Chat chat = messages[index];
        return ListTile(
            title: Text("message：${chat.message}", style: chatTextStyle),
            subtitle: Text("User：${chat.userId}", style: userIdStyle),
            trailing: Text(chat.timestamp, style: userIdStyle));
      },
      separatorBuilder: (BuildContext context, index) {
        return Divider(
          height: 8.0,
          color: Colors.transparent,
        );
      },
      itemCount: messages.length ?? null,
    ),
  );
}
