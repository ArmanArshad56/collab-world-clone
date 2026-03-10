import 'package:collabworld_ui_design/src/components/app_bg.dart';
import 'package:collabworld_ui_design/src/service/supabase_service/supabase_service.dart';
import 'package:collabworld_ui_design/src/views/signin_screen.dart';
import 'package:collabworld_ui_design/src/views/verify_email_screen.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignupScreen> {
  bool isPasswordVisible = false;
  int selectedIndex = -1;
  String? selectedGender;
  DateTime? selectedDate;
  bool isLoading = false;
  bool isChecked = false;
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  // final auth = AuthService();
  final auth = SupaAuthService();

  // final supabase = SupaAuthService();

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

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
                  ),
                  Center(
                    child: Text(
                      'Join the Creator Network',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontFamily: 'Syne',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      'Connect with brands and influencers worldwide.',
                      style: TextStyle(
                        color: Color(0xffDADADA),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),

                  //full name field //
                  const Text(
                    "Full Name",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 5),
                  TextField(
                    controller: fullNameController,
                    keyboardType: TextInputType.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      hintText: "Your Full Name",
                      hintStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                      // Right side icon
                      suffixIcon: const Icon(
                        Icons.person_outline,
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

                  // Email address field //
                  const Text(
                    "Email Address",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
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

                  // Password field //
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
                      fillColor: Color(0xff471E7C), // background transparent
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),

                  // Influencer Type field //
                  const Text(
                    "Influencer Type",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(14),
                        onTap: () {
                          setState(() {
                            selectedIndex = 0;
                          });
                        },
                        child: Container(
                          width: 152,
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: Colors.white, width: 1.5),
                            color: selectedIndex == 0
                                ? null
                                : const Color(0xFF471E7C),
                            image: selectedIndex == 0
                                ? const DecorationImage(
                                    image: AssetImage('Asset/image/button.png'),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Creator',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      InkWell(
                        borderRadius: BorderRadius.circular(14),
                        onTap: () {
                          setState(() {
                            selectedIndex = 1;
                          });
                        },
                        child: Container(
                          width: 152,
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: Colors.white, width: 1.5),
                            color: selectedIndex == 1
                                ? null
                                : const Color(0xFF471E7C),
                            image: selectedIndex == 1
                                ? const DecorationImage(
                                    image: AssetImage('Asset/image/button.png'),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Brand',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),

                  // phone number field //
                  Row(
                    children: [
                      Container(
                        height: 48,
                        width: 115,
                        decoration: BoxDecoration(
                          color: const Color(0xFF471E7C),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),

                        alignment: Alignment.center,
                        child: CountryCodePicker(
                          onChanged: (country) {
                            print(country.dialCode); // +91, +1 etc
                            print(country.code); // IN, US etc
                          },
                          initialSelection: 'US',
                          favorite: const [
                            '+1',
                            'US',
                            '+91',
                            'IN',
                            '+92',
                            'PK',
                          ],

                          showCountryOnly: false,
                          showOnlyCountryWhenClosed: false,
                          alignLeft: false,
                          padding: EdgeInsets.zero,

                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            height: 1.2,
                          ),

                          dialogTextStyle: const TextStyle(
                            fontFamily: 'Poppins',
                          ),
                          searchStyle: const TextStyle(fontFamily: 'Poppins'),

                          builder: (country) {
                            if (country == null) return const SizedBox();

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  country.flagUri!,
                                  package: 'country_code_picker',
                                  width: 20,
                                  height: 12,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  country.dialCode ?? '',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    height: 1.2,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ],
                            );
                          },
                        ),
                      ),

                      const SizedBox(width: 15),

                      Expanded(
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xFF471E7C),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: Colors.white, width: 1.5),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 17),
                          child: TextField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "(555) 000-0000",
                              hintStyle: TextStyle(
                                color: Color(0xffdadada),
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 15),

                  // gender and dob field //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Gender
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Gender",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: 152,
                            height: 48,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 17,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF471E7C),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1.5,
                                ),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  dropdownColor: const Color(0xFF471E7C),
                                  value: selectedGender,
                                  hint: const Text(
                                    "Select",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.white,
                                  ),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                  ),
                                  items: ['Male', 'Female', 'Other']
                                      .map(
                                        (gender) => DropdownMenuItem(
                                          value: gender,
                                          child: Text(gender),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedGender = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Date of Birth
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Date of Birth",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: 152,
                            height: 48,
                            child: InkWell(
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime(2000),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime.now(),
                                );
                                if (pickedDate != null) {
                                  setState(() {
                                    selectedDate = pickedDate;
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF471E7C),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1.5,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      selectedDate == null
                                          ? "mm/dd/yyyy"
                                          : "${selectedDate!.month}/${selectedDate!.day}/${selectedDate!.year}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.calendar_today,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Terms of Service / Privacy Policy //
                  InkWell(
                    onTap: () {
                      setState(() {
                        isChecked = !isChecked;
                      });
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 17,
                          height: 17,
                          decoration: BoxDecoration(
                            color: isChecked
                                ? Color(0xff4ADE80)
                                : const Color(0xff471E7C),
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(color: Colors.white, width: 1),
                          ),
                          child: isChecked
                              ? const Icon(
                                  Icons.check,
                                  color: Color(0xff471E7C),
                                  size: 16,
                                )
                              : null,
                        ),

                        const SizedBox(width: 10),
                        Expanded(
                          child: RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      "By creating an account, you agree to our ",
                                ),
                                TextSpan(
                                  text: "Terms of Service",
                                  style: TextStyle(
                                    color: Color(0xff80E3F3),
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(text: " and "),
                                TextSpan(
                                  text: "Privacy Policy",
                                  style: TextStyle(
                                    color: Color(0xff80E3F3),
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),

                  // Create Acounts button //
                  InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () async {
                      if (isLoading) return; // prevent multiple taps

                      setState(() => isLoading = true);
                      final fullName = fullNameController.text.trim();
                      final email = emailController.text.trim();
                      final password = passwordController.text.trim();
                      final phone = phoneController.text.trim();
                      final dob = selectedDate.toString();
                      final gender = selectedGender.toString();
                      final isCreator = selectedIndex == 0;

                      print("🔹 Signup button pressed for email: $email");

                      try {
                        final error = await auth.signUpUser(
                          fullName: fullName,
                          email: email,
                          phone: phone,
                          dob: dob,
                          gender: gender,
                          isCreator: isCreator,
                          password: password,
                        );

                        setState(() => isLoading = false);

                        if (error != null) {
                          // Signup failed
                          print("❌ Signup failed: $error");
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(error)));
                        } else {
                          // Signup success
                          print("✅ Signup successful: $email");
                          Get.to(() => Verifyemailview(email: email));
                          // Navigator.pushReplacement(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) =>
                          //         Verifyemailview(email: email),
                          //   ),
                          // );
                        }
                      } catch (e) {
                        setState(() => isLoading = false);
                        print("⚠️ Signup exception: $e");
                        // Get.snackbar(title, message)
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
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              "Create Account",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Or register with email //
                  Row(
                    children: [
                      Expanded(
                        child: Container(height: 1, color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 17),
                        child: Text(
                          "Or register with email",
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
                  SizedBox(height: 20),

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

                  // Login  button //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
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
                  SizedBox(height: 70),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
