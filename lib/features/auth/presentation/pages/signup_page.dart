import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:practice/core/navigation/app_router.dart';
import 'package:practice/features/auth/data/models/sign_up_model.dart';
import 'package:practice/features/auth/presentation/bloc/auth_event.dart';
import 'package:practice/features/auth/presentation/bloc/auth_state.dart';
import '../../../../core/utils/constants/app_strings.dart';
import '../../../../core/utils/widgets/custom_button.dart';
import '../../../../core/utils/widgets/custom_text.dart';
import '../../../../core/utils/widgets/custom_text_field.dart';
import '../bloc/auth_bloc.dart';


class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.signUp),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text: AppStrings.createAccount,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 32),
            CustomTextField(
              controller: nameController,
              label: AppStrings.name,
              hint: "Enter your full name",
            ),
            const SizedBox(height: 16),
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
            BlocConsumer<AuthBloc, AuthState>(
              builder: (BuildContext context, AuthState state) {
                return     CustomButton(
                  text: AppStrings.signUp,
                  isLoading: state is SignUpLoading ? true : false,
                  onPressed: () {
                   context.read<AuthBloc>().add(SignUpEvent(user: SignUpModel(
                       email: emailController.text,
                       password: passwordController.text,
                       userId: "1234",
                       userName: nameController.text)));
                  },
                );
              },
              listener: (BuildContext context, AuthState state) {
                if(state is SignUpSuccess){
                 GoRouter.of(context).push(AppRouter.login);
                }
              },),

            const SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: () {
                  GoRouter.of(context).push(AppRouter.login);
                },
                child: const CustomText(
                  text: AppStrings.alreadyHaveAccount,
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
