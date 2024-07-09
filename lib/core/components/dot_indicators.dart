import 'package:flutter/material.dart';

import '../utils/constants.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    this.isActive = false,
    this.inActiveColor,
    this.activeColor = primaryColor,
  });

  final bool isActive;

  final Color? inActiveColor, activeColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: defaultDuration,
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        color: isActive
            ? activeColor
            : inActiveColor ?? primaryColor.withOpacity(.2),
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      ),
    );
  }
}