import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class TapRiveSample extends StatefulWidget {
  const TapRiveSample({super.key});

  @override
  State<TapRiveSample> createState() => _TapRiveSampleState();
}

class _TapRiveSampleState extends State<TapRiveSample> {
  SMITrigger? tapTrigger;

  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
      artboard,
      'State Machine 1', // ← Rive側の名前と一致させる
    );
    print('river制御取得$controller');
    if (controller != null) {
      artboard.addController(controller);

      final input = controller.findInput('Night');

      if (input is SMITrigger) {
        tapTrigger = input;
      }
      // デバッグ（超おすすめ）
      for (var i in controller.inputs) {
        print('Input name: ${i.name}');
      }
    }
  }

  void _onTap() {
    tapTrigger?.fire(); // ← ここだけ
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: GestureDetector(
      onTap: _onTap,
      child: RiveAnimation.asset(
          'assets/character.riv',
          onInit: _onRiveInit,
          fit: BoxFit.contain
        )
      )
    );

  }
}