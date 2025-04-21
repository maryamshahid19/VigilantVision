import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigilant_vision/bloc/auth_bloc.dart';
import 'package:vigilant_vision/bloc/auth_state.dart';
import 'package:vigilant_vision/constants/color_constants.dart';
import 'package:vigilant_vision/constants/screensize_constants.dart';
import 'package:vigilant_vision/models/user.dart';
import 'package:vigilant_vision/repositories/auth_repository.dart';
import 'package:vigilant_vision/widgets/text/customText.dart';
//import 'package:vigilant_vision/widgets/textfield/customTextfield.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserModel? user;
  @override
  void initState() {
    super.initState();
    fetchCurrentUser();
  }

  void fetchCurrentUser() async {
    user = await AuthRepository().getCurrentUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          //final user = context.read<AuthBloc>().authRepository.getCurrentUser();
        }
        return Scaffold(
          backgroundColor: ClrUtils.primary,
          body: Column(
            children: [
              Container(
                height: SizeCons.getHeight(context) * 0.4,
                width: SizeCons.getWidth(context),
                decoration: BoxDecoration(
                  color: ClrUtils.secondary,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    // Profile Image
                    // Stack(
                    //   alignment: Alignment.bottomRight,
                    //   children: [
                    //     CircleAvatar(
                    //       backgroundColor: ClrUtils.primary,
                    //       radius: 50,
                    //       child: ClipRRect(
                    //         borderRadius: BorderRadius.circular(100),
                    //         child: Image(
                    //           image: AssetImage('assets/icon/pic.PNG'),
                    //           height: 95,
                    //           width: 95,
                    //         ),
                    //       ),
                    //     ),
                    //     Container(
                    //       padding: const EdgeInsets.all(5),
                    //       decoration: const BoxDecoration(
                    //         color: Colors.white,
                    //         shape: BoxShape.circle,
                    //       ),
                    //       child: const Icon(Icons.camera_alt,
                    //           size: 20, color: Colors.blue),
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(height: 10),
                    CustomText(
                      text: user!.fullName,
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),

                    CustomText(
                      text: "Volunteer",
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                    const SizedBox(height: 30),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatItem("23", "Tasks Completed"),
                          SizedBox(
                            height: 60,
                            width: 2,
                            child: ColoredBox(
                              color: Colors.white70,
                            ),
                          ),
                          _buildStatItem("09", "Tasks Generated"),
                          SizedBox(
                            height: 60,
                            width: 2,
                            child: ColoredBox(
                              color: Colors.white70,
                            ),
                          ),
                          _buildStatItem("04", "Tasks Ongoing"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: SizeCons.getHeight(context) * 0.5,
                width: SizeCons.getWidth(context),
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: ClrUtils.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Full Name",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: ClrUtils.textSecondary,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 50,
                      width: SizeCons.getWidth(context) * 0.9,
                      padding: EdgeInsets.all(13),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: ClrUtils.border,
                          width: 1,
                        ),
                      ),
                      child: CustomText(
                        text: user!.fullName,
                        color: ClrUtils.textFifth,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.3,
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomText(
                      text: "Email",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: ClrUtils.textSecondary,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 50,
                      width: SizeCons.getWidth(context) * 0.9,
                      padding: EdgeInsets.all(13),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: ClrUtils.border,
                          width: 1,
                        ),
                      ),
                      child: CustomText(
                        text: user!.email,
                        color: ClrUtils.textFifth,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.3,
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomText(
                      text: "Phone Number",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: ClrUtils.textSecondary,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 50,
                      width: SizeCons.getWidth(context) * 0.9,
                      padding: EdgeInsets.all(13),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: ClrUtils.border,
                          width: 1,
                        ),
                      ),
                      child: CustomText(
                        text: user!.phoneNo,
                        color: ClrUtils.textFifth,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.3,
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomText(
                      text: "Volunteer ID",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: ClrUtils.textSecondary,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 50,
                      width: SizeCons.getWidth(context) * 0.9,
                      padding: EdgeInsets.all(13),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: ClrUtils.border,
                          width: 1,
                        ),
                      ),
                      child: CustomText(
                        text: user!.volID,
                        color: ClrUtils.textFifth,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget _buildStatItem(String count, String label) {
  return Column(
    children: [
      CustomText(
        text: count,
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
      CustomText(
        text: label,
        textAlign: TextAlign.center,
        color: Colors.white70,
        fontSize: 13,
      ),
    ],
  );
}
