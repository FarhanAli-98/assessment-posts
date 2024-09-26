import 'dart:developer';
import 'package:assessment/data/source/api/api_paths.dart';
import 'package:assessment/models/post.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'api_config.dart';

enum RequestMethod {
  post,
  get,
  put,
  patch,
  delete,
}

class ApiService {
  // Fetch posts from API
  static Future<List<Post>> fetchPosts() async {
    final response = await ApiConfig().dio.get(ApiPaths.post);
    List<dynamic> data = response.data;
    return data.map((json) => Post.fromJson(json)).toList();
  }

  static Future<Map<dynamic, dynamic>?> request(String path, {required BuildContext context, required RequestMethod method, data, queryParameters}) async {
    try {
      ApiConfig().dio.options.method = describeEnum(method);

      dio.Response response = await ApiConfig().dio.request(
            path,
            data: data,
            queryParameters: queryParameters,
            onSendProgress: (int sent, int total) => debugPrint("SENT: $sent TOTAL: $total"),
            options: Options(
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              },
            ),
          );

      // log(response.data.toString());
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return response.data;
      }
    } on dio.DioError catch (e) {
      log("$path >>>>> ${e.response}");
      if (e.response?.statusCode != 500) {
        return e.response?.data;
      }
    }

    return null;
  }
}
