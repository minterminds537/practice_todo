import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:practice/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:practice/features/auth/presentation/bloc/auth_event.dart';
import 'package:practice/features/auth/presentation/bloc/auth_state.dart';
import '../../../../core/navigation/app_router.dart';
import '../../../../core/utils/constants/app_strings.dart';
import '../../../../core/utils/widgets/custom_button.dart';
import '../../../../core/utils/widgets/custom_text.dart';
import '../../../../core/utils/widgets/custom_text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.login),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text: AppStrings.welcomeBack,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 32),
            CustomTextField(
              controller: emailController,
              label: AppStrings.email,
              hint: "Enter your email",
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: passwordController,
              label: AppStrings.password,
              hint: "Enter your password",
              isPassword: true,
            ),
            const SizedBox(height: 32),
            BlocConsumer<AuthBloc,AuthState>(builder: (BuildContext context, AuthState state) {
              return   CustomButton(
                text: AppStrings.login,
                isLoading: state is LoginLoading ? true:false,
                onPressed: () {
                  // Handle Login logic
                  context.read<AuthBloc>().add(LoginEvent(email: emailController.text, password: passwordController.text));
                },
              );
            },
              listener: (BuildContext context, AuthState state) {

              if(state is LoginSuccess){
                context.push(AppRouter.root);
              }
              if(state is LoginFailure){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              }
              },),

            const SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: () {
                  context.push(AppRouter.signup);
                },
                child: const CustomText(
                  text: AppStrings.dontHaveAccount,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
