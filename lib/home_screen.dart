import 'package:flutter/material.dart';
import 'package:liquid_toggle_button/widgets/liquid_toggle_button_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool switchBackgroundColor = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: switchBackgroundColor ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: switchBackgroundColor ? Colors.black : Colors.white,
        title: Text(
          'Liquid Toggle Button',
          style: TextStyle(
            color: switchBackgroundColor ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: Center(
        child: MvLiquidToggleButton(
          baseColorA: Colors.white,
          baseColorB: Colors.black,
          circleCollor: Colors.pink,
          buttonHeight: 50,
          buttonWidth: 200,
          buttonFlowSpeed: 700,
          onChanged: (bool isOn) {
            setState(() {
              switchBackgroundColor = isOn;
            });
          },
        ),
      ),
    );
  }
}
