import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigilant_vision/bloc/auth_bloc.dart';
import 'package:vigilant_vision/bloc/auth_state.dart';
import 'package:vigilant_vision/constants/color_constants.dart';
import 'package:vigilant_vision/constants/screensize_constants.dart';
import 'package:vigilant_vision/models/user.dart';
import 'package:vigilant_vision/repositories/alert_repository.dart';
import 'package:vigilant_vision/repositories/auth_repository.dart';
import 'package:vigilant_vision/screens/login_screen.dart';
//import 'package:vigilant_vision/repositories/auth_repository.dart';
import 'package:vigilant_vision/widgets/text/customText.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.user});

  final UserModel user;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int taskCompleted = 0;
  int taskGenerated = 0;
  int taskOngoing = 0;

  @override
  void initState() {
    super.initState();
    fetchProfileAlertDetails();
  }

  void fetchProfileAlertDetails() async {
    int completedCount =
        await AlertRepository().fetchTaskCompletedCount(widget.user.volID);
    int generatedCount =
        await AlertRepository().fetchTaskGeneratedCount(widget.user.volID);
    int ongoingCount =
        await AlertRepository().fetchTaskOngoingCount(widget.user.volID);

    setState(() {
      taskCompleted = completedCount;
      taskGenerated = generatedCount;
      taskOngoing = ongoingCount;
    });
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
                padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                decoration: BoxDecoration(
                  color: ClrUtils.secondary,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              AuthRepository().logOut();

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LogInScreen()));
                            });
                          },
                          icon: Icon(
                            Icons.logout_rounded,
                            color: ClrUtils.primary,
                          )),
                    ),
                    const SizedBox(height: 10),
                    CustomText(
                      text: widget.user.fullName,
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      text: "Volunteer",
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatItem("${taskCompleted}", "Tasks Completed"),
                          SizedBox(
                            height: 60,
                            width: 2,
                            child: ColoredBox(
                              color: Colors.white70,
                            ),
                          ),
                          _buildStatItem("${taskGenerated}", "Tasks Generated"),
                          SizedBox(
                            height: 60,
                            width: 2,
                            child: ColoredBox(
                              color: Colors.white70,
                            ),
                          ),
                          _buildStatItem("${taskOngoing}", "Tasks Ongoing"),
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
                        text: widget.user.fullName,
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
                        text: widget.user.email,
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
                        text: widget.user.phoneNo,
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
                        text: widget.user.volID,
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
