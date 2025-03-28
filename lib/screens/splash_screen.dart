import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vigilant_vision/constants/color_constants.dart';
import 'package:vigilant_vision/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _wipeController;
  late Animation<double> _wipeAnimation;
  late AnimationController _circleController;
  late Animation<double> _circleAnimation;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  double _circleRadius = 0;

  @override
  void initState() {
    super.initState();

    // Diagonal wipe animation
    _wipeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _wipeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _wipeController, curve: Curves.easeInOut),
    );

    // Circle reveal animation
    _circleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _circleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _circleController, curve: Curves.easeOut),
    )..addListener(() {
        setState(() {
          final size = MediaQuery.of(context).size;
          final diagonal =
              sqrt(size.width * size.width + size.height * size.height);
          _circleRadius = _circleAnimation.value * diagonal;
        });
      });

    // Fade animation
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );

    // First run the diagonal wipe then start the circle reveal then fade
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _wipeController.forward().whenComplete(() {
        _circleController.forward().whenComplete(() {
          _fadeController.forward().whenComplete(() {
            Future.delayed(const Duration(milliseconds: 800), () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LogInScreen()),
              );
            });
          });
        });
      });
    });
  }

  @override
  void dispose() {
    _wipeController.dispose();
    _circleController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  // This widget builds gradient background
  Widget _buildGradientBackground() {
    return Container(
      decoration: const BoxDecoration(
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
    );
  }

  //This widget builds the logo and text with FadeTransition
  Widget _buildFadeContent() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/icon/LOGO.svg",
              width: 70,
              height: 70,
            ),
            const SizedBox(height: 10),
            const Text(
              "VigilantVision",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 2.0,
              ),
            )
          ],
        ),
      ),
    );
  }

  //clips gradient background using a circle that expands.
  Widget _buildClippedGradient() {
    return ClipOval(
      clipper: CircleClipper(radius: _circleRadius),
      child: _buildGradientBackground(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ClrUtils.primary,
      body: Stack(
        children: [
          Container(
            color: ClrUtils.primary,
          ),
          AnimatedBuilder(
            animation: _wipeAnimation,
            builder: (context, child) {
              return CustomPaint(
                size: MediaQuery.of(context).size,
                painter: DiagonalWipePainter(percentage: _wipeAnimation.value),
              );
            },
          ),
          _buildClippedGradient(),
          _buildFadeContent(),
        ],
      ),
    );
  }
}

// Custom painter for diagonal wipe
class DiagonalWipePainter extends CustomPainter {
  final double percentage;
  DiagonalWipePainter({required this.percentage});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = const Color.fromARGB(247, 10, 10, 10)
      ..style = PaintingStyle.fill;

    final double maxDiagonal = 2000;
    final double currentLength = percentage * maxDiagonal;
    final double offset = currentLength / sqrt(2);

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(offset, 0);
    path.lineTo(0, offset);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant DiagonalWipePainter oldDelegate) {
    return oldDelegate.percentage != percentage;
  }
}

// Custom clipper for expanding circle
class CircleClipper extends CustomClipper<Rect> {
  final double radius;
  CircleClipper({required this.radius});

  @override
  Rect getClip(Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    return Rect.fromCircle(center: center, radius: radius);
  }

  @override
  bool shouldReclip(covariant CircleClipper oldClipper) {
    return radius != oldClipper.radius;
  }
}
