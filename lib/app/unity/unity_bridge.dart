import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

typedef UnityJsonHandler = void Function(Map<String, dynamic> json);

class UnityBridge {
  UnityWidgetController? _controller;

  // Unity → Flutter のJSON受信時ハンドラ（必要に応じて差し替え）
  UnityJsonHandler? onJsonMessage;

  bool get isReady => _controller != null;

  void onUnityCreated(UnityWidgetController controller) {
    _controller = controller;
    debugPrint('[UnityBridge] Unity created');
  }

  void onUnityMessage(dynamic message) {
    debugPrint('[Unity → Flutter] $message');

    if (message is String) {
      // JSONっぽい文字列なら decode を試す
      try {
        final obj = jsonDecode(message);
        if (obj is Map<String, dynamic>) {
          onJsonMessage?.call(obj);
        }
      } catch (_) {
        // JSONではない文字列は無視（ログだけでOK）
      }
    }
  }

  /// Flutter → Unity（GameObject / method / param を指定して送信）
  void postMessage({
    required String gameObject,
    required String method,
    required String message,
  }) {
    if (_controller == null) {
      debugPrint('[UnityBridge] postMessage ignored: controller is null');
      return;
    }
    _controller!.postMessage(gameObject, method, message);
  }
}