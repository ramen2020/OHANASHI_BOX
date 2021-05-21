import 'package:chat_sample/blocs/rtm/rtm_bloc.dart';
import 'package:chat_sample/blocs/rtm/rtm_event.dart';
import 'package:chat_sample/blocs/rtm/rtm_state.dart';
import 'package:chat_sample/screens/chat/chat.dart';
import 'package:chat_sample/themes/chat_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopPage extends StatefulWidget {
  @override
  TopPageState createState() {
    return new TopPageState();
  }
}

class TopPageState extends State<TopPage> {
  @override
  void initState() {
    super.initState();
  }

  var _loginTextController = TextEditingController();

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
      body: BlocBuilder<RtmBloc, RtmState>(builder: (context, state) {
        if (state is NotInitialized) {
          return Center(child: CircularProgressIndicator());
        }
        return Container(
          margin: EdgeInsets.all(16.0),
          child: TextFormField(
              controller: _loginTextController,
              decoration: InputDecoration(
                hintText: '',
                filled: true,
                prefixIcon: Icon(
                  Icons.account_box,
                  size: 28.0,
                ),
                suffixIcon: IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      context
                          .read<RtmBloc>()
                          .add(LoginEvent(_loginTextController.text));
                      _loginTextController.clear();
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (_) => BlocProvider.value(
                            value: BlocProvider.of<RtmBloc>(context),
                            child: ChatScreen(),
                          ),
                        ),
                      ).then((value) {
                        // ここで画面遷移から戻ってきたことを検知できる

                      });
                    }),
              )),
        );
      }),
    );
  }
}
