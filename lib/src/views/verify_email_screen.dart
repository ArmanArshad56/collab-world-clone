import 'dart:async';
import 'package:collabworld_ui_design/src/components/app_bg.dart';
import 'package:collabworld_ui_design/src/service/supabase_service/supabase_service.dart';
import 'package:collabworld_ui_design/src/views/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class Verifyemailview extends StatefulWidget {
  final String email;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Verifyemailview({super.key, required this.email});
  @override
  State<Verifyemailview> createState() => _VerifyemailviewState();
}

class _VerifyemailviewState extends State<Verifyemailview> {
  late Timer timer;
  int start = 60;
  bool isResendEnabled = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    isResendEnabled = false;
    start = 60;

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (start == 0) {
        setState(() {
          isResendEnabled = true;
        });
        timer.cancel();
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    otpControler.dispose();
    super.dispose();
  }

  final otpControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final auth = SupaAuthService();
    return Scaffold(
      body: AppBg(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          left: 0,
                          child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              height: 38,
                              width: 38,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff471E7C),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1.5,
                                ),
                              ),
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Verification",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontFamily: 'Syne',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 100),
                  Center(
                    child: Text(
                      "Verify it's you",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontFamily: 'Syne',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Center(
                    child: Text(
                      'Please enter the 4-digit code sent to',
                      style: TextStyle(
                        color: Color(0xffDADADA),
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 4),

                  Center(
                    child: Text(
                      widget.email,
                      style: TextStyle(
                        color: Color(0xff80E3F3),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 40),

                  // OPT feild //
                  Center(
                    child: Pinput(
                      length: 6,
                      onChanged: (value) {
                        print("OTP input changed: $value");
                      },
                      onCompleted: (value) {
                        print("OTP input completed: $value");
                      },
                      controller: otpControler,
                      validator: (value) {
                        if (value == null || value.length != 4) {
                          return 'Please enter a valid 4-digit OTP';
                        }
                        return null;
                      },
                      defaultPinTheme: PinTheme(
                        width: 56,
                        height: 64,
                        textStyle: TextStyle(
                          fontSize: 26,
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),

                        decoration: BoxDecoration(
                          color: Color(0xff471E7C),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6),
                          ),
                          border: Border(
                            top: BorderSide(color: Colors.white, width: 1),
                            left: BorderSide(color: Colors.white, width: 1),
                            right: BorderSide(color: Colors.white, width: 1),
                            bottom: BorderSide(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                      focusedPinTheme: PinTheme(
                        width: 56,
                        height: 64,
                        textStyle: TextStyle(
                          fontSize: 26,
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6),
                          ),
                          border: Border(
                            top: BorderSide(color: Colors.white, width: 1),
                            left: BorderSide(color: Colors.white, width: 1),
                            right: BorderSide(color: Colors.white, width: 1),
                            bottom: BorderSide(color: Colors.white, width: 2),
                          ),
                          image: DecorationImage(
                            image: AssetImage('Asset/image/button.png'),
                            fit: .cover,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 40),

                  // Resend code in timer //
                  Center(
                    child: isResendEnabled
                        ? TextButton(
                            onPressed: () async {
                              await auth.sendPasswordResetOtp(
                                email: widget.email,
                              );

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("OTP Sent Again")),
                              );

                              _startTimer();
                            },
                            child: Text(
                              "Resend OTP",
                              style: TextStyle(
                                color: Color(0xff80E3F3),
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                        : RichText(
                            text: TextSpan(
                              text: "Resend code in ",
                              style: TextStyle(
                                color: Color(0xffDADADA),
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      "00:${start.toString().padLeft(2, '0')}",
                                  style: TextStyle(
                                    color: Color(0xff80E3F3),
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                  SizedBox(height: 40),

                  // // Verify mail button //
                  InkWell(
                    borderRadius: BorderRadius.circular(12),

                    onTap: () {
                      () async {
                        if (otpControler.text.length != 6) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please enter valid OTP"),
                            ),
                          );
                          return;
                        }

                        try {
                          final error = await auth.verifyOtp(
                            email: widget.email,
                            otp: otpControler.text.trim(),
                          );

                          if (error != null) {
                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(SnackBar(content: Text(error)));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Email verified successfully"),
                              ),
                            );

                            Get.offAll(() => const SigninScreen());
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(e.toString())));
                        }
                      };
                    },

                    child: Container(
                      height: 48,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        border: Border.all(color: Colors.white, width: 1.5),
                        image: const DecorationImage(
                          image: AssetImage('Asset/image/button.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "Verify mail",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
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
