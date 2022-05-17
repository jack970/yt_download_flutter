import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class API {
  static String baseUrl = 'http://192.168.0.106:3000/api';

  Future<dynamic> get(String url) async {
    try {
      final uri = Uri.parse('$baseUrl/$url');
      http.Response response = await http
          .get(uri);

      if (response.statusCode != 200)
        throw HttpException(response.statusCode.toString());

      return json.decode(response.body);
    } on SocketException catch (e) {
      throw Exception('Falha na conexão com a internet $e');
    } on TimeoutException {
      throw Exception('Tempo limite excedido');
    }
  }

  Future<Uint8List> getVideo(String url) async {
    try {
      final uri = Uri.parse('$baseUrl/$url');
      HttpClientRequest request = await HttpClient().getUrl(uri);
      final response = await request.close();

      return await consolidateHttpClientResponseBytes(response);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future hasNetwork() async {
    final _baseUrl = baseUrl;

    final uri = Uri.parse(_baseUrl);
    final host = uri.host;
    final port = uri.port;
    const timeout = Duration(seconds: 5);

    return await Socket.connect(host, port, timeout: timeout).then((socket) {
      print("(1) Conectado a $host $port");
      socket.destroy();

      return true;
    }).catchError((onError) {
      print("(1) Error: $onError");

      return false;
    });
  }
}
