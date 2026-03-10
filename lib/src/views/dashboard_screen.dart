import 'package:collabworld_ui_design/src/components/app_bg.dart';
import 'package:collabworld_ui_design/src/service/firebase_service/firebase_service.dart';
import 'package:collabworld_ui_design/src/views/signin_screen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();
    return Scaffold(
      body: AppBg(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Collab World',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontFamily: 'Syne',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  Center(
                    child: InkWell(
                      onTap: () async {
                        await auth.logout();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SigninScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
