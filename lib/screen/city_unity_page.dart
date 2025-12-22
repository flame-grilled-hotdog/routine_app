import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import '../app/unity/unity_bridge.dart';
import '../app/unity/unity_city_api.dart';

class CityUnityPage extends StatefulWidget {
  const CityUnityPage({super.key});

  @override
  State<CityUnityPage> createState() => _CityUnityPageState();
}

class _CityUnityPageState extends State<CityUnityPage> {
  final UnityBridge bridge = UnityBridge();
  late final UnityCityApi cityApi = UnityCityApi(bridge);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('City'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () => cityApi.requestExportJson(),
            tooltip: 'Export JSON',
          ),
        ],
      ),
      body: UnityWidget(
        onUnityCreated: bridge.onUnityCreated,
        onUnityMessage: bridge.onUnityMessage,
        fullscreen: true,
      ),
    );
  }
}