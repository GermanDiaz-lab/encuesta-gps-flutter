import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/survey_model.dart';
import 'imgur_service.dart';
import 'signature_renderer.dart';

class SurveySyncService {
  SurveySyncService({
    required ImgurService imgurService,
    required FirebaseFirestore firestore,
  })  : _imgurService = imgurService,
        _firestore = firestore;

  final ImgurService _imgurService;
  final FirebaseFirestore _firestore;

  Future<SurveySyncResult> uploadSurvey({
    required SurveyModel model,
    required List<Offset?> signaturePoints,
    Size signatureSize = const Size(520, 220),
  }) async {
    if (signaturePoints.isEmpty) {
      return SurveySyncResult.failure('FIRMA REQUERIDA');
    }

    final signatureBytes = await SignatureRenderer.renderPngBytes(
      points: signaturePoints,
      size: signatureSize,
    );

    final imgurResult = await _imgurService.uploadImage(signatureBytes);
    if (!imgurResult.success) {
      return SurveySyncResult.failure(imgurResult.message);
    }

    final link = imgurResult.link;
    final linkm = _linkThumbnail(link);
    final payload = <String, dynamic>{
      ...model.toMap(),
      'link': link,
      'linkm': linkm,
      'conclusionfin': '',
      'serverdate': FieldValue.serverTimestamp(),
    };

    await _firestore.collection('informes').add(payload);
    return SurveySyncResult.success('INFORME GUARDADO');
  }

  String _linkThumbnail(String link) {
    const fileTypes = ['.jpg', '.png', '.jpeg'];
    for (final type in fileTypes) {
      final index = link.indexOf(type);
      if (index != -1) {
        return link.replaceRange(index, index, 'm');
      }
    }
    return '';
  }
}

class SurveySyncResult {
  SurveySyncResult._(this.success, this.message);

  factory SurveySyncResult.success(String message) =>
      SurveySyncResult._(true, message);

  factory SurveySyncResult.failure(String message) =>
      SurveySyncResult._(false, message);

  final bool success;
  final String message;
}
