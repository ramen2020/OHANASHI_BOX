import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class Chat extends Equatable {
  final String _userId;
  final String _message;
  final String _timestamp;

  Chat(
      {@required String userId,
      @required String message,
      @required String timestamp})
      : this._userId = userId,
        this._message = message,
        this._timestamp = timestamp,
        super();

  String get userId => _userId;

  String get message => _message;

  String get timestamp => _timestamp;

  @override
  List<Object> get props => [_userId, _message, _timestamp];

  static Chat fromJson(Map<String, dynamic> json) {
    return Chat(
        userId: json["user_id"],
        message: json["message"],
        timestamp: json["timestamp"]);
  }

  static Map<String, dynamic> toJson(String userId, String message) {
    return {
      'user_id': '$userId',
      'message': '$message',
      'timestamp':
          '${DateFormat('MM月dd日H時m分').format(DateTime.now()).toString()}'
    };
  }

  static Chat toEntity(
    String userId,
    String message,
  ) {
    return Chat(
        userId: userId,
        message: message,
        timestamp: DateFormat('MM月dd日H時m分').format(DateTime.now()).toString());
  }
}
