import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../config/router/app_router.dart';
import '../../../../config/router/app_router.gr.dart';
import '../../../../core/constants/colors.dart';
import '../../../auth/application/auth_manager.dart';

@RoutePage()
class SplashScreen extends HookWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);

    final controller = useAnimationController(
      duration: const Duration(milliseconds: 2000),
    );

    final fadeAnimation = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    ).drive(Tween<double>(begin: 0.0, end: 1.0));

    final scaleAnimation = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    ).drive(Tween<double>(begin: 0.8, end: 1.0));

    useEffect(() {
      controller.forward().then((_) async {
        final isLoggedIn = AuthManager.instance.isLoggedIn;

        Future.delayed(const Duration(milliseconds: 500), () {
          if (!context.mounted) return;

          Nav.push(context, LoginRoute());

          if (isLoggedIn) {
            Nav.replace(context, HomeRoute());
          } else {
            Nav.replace(context, LoginRoute());
          }
        });
      });

      return null; // cleanup not needed
    }, const []);

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF1C1C1E) : Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: fadeAnimation,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Text(
              "Edu Track",
              style: theme.textTheme.headlineSmall?.copyWith(
                fontSize: 40,
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                height: 1.4,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
