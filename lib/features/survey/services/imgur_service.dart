import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

class ImgurService {
  ImgurService({required this.clientId, http.Client? client})
      : _client = client ?? http.Client();

  final String clientId;
  final http.Client _client;

  Future<ImgurUploadResult> uploadImage(Uint8List imageBytes) async {
    if (clientId.isEmpty) {
      return ImgurUploadResult.failure('IMGUR CLIENT ID NO CONFIGURADO');
    }

    final response = await _client.post(
      Uri.parse('https://api.imgur.com/3/image'),
      headers: {
        'Authorization': 'Client-ID $clientId',
      },
      body: {
        'image': base64Encode(imageBytes),
      },
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      return ImgurUploadResult.failure(
        'ERROR IMGUR: ${response.statusCode}',
      );
    }

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    final data = decoded['data'] as Map<String, dynamic>?;
    final link = data?['link'] as String?;
    if (link == null || link.isEmpty) {
      return ImgurUploadResult.failure('RESPUESTA IMGUR INVALIDA');
    }

    return ImgurUploadResult.success(link);
  }
}

class ImgurUploadResult {
  ImgurUploadResult._(this.success, this.message, this.link);

  factory ImgurUploadResult.success(String link) =>
      ImgurUploadResult._(true, 'OK', link);

  factory ImgurUploadResult.failure(String message) =>
      ImgurUploadResult._(false, message, '');

  final bool success;
  final String message;
  final String link;
}
