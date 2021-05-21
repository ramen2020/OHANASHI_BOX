import 'package:chat_sample/blocs/rtm/rtm_bloc.dart';
import 'package:chat_sample/blocs/rtm/rtm_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class SendMessageForm extends StatelessWidget {
  var _sendChatController = TextEditingController();

  // final _rtm = RtmBloc();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  child: Text('退出'),
                  onPressed: () {
                    context.read<RtmBloc>().add(LeaveEvent());
                    Navigator.of(context).pop();
                  }),
            ],
          ),
          // StreamBuilder(
          //     stream: _rtm.joinUserStream,
          //     builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          //       if (!snapshot.hasData) {
          //         return Text("あああ");
          //       }

          //       if (snapshot.connectionState == ConnectionState.done) {}
          //       return Container(
          //         height: 220,
          //         width: 220,
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.all(Radius.circular(10)),
          //         ),
          //         //  color: snapshot.data,
          //         child: ClipRRect(
          //           borderRadius: BorderRadius.all(Radius.circular(10)),
          //           child: snapshot.data,
          //         ),
          //       );
          //     }),
          TextFormField(
              controller: _sendChatController,
              decoration: InputDecoration(
                hintText: 'チャットを入力してください。',
                filled: true,
                suffixIcon: IconButton(
                    icon: Icon(Icons.message),
                    onPressed: () {
                      if (_sendChatController.text.length > 0) {
                        context
                            .read<RtmBloc>()
                            .add(SendingMessageEvent(_sendChatController.text));
                        _sendChatController.clear();
                      }
                    }),
              )),
        ],
      ),
    );
  }
}
