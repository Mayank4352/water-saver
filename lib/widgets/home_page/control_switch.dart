import 'package:flutter/material.dart';
import 'package:inner_shadow_container/inner_shadow_container.dart';
import 'package:water_saver/utils/theme/app_themes.dart';

class ControlSwitch extends StatefulWidget {
  const ControlSwitch(
      {super.key,
      required this.switchValue,
      required this.onTap,
      this.inactiveBackgroundColor = const Color.fromARGB(255, 197, 194, 194),
      this.inactiveThumbColor = Colors.white,
      this.activeThumbColor = Colors.white,
      this.height = 31,
      this.width = 51,
      this.circularBorderRadius = 15.5});
  final bool switchValue;
  final Color inactiveBackgroundColor;
  final Color inactiveThumbColor;
  final Color activeThumbColor;
  final VoidCallback onTap;
  final double height;
  final double width;
  final double circularBorderRadius;

  @override
  State<ControlSwitch> createState() => _ControlSwitchState();
}

class _ControlSwitchState extends State<ControlSwitch> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap, // Add onTap callback parameter if needed
      child: InnerShadowContainer(
        isShadowTopLeft: true,
        isShadowTopRight: true,
        borderRadius: 40,
        offset: Offset(4, -2),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
              color: widget.switchValue
                  ? AppColors.activeToggleButtonColor
                  : widget.inactiveBackgroundColor,
              borderRadius: BorderRadius.circular(widget.circularBorderRadius),
              // border: Border.all(color: Colors.black),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 0,
                  blurRadius: 5,
                  offset: Offset(1, 2),
                )
              ]),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: widget.width * 0.1,
            ),
            child: AnimatedAlign(
              duration: const Duration(milliseconds: 200),
              alignment: widget.switchValue
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Container(
                width: 27,
                height: 27,
                decoration: BoxDecoration(
                  color: widget.switchValue
                      ? widget.activeThumbColor
                      : widget.inactiveThumbColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
