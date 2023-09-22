import 'package:http/http.dart' as http;
import 'dart:developer';
import 'package:good_omens/end-points/api.dart';
import 'package:good_omens/models/user.dart';
import 'dart:convert';

class UserService {
  Future<User?> getUserById(String id) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + 'account/getUser/' + id);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        User user = User.fromJson(responseData['Payload']);
        return user;
      } else {
        throw 'User not found';
      }
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  Future<String?> createUser(String id, String nickName, String email) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + 'account/createUser');
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

  Future<String?> updateUser(
    String id,
    String firstName,
    String lastName,
    String nickName,
    String email,
    String phone,
    List<String> collection,
    int subscription,
  ) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + 'account/updateUser/' + id);
      final body = jsonEncode({
        "first_name": firstName,
        "last_name": lastName,
        "nick_name": nickName,
        "email": email,
        "phone_number": phone,
        "collection": collection,
        "subscription": subscription,
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

  Future<bool> checkIfFirstTimeLogin(String id) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + 'account/getUser/' + id);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return false;
      } else {
        //true means first time log in
        return true;
      }
    } catch (error) {
      log(error.toString());
      return false;
    }
  }
}
