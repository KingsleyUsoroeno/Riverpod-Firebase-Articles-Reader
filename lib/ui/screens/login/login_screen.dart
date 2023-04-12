import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sport_house/ui/components/custom_button.dart';
import 'package:sport_house/ui/components/custom_text_field.dart';
import 'package:sport_house/ui/screens/home/home_screen.dart';
import 'package:sport_house/ui/screens/login/provider/login_screen_provider.dart';
import 'package:sport_house/ui/screens/login/provider/login_screen_state.dart';
import 'package:sport_house/ui/screens/sign-up/sign_up_screen.dart';
import 'package:sport_house/ui/theme/app_colors.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _loginInUser() {
    if (_formKey.currentState!.validate()) {
      final String password = passwordController.text.trim();
      final String email = emailController.text.trim();
      ref.read(loginScreenProvider.notifier).loginUser(email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginScreenProvider);

    ref.listen<LoginScreenState>(loginScreenProvider, (_, state) {
      if (state.isUserAuthenticated) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => const HomeScreen()));
      }
      if (state.errorMessage != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        ref.read(loginScreenProvider.notifier).refresh();
      }
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 60),
          child: state.isAuthenticating
              ? const Center(child: CircularProgressIndicator())
              : Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Welcome back', style: Theme.of(context).textTheme.headlineSmall),
                      Text('Sign in Now',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w400, color: const Color(0xFF59595A))),
                      const SizedBox(height: 32.0),
                      CustomTextField(
                        controller: emailController,
                        label: "Email",
                        validator: (value) {
                          return (value == null || value.isEmpty)
                              ? "Please provide a valid email address"
                              : null;
                        },
                      ),
                      const SizedBox(height: 12.0),
                      CustomTextField(
                        controller: passwordController,
                        label: "Password",
                        validator: (value) {
                          final bool isValidPassword =
                              value != null && value.isNotEmpty && value.length > 8;
                          return isValidPassword ? null : "Please enter a valid password";
                        },
                      ),
                      const SizedBox(height: 60.0),
                      CustomButton(
                        text: "Log In",
                        onPress: _loginInUser,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Center(
                          child: Text(
                            "Don't have an account?",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 17),
                          ),
                        ),
                      ),
                      Center(
                        child: TextButton(
                          child: SizedBox(
                            width: double.infinity,
                            height: 38,
                            child: Center(
                                child: Text(
                              'Sign up',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontSize: 18, color: AppColors.appBlue),
                            )),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) => SignUpScreen()));
                          },
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
