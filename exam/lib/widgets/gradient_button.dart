import 'package:flutter/cupertino.dart';

import '../app_colors.dart';

class GradientBtnWidget extends StatelessWidget {
  const GradientBtnWidget({
    required this.width,
    required this.child,
    required this.onTap,
  });
  final double width;
  final Widget child;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: 48,
        decoration: BoxDecoration(
          gradient: AppColors.kBtnLinearGradient,
          boxShadow: [
            BoxShadow(
              color: Color(0x33D83131),
              offset: Offset(0, 8),
              blurRadius: 20,
            )
          ],
          borderRadius: BorderRadius.circular(24),
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
