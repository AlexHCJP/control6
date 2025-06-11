import 'dart:convert';

import 'package:control6/models/post_model.dart';
import 'package:control6/models/profile_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'http://146.185.154.90:8000/blog/';

  Future<ProfileModel> getProfile(String email) async {
    final result = await http.get(Uri.parse('$_baseUrl$email/profile'));

    if (result.statusCode == 200) {
      return ProfileModel.fromJson(jsonDecode(result.body));
    } else {
      throw Exception();
    }
  }

  Future<List<PostModel>> getPosts(String email) async {
    final result = await http.get(Uri.parse('$_baseUrl$email/posts'));

    if (result.statusCode == 200) {
      final list = jsonDecode(result.body) as List<dynamic>;
      return list.map((value) {
        return PostModel.fromJson(value as Map<String, dynamic>);
      }).toList();
    } else {
      throw Exception();
    }
  }

  Future<List<PostModel>> getPostsByDateTime(String email, DateTime dateTime) async {
    final result = await http.get(Uri.parse('$_baseUrl$email/posts?datetime=${dateTime.toIso8601String()}'));

    if (result.statusCode == 200) {
      final list = jsonDecode(result.body) as List<dynamic>;
      return list.map((value) {
        return PostModel.fromJson(value as Map<String, dynamic>);
      }).toList();
    } else {
      throw Exception();
    }
  }

  Future<void> createPost(String email, String message) async {
    final result = await http.post(
      Uri.parse('$_baseUrl$email/posts'),
      body: {'message': message},
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    );

    if (result.statusCode == 200) return;
    throw Exception();
  }

  Future<void> subscribe(String email, String otherEmail) async {
    final result = await http.post(
      Uri.parse('$_baseUrl$email/subscribe'),
      body: {'email': otherEmail},
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    );

    if(result.statusCode == 200) return;
    throw Exception();
  }

  Future<ProfileModel> updateProfile(String email, String firstName, String lastName) async {
    final result = await http.post(
      Uri.parse('$_baseUrl$email/profile'),
      body: {'firstName': firstName, 'lastName': lastName},
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    );

    if (result.statusCode == 200) {
      return ProfileModel.fromJson(jsonDecode(result.body));
    } else {
      throw Exception();
    }
  }
}
