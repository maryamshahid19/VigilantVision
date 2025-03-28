import 'package:flutter/material.dart';
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
  bool val = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/icon/Logo.png"),
                            SizedBox(
                              width: 5,
                            ),
                            CustomText(
                              text: "VigilantVision",
                              color: ClrUtils.primary,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.0,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
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
                    )),
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
                  height: SizeCons.getHeight(context) * 0.5,
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: ClrUtils.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        text: 'Continue with Google',
                        onPressed: () {},
                        borderColor: ClrUtils.border,
                        fontWeight: FontWeight.w600,
                        color: ClrUtils.primary,
                        textColor: ClrUtils.textPrimary,
                        icon: "assets/icon/google.png",
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 2,
                                child: ColoredBox(
                                  color: ClrUtils.border,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: CustomText(
                                text: "Or Login With",
                                color: ClrUtils.textSecondary,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 2,
                                child: ColoredBox(
                                  color: ClrUtils.border,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomTextField(
                        controller: emailController,
                        hintText: "abc@gmail.com",
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: passwordController,
                        hintText: "abc123",
                        isPassword: true,
                        maxline: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Checkbox(
                                  value: false,
                                  onChanged: (obj) {},
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
                          CustomTextButton(
                              text: "Forgot Password?", onpressed: () {}),
                        ],
                      ),
                      CustomButton(
                          text: "Login",
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainLayout()));
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
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
