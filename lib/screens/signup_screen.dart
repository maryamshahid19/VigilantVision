import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigilant_vision/bloc/auth_bloc.dart';
import 'package:vigilant_vision/bloc/auth_event.dart';
import 'package:vigilant_vision/bloc/auth_state.dart';
import 'package:vigilant_vision/constants/color_constants.dart';
import 'package:vigilant_vision/constants/screensize_constants.dart';
import 'package:vigilant_vision/screens/login_screen.dart';
import 'package:vigilant_vision/widgets/button/customButton.dart';
import 'package:vigilant_vision/widgets/button/customTextButton.dart';
import 'package:vigilant_vision/widgets/text/customText.dart';
import 'package:vigilant_vision/widgets/textfield/customTextfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  bool val = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Successful!")),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LogInScreen()),
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.message), backgroundColor: Colors.red),
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
                        50, 80, 50, SizeCons.getWidth(context) * 0.7),
                    width: SizeCons.getWidth(context),
                    height: SizeCons.getHeight(context),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          ClrUtils.secondary,
                          ClrUtils.textTertiary,
                          ClrUtils.tertiary,
                        ],
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                  ),
                ),
                Positioned(
                  top: SizeCons.getHeight(context) * 0.15,
                  left: SizeCons.getWidth(context) * 0.05,
                  child: Container(
                    width: SizeCons.getWidth(context) * 0.9,
                    height: SizeCons.getHeight(context) * 0.7,
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: ClrUtils.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: CustomText(
                            text: "Signup",
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: ClrUtils.textPrimary,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: "Already have an account?",
                              color: ClrUtils.textSecondary,
                              fontSize: 12,
                            ),
                            CustomTextButton(
                              text: "Log In",
                              onpressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LogInScreen(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        CustomText(
                          text: "Name",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        CustomTextField(
                          controller: nameController,
                          hintText: "Maryam",
                          maxline: 1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          text: "Email",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        CustomTextField(
                          controller: emailController,
                          hintText: "abc@gmail.com",
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          text: "Password",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        CustomTextField(
                          controller: passwordController,
                          hintText: "abc123",
                          isPassword: true,
                          maxline: 1,
                        ),
                        CustomText(
                          text: "Phone No",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        CustomTextField(
                          controller: phoneController,
                          hintText: "0308768456",
                          keyboardType: TextInputType.numberWithOptions(),
                          maxline: 1,
                        ),
                        SizedBox(height: 20),
                        CustomButton(
                          text: "SignUp",
                          onPressed: () {
                            String phone = phoneController.text.trim();

                            if (phone.length != 11 ||
                                !RegExp(r'^03[0-9]{9}$').hasMatch(phone)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "Enter a valid 11 digit number")));
                              return;
                            }

                            context.read<AuthBloc>().add(
                                  SignUpRequested(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                    name: nameController.text.trim(),
                                    phoneNo: phoneController.text.trim(),
                                  ),
                                );
                          },
                        ),
                      ],
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
