import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tomi/feature/auth/presentation/extras.dart';

import '../../../../common/components/components.dart';
import '../../../../common/style/component_style.dart';
import '../../../../config/router/app_router.dart';
import '../../../../config/router/app_router.gr.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/colors.dart';
import '../providers/notifier.dart';
import '../providers/state.dart';
import '../widgets/header.dart';
import '../widgets/text_field_title.dart';
import '../widgets/visibility_icon.dart';

@RoutePage()
class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final emailFocusNode = useFocusNode();
    final pwdFocusNode = useFocusNode();

    final email = useTextEditingController();
    final password = useTextEditingController();

    final emailFormKey = useState(GlobalKey<FormState>());
    final pwdFormKey = useState(GlobalKey<FormState>());

    final emailShakeState = useState(GlobalKey<ShakeState>());
    final pwdShakeState = useState(GlobalKey<ShakeState>());

    final pwdVisible = useState(true);
    final pwdColor = useState(AppColors.hintTextColor);

    useEffect(() {
      void updatePasswordColor() {
        pwdColor.value = pwdFocusNode.hasFocus
            ? AppColors.black
            : password.text.isEmpty
            ? AppColors.hintTextColor
            : AppColors.black;
      }

      pwdFocusNode.addListener(updatePasswordColor);

      return () => pwdFocusNode.removeListener(updatePasswordColor);
    }, [pwdFocusNode]);

    bool authLoading() => ref.watch(authNotifierProvider) is Loading;

    void login() {
      Nav.push(context, HomeRoute());
      // ref
      //     .read(authNotifierProvider.notifier)
      //     .login(LoginDto(email: email.text.trim(), password: password.text));
    }

    void validateLogin() {
      bool emailValid = emailFormKey.value.currentState?.validate() ?? false;
      bool pwdValid = pwdFormKey.value.currentState?.validate() ?? false;

      if (emailValid && pwdValid) {
        login();
        return;
      }

      if (!emailValid) emailShakeState.value.currentState?.shake();
      if (!pwdValid) pwdShakeState.value.currentState?.shake();
    }

    ref.listen<AuthState>(authNotifierProvider, (prev, next) {
      final isRoute = AutoRouter.of(context).current.name == LoginRoute.name;

      if (next is UnAuthenticated && isRoute) {
        showToast(next.message, context, isError: true);
      } else if (next is Authenticated) {
        //    Nav.replaceAll(context, [AssessmentRoute()]);
      }
    });

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: pagePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  addHeight(20),
                  const Header(
                    title: AppStrings.loginTitle,
                    subtitle: AppStrings.loginSubtitle,
                  ),
                  textFieldTitle(AppStrings.emailLabel, theme),
                  Form(
                    key: emailFormKey.value,
                    child: Shake(
                      key: emailShakeState.value,
                      child: AppTextField(
                        enabled: !authLoading(),
                        focusNode: emailFocusNode,
                        textController: email,
                        hintText: AppStrings.emailHint,
                        validation: (email) => email?.trim().validateEmail(),
                      ),
                    ),
                  ),
                  addHeight(20),
                  textFieldTitle(AppStrings.passwordLabel, theme),
                  Form(
                    key: pwdFormKey.value,
                    child: Shake(
                      key: pwdShakeState.value,
                      child: AppTextField(
                        enabled: !authLoading(),
                        focusNode: pwdFocusNode,
                        textController: password,
                        action: TextInputAction.done,
                        hintText: AppStrings.passwordHint,
                        obscureText: pwdVisible.value,
                        onFieldSubmitted: (password) => validateLogin(),
                        validation: (pass) => pass?.validateString('Password'),
                        suffixIcon: IconButton(
                          icon: VisibilityIcon(
                            isVisible: pwdVisible.value,
                            iconColor: pwdColor.value,
                          ),
                          onPressed: () => pwdVisible.value = !pwdVisible.value,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 40.h),
                    child: AppButton(
                      onPressed: validateLogin,
                      text: AppStrings.loginButton,
                      isLoading: authLoading(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 6.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.unRegistered,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontSize: 16,
                            color: AppColors.hintTextColor,
                            height: 1.4,
                            letterSpacing: 0.5,
                          ),
                        ),
                        TextButton(
                          onPressed: () => Nav.push(context, SignupRoute()),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.fromLTRB(0, 7, 11, 7),
                          ),
                          child: textFieldTitle(
                            AppStrings.cAccount,
                            theme,
                            bottomPadding: 0,
                          ),
                        ),
                      ],
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
