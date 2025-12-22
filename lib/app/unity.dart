import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

class UnityCityController {
  late UnityWidgetController _unityController;

  /// UnityWidget から controller を受け取る
  void onUnityCreated(UnityWidgetController controller) {
    _unityController = controller;
  }

  /// Unity → Flutter
  void onUnityMessage(dynamic message) {
    debugPrint('[Unity → Flutter] $message');

    if (message is String) {
      try {
        final json = jsonDecode(message);
        _handleCityChanged(json);
      } catch (e) {
        debugPrint('Invalid JSON from Unity: $e');
      }
    }
  }

  /// Flutter → Unity（街データ送信）
  void importCityJson(String json) {
    _unityController.postMessage(
      'PlacementController', // GameObject名
      'ImportJson',          // メソッド名
      json,
    );
  }

  /// Flutter → Unity（UnityにJSONを要求）
  void requestExportJson() {
    _unityController.postMessage(
      'PlacementController',
      'RequestExport',
      '',
    );
  }

  /// Unity → Flutter（街更新イベント）
  void _handleCityChanged(Map<String, dynamic> cityJson) {
    debugPrint('[City Updated]');
    // TODO: DB保存 / State更新 / Riverpod反映など
  }
}