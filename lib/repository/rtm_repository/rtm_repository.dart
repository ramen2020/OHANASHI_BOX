import 'dart:async';
import 'package:agora_rtm/agora_rtm.dart';
import 'package:chat_sample/model/chat.dart';
import 'package:chat_sample/constants/agora_app_id.dart';

class RtmRepository {
  AgoraRtmClient _client;
  AgoraRtmChannel _channel;

  String _userId;

  RtmRepository() {
    _messageController = StreamController();
  }

  StreamController<List> _messageController;

  // @override
  Sink get chatMessageSink => _messageController.sink;

  // @override
  Stream get chatMessageStream => _messageController.stream;

  List messages = [];

  Future<void> createClientAndLogin(userId) async {
    _client = await _createClient();
    await _login(userId);
    try {
      // とりあえずチャンネル3270に入ることにする。
      _channel = await _createChannel("3270");
      await _channel.join();
    } on Exception catch (err) {
      print("チャンネル参加に失敗しました： $err");
    }

    List<AgoraRtmMember> members = await _channel.getMembers();
    print("チャンネルにいる人： $members");
  }

  Future<AgoraRtmChannel> _createChannel(String name) async {
    AgoraRtmChannel channel = await _client?.createChannel(name);

    channel.onMemberJoined = (AgoraRtmMember member) async {
      print("メンバーが入室しました: " + member.userId + ', チャンネル名: ' + member.channelId);
    };

    channel.onMessageReceived =
        (AgoraRtmMessage message, AgoraRtmMember member) {
      messages.insert(0, Chat.toEntity(member.userId, message.text));
      chatMessageSink.add(messages);
    };

    return channel;
  }

  Future _createClient() async {
    try {
      return AgoraRtmClient.createInstance(AgoraAppId.appId);
    } on Exception catch (err) {
      print('失敗しました: $err');
    }
  }

  Future<void> _login(userId) async {
    print(userId);
    try {
      _userId = userId;
      await _client.login(null, userId);
    } on Exception catch (err) {
      print("ログインに失敗しました： $err");
    }
  }

  Future<void> sendMessage(message) async {
    await _channel.sendMessage(AgoraRtmMessage.fromText(message));
    messages.insert(0, Chat.toEntity(_userId, message));
    chatMessageSink.add(messages);
  }

  Future<void> leaveChannelAndLogout() async {
    await _channel.leave();
    await _client.logout();
    print('チャンネルを退出しました');
  }

  void dispose() {
    _messageController?.close();
  }
}
