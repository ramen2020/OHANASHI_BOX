import 'package:chat_sample/blocs/rtm/rtm_bloc.dart';
import 'package:chat_sample/blocs/rtm/rtm_event.dart';
import 'package:chat_sample/repository/rtm_repository/rtm_repository.dart';
import 'package:chat_sample/screens/top_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'chat_message_sample',
      home: BlocProvider(
        create: (context) => RtmBloc(RtmRepository())..add(InitialEvent()),
        child: TopPage(),
      ),
    );
  }
}
