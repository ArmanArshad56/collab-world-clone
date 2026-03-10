// forget password screen //
import 'package:collabworld_ui_design/src/components/app_bg.dart';
import 'package:collabworld_ui_design/src/service/firebase_service/firebase_service.dart';
import 'package:collabworld_ui_design/src/views/signin_screen.dart';
import 'package:collabworld_ui_design/src/views/verify_otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({super.key});

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  final auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBg(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 76,
                      right: 76,
                      top: 90,
                    ),
                    child: RepaintBoundary(
                      child: Image.asset('Asset/logo/forget_password.png'),
                    ),
                  ),
                  // SizedBox(height: 24),
                  Center(
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontFamily: 'Syne',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: 6),
                  Center(
                    child: Text(
                      'Dont worry, it happens. Enter your registered email or phone number to receive a recovery link.',
                      textAlign: .center,
                      style: TextStyle(
                        color: Color(0xffdadada),
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),

                  // Email address feild //
                  const Text(
                    "Email Address",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 5),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      hintText: "youremail@.com",
                      hintStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                      // Right side icon
                      suffixIcon: const Icon(
                        Icons.email_outlined,
                        color: Colors.white,
                      ),
                      // Border design
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),

                      filled: true,
                      fillColor: Color(0xff471E7C),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),

                  // continue button feild //
                  InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () async {
                      if (isLoading) return;
                      setState(() => isLoading = true);

                      final email = emailController.text.trim();
                      print("🔹 Continue button pressed for email: $email");

                      // Optional: simple validation
                      if (email.isEmpty || !email.contains('@')) {
                        setState(() => isLoading = false);
                        print("❌ Invalid email: $email");
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please enter a valid email."),
                          ),
                        );
                        return;
                      }

                      // Navigate to verification screen
                      try {
                        print(
                          "➡️ Navigating to verification screen for $email",
                        );
                        setState(() => isLoading = false);
                        await auth.sendPasswordResetEmail(email: email);
                        Get.to(() => VerifyOtpScreen(email: email));
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => VerifyOtpScreen(email: email),
                        //   ),
                        // );
                      } catch (e) {
                        setState(() => isLoading = false);
                        print("⚠️ Error navigating to verification screen: $e");
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "An error occurred. Please try again.",
                            ),
                          ),
                        );
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              'Asset/image/button.png',
                              width: double.infinity,
                              height: 48,
                              fit: BoxFit.cover,
                            ),
                          ),
                          isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  'Continue',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Log in button //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Remember your passwod?",
                        style: TextStyle(
                          color: Color(0xffDADADA),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.offAll(() => const SigninScreen());
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => SigninScreen(),
                          //   ),
                          // );
                        },
                        child: Text(
                          'Log in',
                          style: TextStyle(
                            color: Color(0xff80E3F3),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
