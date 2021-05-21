import 'package:equatable/equatable.dart';

abstract class RtmState extends Equatable {
  @override
  List<Object> get props => [];
}

class NotInitialized extends RtmState {}

class NotLogin extends RtmState {}

class JoinedRoomState extends RtmState {}

class ReceivingMessagesState extends RtmState {}

class ReceivedMessagesState extends RtmState {
  final List messages;

  ReceivedMessagesState({this.messages});

  ReceivedMessagesState copyWith({List messages}) {
    return ReceivedMessagesState(messages: messages);
  }

  @override
  List<Object> get props => [messages];
}

class FailureJoin extends RtmState {
  FailureJoin(this.reason);
  final String reason;
}
