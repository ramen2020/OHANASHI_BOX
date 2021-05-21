import 'package:equatable/equatable.dart';

abstract class RtmEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialEvent extends RtmEvent {}

class LoginEvent extends RtmEvent {
  LoginEvent(this.userId);
  final String userId;

  @override
  List<Object> get props => [userId];
}

class JoinChannelEvent extends RtmEvent {
  JoinChannelEvent(this.channelName);
  final String channelName;

  @override
  List<Object> get props => [channelName];
}

class SendingMessageEvent extends RtmEvent {
  SendingMessageEvent(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}

class SendedMessageEvent extends RtmEvent {
  SendedMessageEvent(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}

class ReceivingMessageEvent extends RtmEvent {
  ReceivingMessageEvent(this.messages);
  final List messages;

  @override
  List<Object> get props => [messages];
}

class ReceivedMessageEvent extends RtmEvent {
  ReceivedMessageEvent(this.messages);
  final List messages;

  @override
  List<Object> get props => [messages];
}

// class LeaveEvent extends RtmEvent {
//   LeaveEvent(this.userId);
//   final String userId;

//   @override
//   List<Object> get props => [userId];
// }

class LeaveEvent extends RtmEvent {}
