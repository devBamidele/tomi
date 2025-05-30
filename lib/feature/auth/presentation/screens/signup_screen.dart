import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tomi/feature/auth/presentation/extras.dart';

import '../../../../common/components/components.dart';
import '../../../../common/style/component_style.dart';
import '../../../../config/router/app_router.gr.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/colors.dart';
import '../../data/dto/sign_up_dto.dart';
import '../providers/notifier.dart';
import '../providers/state.dart';
import '../widgets/header.dart';
import '../widgets/pwd_req_row.dart';
import '../widgets/text_field_title.dart';
import '../widgets/visibility_icon.dart';

@RoutePage()
class SignupScreen extends HookConsumerWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final validationStates = useState<List<bool>>(List.filled(4, false));
    final theme = Theme.of(context);

    final emailFocusNode = useFocusNode();
    final pwdFocusNode = useFocusNode();
    final cfmPwdFocusNode = useFocusNode();

    final email = useTextEditingController();
    final password = useTextEditingController();
    final cfmPassword = useTextEditingController();

    final emailFormKey = useState(GlobalKey<FormState>());
    final pwdFormKey = useState(GlobalKey<FormState>());
    final cfmPwdFormKey = useState(GlobalKey<FormState>());

    final emailShakeState = useState(GlobalKey<ShakeState>());
    final cfmPwdShakeState = useState(GlobalKey<ShakeState>());

    final pwdVisible = useState(true);
    final cfmPwdVisible = useState(true);

    final pwdColor = useState(AppColors.hintTextColor);
    final cfmPwdColor = useState(AppColors.hintTextColor);

    const requirements = AppStrings.requirements;

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

    useEffect(() {
      void updatePasswordColor() {
        cfmPwdColor.value = cfmPwdFocusNode.hasFocus
            ? AppColors.black
            : cfmPassword.text.isEmpty
            ? AppColors.hintTextColor
            : AppColors.black;
      }

      cfmPwdFocusNode.addListener(updatePasswordColor);

      return () => cfmPwdFocusNode.removeListener(updatePasswordColor);
    }, [cfmPwdFocusNode]);

    useEffect(() {
      void validatePassword() {
        final pwd = password.text;

        validationStates.value = [
          pwd.length >= 8,
          RegExp(r'[a-z]').hasMatch(pwd) && RegExp(r'[A-Z]').hasMatch(pwd),
          RegExp(r'\d').hasMatch(pwd),
          RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(pwd),
        ];
      }

      password.addListener(validatePassword);

      return () => password.removeListener(validatePassword);
    }, [password]);

    bool authLoading() => ref.watch(authNotifierProvider) is Loading;

    void signUp() {
      ref
          .read(authNotifierProvider.notifier)
          .signup(SignUpDto(email: email.text.trim(), password: password.text));
    }

    void validateSignUp() {
      bool emailValid = emailFormKey.value.currentState?.validate() ?? false;
      bool pwdValid = password.text.validatePassword();
      bool cfmPwdValid = cfmPwdFormKey.value.currentState?.validate() ?? false;

      if (emailValid && pwdValid && cfmPwdValid) {
        signUp();
        return;
      }

      if (!emailValid) emailShakeState.value.currentState?.shake();
      if (!cfmPwdValid) cfmPwdShakeState.value.currentState?.shake();
    }

    ref.listen(authNotifierProvider, (prev, next) {
      final isRoute = AutoRouter.of(context).current.name == SignupRoute.name;

      if (next is UnAuthenticated && isRoute) {
        showToast(next.message, context, isError: true);
      } else if (next is Authenticated) {
        // Nav.replaceAll(context, [AssessmentRoute()]);
      }
    });

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () => context.pop(),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.arrow_back, color: AppColors.black),
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: pagePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Header(
                    topSpacing: 0,
                    title: AppStrings.signUpTitle,
                    subtitle: AppStrings.signUpSubtitle,
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
                    child: AppTextField(
                      enabled: !authLoading(),
                      focusNode: pwdFocusNode,
                      textController: password,
                      action: TextInputAction.done,
                      hintText: AppStrings.passwordHint,
                      obscureText: pwdVisible.value,
                      onFieldSubmitted: (password) => validateSignUp(),
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
                  Container(
                    padding: EdgeInsets.all(12.h),
                    margin: EdgeInsets.only(top: 20.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: AppColors.black.withValues(alpha: .6),
                        width: 1, // Border thickness
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(requirements.length * 2 - 1, (
                        index,
                      ) {
                        if (index.isEven) {
                          int requirementIndex = index ~/ 2;
                          return PasswordRequirementRow(
                            theme: theme.textTheme,
                            text: requirements[requirementIndex],
                            checked: validationStates.value[requirementIndex],
                          );
                        }
                        return addHeight(6);
                      }),
                    ),
                  ),
                  addHeight(20),
                  textFieldTitle(AppStrings.cfmPasswordLabel, theme),
                  Form(
                    key: cfmPwdFormKey.value,
                    child: Shake(
                      key: cfmPwdShakeState.value,
                      child: AppTextField(
                        enabled: !authLoading(),
                        focusNode: cfmPwdFocusNode,
                        textController: cfmPassword,
                        action: TextInputAction.done,
                        hintText: AppStrings.passwordHint,
                        obscureText: cfmPwdVisible.value,
                        validation: (value) =>
                            value.validateConfirmPwd(password),
                        onFieldSubmitted: (password) => validateSignUp(),
                        suffixIcon: IconButton(
                          icon: VisibilityIcon(
                            isVisible: cfmPwdVisible.value,
                            iconColor: cfmPwdColor.value,
                          ),
                          onPressed: () =>
                              cfmPwdVisible.value = !cfmPwdVisible.value,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.h),
                    child: AppButton(
                      onPressed: validateSignUp,
                      text: AppStrings.signUpButton,
                      isLoading: authLoading(),
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
