import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sport_house/ui/components/custom_button.dart';
import 'package:sport_house/ui/components/custom_text_field.dart';
import 'package:sport_house/ui/screens/home/home_screen.dart';
import 'package:sport_house/ui/screens/login/login_screen.dart';
import 'package:sport_house/ui/screens/sign-up/provider/sign_up_screen_provider.dart';
import 'package:sport_house/ui/screens/sign-up/provider/sign_up_screen_state.dart';
import 'package:sport_house/ui/theme/app_colors.dart';

class SignUpScreen extends ConsumerWidget {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  SignUpScreen({Key? key}) : super(key: key);

  void _signUpUser(WidgetRef ref) {
    if (_formKey.currentState!.validate()) {
      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();
      final String username = usernameController.text.trim();
      ref.read(signUpScreenProvider.notifier).signUpUser(email, password, username);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signUpScreenProvider);

    ref.listen<SignUpScreenState>(signUpScreenProvider, (_, nextState) {
      if (nextState.isUserAuthenticated) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => const HomeScreen()));
      }
      if (nextState.errorMessage != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(nextState.errorMessage ?? '')));
        ref.read(signUpScreenProvider.notifier).refresh();
      }
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 40),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Create Account', style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 16.0),
                Text(
                  'Create an account and get unlimited access to our features',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 30.0),
                CustomTextField(
                  controller: usernameController,
                  label: "Username",
                  hintText: "your preferred username",
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide a valid username';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                CustomTextField(
                  controller: emailController,
                  label: "Email",
                  hintText: 'your email address',
                  validator: (String? value) {
                    return (value == null || value.isEmpty)
                        ? "Please provide a valid email address"
                        : null;
                  },
                ),
                const SizedBox(height: 20.0),
                CustomTextField(
                  controller: passwordController,
                  label: "Password",
                  hintText: "at least 8 characters",
                  validator: (String? value) {
                    final bool isValidPassword =
                        value != null && value.isNotEmpty && value.length > 8;
                    return isValidPassword ? null : "Please enter a valid password";
                  },
                ),
                const SizedBox(height: 28.0),
                const Spacer(),
                if (state.isAuthenticating)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 14),
                    child: Center(child: CircularProgressIndicator()),
                  )
                else
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(text: "Sign Up", onPress: () => _signUpUser(ref)),
                        const SizedBox(height: 20.0),
                        Text(
                          "Already have an account",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        TextButton(
                          child: SizedBox(
                            width: double.infinity,
                            height: 38,
                            child: Center(
                                child: Text(
                              'Log in',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontSize: 18, color: AppColors.appBlue),
                            )),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) => const LoginScreen()));
                          },
                        )
                      ],
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
