import 'dart:convert';

import 'package:flutter_rest_apis/model/user_model.dart';
import 'package:http/http.dart';

class ApiService {
  String endpoint = 'https://alvin.nugsoftdemos.net/api/posts';
  String catendpoint = 'https://alvin.nugsoftdemos.net/api/categories';
  String catendpoint1 = 'http://alvin.nugsoftdemos.net/api/categories/1/posts';

  Future<List<PostModel>> getUser() async {
    Response response = await get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      return result.map(((e) => PostModel.fromJson(e))).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<Categories>> getCategories() async {
    Response response = await get(Uri.parse(catendpoint));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      return result.map(((e) => Categories.fromJson(e))).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<PostModel>> getCategories1() async {
    Response response = await get(Uri.parse(catendpoint1));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      return result.map(((e) => PostModel.fromJson(e))).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

}
