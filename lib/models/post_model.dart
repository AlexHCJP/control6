import 'package:control6/models/profile_model.dart';

class PostModel {
  final String id;
  final DateTime dateTime;
  final ProfileModel user;
  final String message;

  PostModel({
    required this.id,
    required this.dateTime,
    required this.user,
    required this.message,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['_id'],
      message: json['message'],
      dateTime: DateTime.parse(json['datetime']),
      user: ProfileModel.fromJson(json['user']),
    );
  }
}
