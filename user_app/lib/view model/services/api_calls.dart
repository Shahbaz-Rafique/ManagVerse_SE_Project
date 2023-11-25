import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:user_app/models/novel.dart';
import 'package:user_app/view%20model/services/routes.dart';

import '../../models/chapter_model.dart';

class ApiCalls with ChangeNotifier {
  Future<Novels> getLatestPublications() async {
    try {
      Response response = await get(
        Uri.parse('$api$book$routes?active=true'),
      );
      Novels nvl = Novels.fromJson(json.decode(response.body.toString()));
      return nvl;
    } catch (e) {
      rethrow;
    }
  }

  Future<ChaptersResponse> getChapters(String id) async {
    try {
      Response response = await get(
        Uri.parse('$api$chapter$routes$id'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      ChaptersResponse ar =
          ChaptersResponse.fromJson(json.decode(response.body.toString()));
      return ar;
    } catch (e) {
      rethrow;
    }
  }
}
