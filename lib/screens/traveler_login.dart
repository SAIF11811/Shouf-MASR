import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../shared_preference.dart';
import '../widgets/components.dart';
import 'traveler_signup.dart';
import 'role_selection.dart';

class TravelerLogin extends StatefulWidget {
  const TravelerLogin({super.key});

  @override
  State<TravelerLogin> createState() => _TravelerLoginState();
}

class _TravelerLoginState extends State<TravelerLogin> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadSavedLogin();
  }

  void _loadSavedLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? remember = prefs.getBool('remember_me') ?? false;

    if (remember) {
      setState(() {
        _rememberMe = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // Disable back navigation
      child: Scaffold(
        backgroundColor: const Color(0xFFcdcc00),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Clickable Logo
                  GestureDetector(
                    onTap: () {
                      Get.offAll(() => const RoleSelection());
                    },
                    child: Image.network(
                      'https://cdn-ai.onspace.ai/onspace/figma/ZC9x4trmvyQe3EwsqDQBdR/248cd0554d0da56d81aece5474bbcdfb9f21ec3a.png',
                      width: 220,
                      height: 80,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Form fields
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Email
                      CustomTextField(
                        controller: emailController,
                        label: "Email",
                        hintText: "Enter email",
                        prefixIcon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) =>
                        value != null && value.contains("@")
                            ? null
                            : "Invalid email",
                      ),
                      const SizedBox(height: 16),

                      // Password
                      CustomTextField(
                        controller: passwordController,
                        label: "Password",
                        hintText: "Enter password",
                        isPassword: true,
                        prefixIcon: Icons.lock,
                        validator: (value) =>
                        value != null && value.length >= 6
                            ? null
                            : "Min 6 characters",
                      ),
                      const SizedBox(height: 12),

                      // Forgot password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // TODO: Add forgot password logic
                          },
                          child: const Text(
                            "Forgot password?",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      Row(
                        children: [
                          Checkbox(
                            value: _rememberMe,
                            onChanged: (value) {
                              setState(() {
                                _rememberMe = value!;
                              });
                            },
                            activeColor: Colors.blue,
                          ),
                          const Text(
                            "Remember me",
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Continue button
                      Center(
                        child: CustomElevatedButton(
                          text: "Login",
                          onPressed: () async {
                            await SharedPreferenceHelper.setRememberMe(_rememberMe);
                            Get.offAllNamed('/home');
                          },
                          fullWidth: false,
                          backgroundColor: Colors.white,
                          textColor: Colors.black,
                          icon: Icons.arrow_forward,
                          iconRight: true,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Don’t have an account? Signup
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don’t have an account?",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.to(() => const TravelerSignup());
                            },
                            child: const Text(
                              "Signup",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
