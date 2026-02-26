import 'package:flutter/material.dart';

class AppBg extends StatelessWidget {
  final Widget child;
  const AppBg({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          RepaintBoundary(
            child: Image.asset(
              'Asset/image/background image.png',
              fit: .fill,
              colorBlendMode: .color,
              color: Color(0xff471e7c),
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Container(
            height: .infinity,
            width: .infinity,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: .4),
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
