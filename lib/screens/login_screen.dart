import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vigilant_vision/bloc/auth_bloc.dart';
import 'package:vigilant_vision/bloc/auth_event.dart';
import 'package:vigilant_vision/bloc/auth_state.dart';
import 'package:vigilant_vision/constants/color_constants.dart';
import 'package:vigilant_vision/constants/screensize_constants.dart';
import 'package:vigilant_vision/mainlayout.dart';
import 'package:vigilant_vision/screens/signup_screen.dart';
import 'package:vigilant_vision/widgets/button/customButton.dart';
import 'package:vigilant_vision/widgets/button/customTextButton.dart';
import 'package:vigilant_vision/widgets/text/customText.dart';
import 'package:vigilant_vision/widgets/textfield/customTextfield.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool rememberMe = false;

  List<Map<String, dynamic>> rememberedUsers = [];
  Map<String, dynamic>? selectedUser;

  @override
  void initState() {
    super.initState();
    _loadRememberedUsers();
  }

  Future<void> _loadRememberedUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final userJsonList = prefs.getStringList('remembered_users') ?? [];
    final rememberFlag = prefs.getBool('remember_me') ?? false;

    setState(() {
      rememberedUsers = userJsonList
          .map((jsonStr) => jsonDecode(jsonStr) as Map<String, dynamic>)
          .toList();
      rememberMe = rememberFlag;
    });
  }

  Future<void> _saveRememberedUser(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> userJsonList = prefs.getStringList('remembered_users') ?? [];

    Map<String, dynamic> newUser = {'email': email, 'password': password};

    userJsonList.removeWhere((entry) {
      final existing = jsonDecode(entry);
      return existing['email'] == email;
    });

    userJsonList.add(jsonEncode(newUser));

    await prefs.setStringList('remembered_users', userJsonList);
    await prefs.setBool('remember_me', true);
  }

  Future<void> _removeRememberedUser(String email) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> userJsonList = prefs.getStringList('remembered_users') ?? [];

    userJsonList.removeWhere((entry) {
      final user = jsonDecode(entry);
      return user['email'] == email;
    });

    await prefs.setStringList('remembered_users', userJsonList);
  }

  void _handleLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (rememberMe) {
      await _saveRememberedUser(email, password);
    } else {
      await _removeRememberedUser(email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MainLayout()),
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Center(
          child: Container(
            color: ClrUtils.primary,
            width: SizeCons.getWidth(context),
            height: SizeCons.getHeight(context),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(
                        50, 80, 50, SizeCons.getWidth(context) * 0.22),
                    width: SizeCons.getWidth(context),
                    height: SizeCons.getHeight(context) * 0.5,
                    color: ClrUtils.secondary,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/icon/Logo.png"),
                            SizedBox(width: 5),
                            CustomText(
                              text: "VigilantVision",
                              color: ClrUtils.primary,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.0,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        CustomText(
                          text: "Sign in to your Account",
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: ClrUtils.primary,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        CustomText(
                          text: "Enter your email and password to login",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: ClrUtils.primary,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: SizeCons.getWidth(context),
                    height: SizeCons.getHeight(context) * 0.5,
                    color: ClrUtils.background,
                  ),
                ),
                Positioned(
                  top: SizeCons.getHeight(context) * 0.3,
                  left: SizeCons.getWidth(context) * 0.05,
                  child: Container(
                    width: SizeCons.getWidth(context) * 0.9,
                    // height: SizeCons.getHeight(context) * 0.45,
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: ClrUtils.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (rememberedUsers.isNotEmpty)
                            DropdownButton<Map<String, dynamic>>(
                              hint: CustomText(
                                text: "Select remembered user",
                                fontSize: 14,
                              ),
                              value: selectedUser,
                              dropdownColor: ClrUtils.primary,
                              items: rememberedUsers.map((user) {
                                return DropdownMenuItem(
                                  value: user,
                                  child: CustomText(
                                    text: user['email'],
                                    fontSize: 14,
                                  ),
                                );
                              }).toList(),
                              onChanged: (user) {
                                setState(() {
                                  selectedUser = user!;
                                  emailController.text = user['email'];
                                  passwordController.text = user['password'];
                                });
                                _handleLogin();
                              },
                            ),
                          SizedBox(height: 20),
                          CustomTextField(
                            controller: emailController,
                            hintText: "abc@gmail.com",
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 10),
                          CustomTextField(
                            controller: passwordController,
                            hintText: "abc123",
                            isPassword: true,
                            maxline: 1,
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: rememberMe,
                                      onChanged: (val) {
                                        setState(() {
                                          rememberMe = val!;
                                        });
                                      },
                                      activeColor: ClrUtils.textTertiary,
                                    ),
                                    CustomText(
                                      text: "Remember me",
                                      color: ClrUtils.textSecondary,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          CustomButton(
                              text: "Login",
                              onPressed: () {
                                _handleLogin();
                                context.read<AuthBloc>().add(
                                      LogInRequested(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      ),
                                    );
                              }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: "Don't have an account?",
                                color: ClrUtils.textSecondary,
                                fontSize: 12,
                              ),
                              CustomTextButton(
                                text: "Sign Up",
                                onpressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignUpScreen(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
