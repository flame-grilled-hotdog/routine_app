import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class TapRiveSample extends StatefulWidget {
  const TapRiveSample({super.key});

  @override
  State<TapRiveSample> createState() => _TapRiveSampleState();
}

class _TapRiveSampleState extends State<TapRiveSample> {
  SMIBool? night;

  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
      artboard,
      'State Machine 1', // ← Rive側の名前と一致させる
    );
    print('river制御取得$controller');
    if (controller != null) {
      artboard.addController(controller);

      for (final i in controller.inputs) {
        if (i is SMIBool) {
          if (i.name == 'Night?') night = i;
        }
      }
    }
  }

  void _onTap() {
    night!.value=night!.value==true?false:true;
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