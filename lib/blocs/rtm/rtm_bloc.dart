import 'dart:async';
import 'package:chat_sample/blocs/rtm/rtm_event.dart';
import 'package:chat_sample/blocs/rtm/rtm_state.dart';
import 'package:chat_sample/repository/rtm_repository/rtm_repository.dart';
import 'package:bloc/bloc.dart';

class RtmBloc extends Bloc<RtmEvent, RtmState> {
  RtmRepository rtmRepository;
  RtmBloc(this.rtmRepository) : super(null);

  StreamSubscription messagesSubscription;

  List messages = [];

  @override
  Stream<RtmState> mapEventToState(RtmEvent event) async* {
    print("いまおきたevent :$event");
    if (event is InitialEvent) {
      yield* _mapInitializeToState();
    } else if (event is LoginEvent) {
      yield* _mapLoginToState(event);
    } else if (event is SendingMessageEvent) {
      yield* _mapSendMessageEventToState(event);
    } else if (event is ReceivedMessageEvent) {
      yield* _mapReceivedMessageEventToState(event);
    } else if (event is LeaveEvent) {
      yield* _mapLeaveChannelToState();
    }
  }

  Stream<RtmState> _mapInitializeToState() async* {
    await messagesSubscription?.cancel();

    messagesSubscription = rtmRepository.chatMessageStream.listen((messages) {
      print('streamでメッセージ受け取った。： $messages');
      return add(ReceivedMessageEvent(messages));
    });

    yield NotLogin();
  }

  Stream<RtmState> _mapLoginToState(LoginEvent event) async* {
    try {
      rtmRepository.createClientAndLogin(event.userId);
      yield JoinedRoomState();
    } on Exception catch (err) {
      print("エラーです： $err");
    }
  }

  Stream<RtmState> _mapSendMessageEventToState(
      SendingMessageEvent event) async* {
    rtmRepository.sendMessage(event.message);
  }

  Stream<RtmState> _mapReceivedMessageEventToState(
      ReceivedMessageEvent event) async* {
    yield ReceivingMessagesState();
    yield ReceivedMessagesState(messages: event.messages);
  }

  Stream<RtmState> _mapLeaveChannelToState() async* {
    try {
      rtmRepository.leaveChannelAndLogout();
      yield NotLogin();
      print('チャンネルを退出しました');
    } on Exception catch (err) {
      print('チャンネルの退出に失敗しました: $err');
    }
  }
}
