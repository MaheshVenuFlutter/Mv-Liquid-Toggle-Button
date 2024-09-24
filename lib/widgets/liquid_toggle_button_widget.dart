import 'package:flutter/material.dart';

/// A liquid-style animated toggle button widget.
///
/// `MvLiquidToggleButton` provides a visually appealing liquid-like toggle animation
/// between two states. The button morphs between two colors and switches position, giving
/// a teardrop effect while transitioning. It also calls a callback when toggled.
///
/// The button can be customized in terms of its size, color, and transition speed.
///
/// Example:
/// ```dart
/// MvLiquidToggleButton(
///   buttonWidth: 150,
///   buttonHeight: 50,
///   baseColorA: Colors.blue,
///   baseColorB: Colors.green,
///   circleCollor: Colors.white,
///   buttonFlowSpeed: 400,
///   onChanged: (bool isOn) {
///     print('Button is ${isOn ? 'ON' : 'OFF'}');
///   },
/// )
/// ```
///
/// The `onChanged` function will be called every time the button is toggled.
///
/// ### Properties:
///
/// * `buttonWidth` (`double`): The total width of the button.
/// * `buttonHeight` (`double`): The total height of the button.
/// * `baseColorA` (`Color`): The background color when the button is in the 'on' state.
/// * `baseColorB` (`Color`): The background color when the button is in the 'off' state.
/// * `circleCollor` (`Color`): The color of the moving toggle circle.
/// * `buttonFlowSpeed` (`int`): The speed of the toggle animation in milliseconds.
/// * `onChanged` (`Function(bool)`): A callback function that returns the current state
///   of the button (`true` for 'on', `false` for 'off').

class MvLiquidToggleButton extends StatefulWidget {
  final Color baseColorA;
  final Color baseColorB;
  final Color circleCollor;
  final double buttonHeight;
  final double buttonWidth;
  final int buttonFlowSpeed;
  final Function(bool) onChanged;

  const MvLiquidToggleButton(
      {required this.buttonWidth,
      required this.buttonHeight,
      required this.baseColorA,
      required this.baseColorB,
      required this.circleCollor,
      required this.buttonFlowSpeed,
      required this.onChanged,
      super.key});

  @override
  State<MvLiquidToggleButton> createState() => _MvLiquidToggleButtonState();
}

class _MvLiquidToggleButtonState extends State<MvLiquidToggleButton> {
  double cornerRadius = 0;
  bool isOn = true;

  bool isTeardrop = false;
  bool isLeft = true;

  @override
  void initState() {
    // Setting the cornerRadius to buttonHeight - 2 to give tolerance for padding
    cornerRadius = widget.buttonHeight - 2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.buttonHeight,
      width: widget.buttonWidth,
      decoration: BoxDecoration(
        color: isOn ? widget.baseColorA : widget.baseColorB,
        borderRadius: BorderRadius.circular(24),
      ),
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          setState(() {
            // Start shape morphing
            isTeardrop = true;

            Future.delayed(const Duration(milliseconds: 300), () {
              setState(() {
                // Toggle position after morphing starts
                isLeft = !isLeft;
              });
            });

            // After reaching the destination, return to circle shape
            Future.delayed(const Duration(milliseconds: 300), () {
              setState(() {
                isTeardrop = false;
              });
            });
          });

          Future.delayed(Duration(milliseconds: widget.buttonFlowSpeed + 100),
              () {
            setState(() {
              isOn = !isOn;
              // Triggers the `onChanged` callback function, passing the new `isOn` value.
              // This allows the parent widget to react to the toggle button's state change.
              widget.onChanged(isOn);
            });
          });
        },
        child: AnimatedAlign(
          duration: Duration(milliseconds: widget.buttonFlowSpeed),
          alignment: isLeft ? Alignment.centerLeft : Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              height: widget.buttonHeight,
              width: isTeardrop ? 100 : 50,
              decoration: BoxDecoration(
                color: widget.circleCollor,
                borderRadius: isTeardrop
                    ? BorderRadius.only(
                        topLeft: isLeft
                            ? Radius.circular(cornerRadius )
                            : Radius.circular(cornerRadius ),
                        bottomLeft: isLeft
                            ? Radius.circular(cornerRadius)
                            : Radius.circular(cornerRadius),
                        topRight: !isLeft
                            ? Radius.circular(cornerRadius)
                            : Radius.circular(cornerRadius),
                        bottomRight: !isLeft
                            ? Radius.circular(cornerRadius)
                            : Radius.circular(cornerRadius),
                      )
                   // Initially circular
                    :  BorderRadius.circular(
                        widget.buttonHeight - 2), 
              ),
            ),
          ),
        ),
      ),
    );
  }
}
