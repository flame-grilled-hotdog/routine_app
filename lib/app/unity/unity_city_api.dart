import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'unity_bridge.dart';

class UnityCityApi {
  UnityCityApi(this.bridge) {
    bridge.onJsonMessage = _handleJsonFromUnity;
  }

  final UnityBridge bridge;

  /// Flutter → Unity：街を復元
  void importCityJson(String json) {
    bridge.postMessage(
      gameObject: 'PlacementController',
      method: 'ImportJson',
      message: json,
    );
  }

  /// Flutter → Unity：Unity側に ExportJson を要求（Unity → Flutter で返ってくる想定）
  void requestExportJson() {
    bridge.postMessage(
      gameObject: 'PlacementController',
      method: 'RequestExport',
      message: '',
    );
  }

  /// Unity → Flutter：UnityからのJSONを受け取る（ここで保存・状態更新に接続）
  void _handleJsonFromUnity(Map<String, dynamic> json) {
    // 例：type を付けてイベント化している場合に分岐
    // { "type":"cityChanged", "payload": { ...cityState... } }
    if (json['type'] == 'cityChanged' && json['payload'] is Map<String, dynamic>) {
      debugPrint('[UnityCityApi] cityChanged');
      final payload = json['payload'] as Map<String, dynamic>;
      // TODO: payload をDB保存 / Riverpod更新など
      return;
    }

    // 例：Unityが CityState をそのまま返す場合
    if (json.containsKey('placements')) {
      debugPrint('[UnityCityApi] received CityState');
      // TODO: json を保存
      return;
    }
  }

  /// Flutter側でCityState(Map)を作ってUnityに渡したい場合
  void importCityStateMap(Map<String, dynamic> cityState) {
    importCityJson(jsonEncode(cityState));
  }
}