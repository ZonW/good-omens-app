import 'package:http/http.dart' as http;
import 'dart:developer';
import 'package:good_omens/end-points/api.dart';
import 'package:good_omens/models/user.dart';
import 'dart:convert';

class UserService {
  Future<User?> getUserById(String id) async {
    try {
      var url = Uri.parse(ApiConstants.getUserEndpoint + id);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        User user = User.fromJson(responseData['Payload']);
        return user;
      } else {
        throw response.body;
      }
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  Future<String?> createUser(String id, String nickName, String email) async {
    try {
      var url = Uri.parse(ApiConstants.createUserEndpoint);
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "firebase_id": id,
          "nick_name": nickName,
          "email": email,
        }),
      );
      //print(response.body);
      if (response.statusCode == 200) {
        return "success";
      } else {
        return "error";
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<String?> updateUserTheme(
    String id,
    int theme,
  ) async {
    try {
      var url = Uri.parse(ApiConstants.updateUserThemeEndpoint + id);
      final body = jsonEncode({
        "theme": theme,
      });

      final response = await http.put(
        headers: {'Content-Type': 'application/json'},
        url,
        body: body,
      );
      //print(response.body);
      if (response.statusCode == 200) {
        return "success";
      } else {
        print(response.body);
        return "error";
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<String?> subscribe(String id) async {
    try {
      var url = Uri.parse(ApiConstants.subscribeEndpoint + id);
      final response = await http.post(
        headers: {'Content-Type': 'application/json'},
        url,
      );

      if (response.statusCode == 200) {
        return "success";
      } else {
        print(response.statusCode);
        return "error";
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<String?> unsubscribe(String id) async {
    try {
      var url = Uri.parse(ApiConstants.unSubscribeEndpoint + id);
      final response = await http.post(
        headers: {'Content-Type': 'application/json'},
        url,
      );

      if (response.statusCode == 200) {
        return "success";
      } else {
        print(response.body);
        return "error";
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<bool> checkIfFirstTimeLogin(String id) async {
    try {
      var url = Uri.parse(ApiConstants.getUserEndpoint + id);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return false;
      } else if (response.statusCode == 404) {
        //true means first time log in
        return true;
      }
      return false;
    } catch (error) {
      log(error.toString());
      return false;
    }
  }
}
