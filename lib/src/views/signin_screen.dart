import 'package:collabworld_ui_design/src/components/app_bg.dart';
import 'package:collabworld_ui_design/src/service/supabase_service/supabase_service.dart';
import 'package:collabworld_ui_design/src/views/dashboard_screen.dart';
import 'package:collabworld_ui_design/src/views/forgot_pass_screen.dart';
import 'package:collabworld_ui_design/src/views/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool isPasswordVisible = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  // final auth = AuthService();
  final auth = SupaAuthService();

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
                      left: 100,
                      right: 100,
                      top: 90,
                    ),
                    child: RepaintBoundary(
                      child: Image.asset('Asset/logo/Logo.png'),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Welcome Back',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontFamily: 'Syne',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: 6),
                  Center(
                    child: Text(
                      'Connect. Create. Collaborate.',
                      style: TextStyle(
                        color: Color(0xffdadada),
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),

                  // Email Address Field //
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
                  SizedBox(height: 15),

                  // Password Field //
                  const Text(
                    "Password",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 5),
                  TextField(
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: !isPasswordVisible,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      hintStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                      // Right side icon
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
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
                  SizedBox(height: 4),

                  // forgot password //
                  Row(
                    mainAxisAlignment: .end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.to(() => ForgotPassScreen());
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => ForgotPassScreen(),
                          //   ),
                          // );
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Color(0xff80E3F3),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () async {
                      if (isLoading) return; // prevent multiple taps
                      setState(() => isLoading = true);
                      final email = emailController.text.trim();
                      final password = passwordController.text.trim();
                      print("🔹 Login button pressed for email: $email");
                      try {
                        final errorMessage = await auth.loginUser(
                          email: email,
                          password: password,
                        );
                        // final errorMessage = await auth.loginUser(
                        //   email: email,
                        //   password: password,
                        // );
                        setState(() => isLoading = false); // stop loader
                        if (errorMessage != null) {
                          // Login failed
                          print("❌ Login failed: $errorMessage");
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(errorMessage)));
                        } else {
                          // Login success
                          print("✅ Login successful for email: $email");

                          // Optional: fetch user data from Realtime Database for debugging
                          final userData = await auth.getUserData();
                          print("📝 User data: $userData");
                          Get.offAll(() => const DashboardScreen());
                          // Navigator.pushReplacement(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const DashboardScreen(),
                          //   ),
                          // );
                        }
                      } catch (e) {
                        setState(() => isLoading = false);
                        print("⚠️ Login exception: $e");
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
                                  'Log in',
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

                  SizedBox(height: 25),

                  // our continue with //
                  Row(
                    children: [
                      Expanded(
                        child: Container(height: 1, color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 17),
                        child: Text(
                          "Or Continue With",
                          style: TextStyle(
                            color: Color(0xff80E3F3),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(height: 1, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),

                  // google button //
                  InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      print("Google button pressed");
                    },
                    child: Container(
                      width: double.infinity,
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 17),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 17),
                          Image.asset(
                            "Asset/image/google_icon.png",
                            height: 20,
                            width: 20,
                          ),
                          const SizedBox(width: 40),
                          const Text(
                            "Continue with Google",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 12),

                  // Facebook button //
                  InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      print("Facebook button pressed");
                    },
                    child: Container(
                      width: double.infinity,
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 17),
                      decoration: BoxDecoration(
                        color: Color(0xff1877F2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 17),
                          Image.asset(
                            "Asset/image/facebook_icon.png",
                            height: 20,
                            width: 20,
                          ),
                          const SizedBox(width: 40),
                          const Text(
                            "Continue with Facebook",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // sign up button //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          color: Color(0xffDADADA),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(() => SignupScreen());
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => SignupScreen(),
                          //   ),
                          // );
                        },
                        child: Text(
                          'Sign Up',
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
                  SizedBox(height: 111),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
