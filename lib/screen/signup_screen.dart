import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_shop/model/auth_model.dart';
import 'package:smart_shop/service/auth_api_service.dart';
import 'package:smart_shop/screen/login_screen.dart';
import 'package:smart_shop/shared/string_const.dart';
import 'package:smart_shop/shared/widget/reuse_text_form_field.dart';
import 'package:smart_shop/shared/widget/reuse_validator.dart';
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}
class _SignupScreenState extends State<SignupScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final AuthApiService _apiService = AuthApiService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringConst.signUp),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const Icon(Icons.person, size: 200, color: Colors.blue),
            const SizedBox(height: 20),
            ReuseTextFormField(
              controller: usernameController,
              labelText: StringConst.signUpName,
              prefixIcon: Icons.person,
              validator: ReuseValidator.validateUsername,
            ),
            const SizedBox(height: 10),
            ReuseTextFormField(
              controller: emailController,
              labelText: StringConst.signUpEmail,
              prefixIcon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              validator: ReuseValidator.validateEmail,
            ),
            const SizedBox(height: 10),
            ReuseTextFormField(
              controller: phoneController,
              labelText: StringConst.signUpPhone,
              prefixIcon: Icons.phone,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              validator: ReuseValidator.validatePhone,
            ),
            const SizedBox(height: 10),
            ReuseTextFormField(
              controller: passwordController,
              labelText: StringConst.signUpPassword,
              prefixIcon: Icons.lock,
              isPassword: true,
              validator: ReuseValidator.validatePassword,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (usernameController.text.isEmpty ||
                    emailController.text.isEmpty ||
                    phoneController.text.isEmpty ||
                    passwordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text(StringConst.signSnackField)),
                  );
                  return;
                }
                AuthModel user = AuthModel(
                  username: usernameController.text,
                  password: passwordController.text,
                );
                bool registered = await _apiService.registerUser(user);
                if (registered) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text(StringConst.signSnackFail)),
                  );
                }
              },
              child: const Text(StringConst.signUp),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(StringConst.signUpAlreadyAccount),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text(
                    StringConst.logIn,
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
