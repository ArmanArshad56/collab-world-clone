import 'dart:async';
import 'package:collabworld_ui_design/src/components/app_bg.dart';
import 'package:collabworld_ui_design/src/service/supabase_service/supabase_service.dart';
import 'package:collabworld_ui_design/src/views/dashboard_screen.dart';
import 'package:collabworld_ui_design/src/views/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // final auth = AuthService();
  final auth = SupaAuthService();
  @override
  void initState() {
    super.initState();

    final supabase = Supabase.instance.client;

    Timer(const Duration(seconds: 2), () {
      if (!mounted) return;

      final user = supabase.auth.currentUser;

      if (user != null) {
        Get.offAll(() => const DashboardScreen());
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (_) => const DashboardScreen()),
        // );
      } else {
        Get.offAll(() => const SigninScreen());
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (_) => const SigninScreen()),
        // );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBg(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: RepaintBoundary(
                child: Image.asset('Asset/logo/app_logo.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
