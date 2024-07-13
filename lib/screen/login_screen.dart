import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_shop/screen/signup_screen.dart';
import 'package:smart_shop/service/auth_api_service.dart';
import 'package:smart_shop/model/auth_model.dart';
import 'package:smart_shop/shared/widget/reuse_validator.dart';
import 'home_screen.dart';
import 'package:smart_shop/shared/string_const.dart';
import 'package:smart_shop/shared/widget/reuse_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final AuthApiService _apiService = AuthApiService();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringConst.logIn),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Icon(CupertinoIcons.home, size: 200, color: Colors.blue),
                  ),
                  const SizedBox(height: 10),
                  ReuseTextFormField(
                    controller: usernameController,
                    labelText: StringConst.usernameLabelText,
                    prefixIcon: Icons.person,
                    validator: ReuseValidator.validateUsername,
                  ),
                  const SizedBox(height: 10),
                  ReuseTextFormField(
                    controller: passwordController,
                    labelText: StringConst.passwordLabelText,
                    prefixIcon: Icons.lock,
                    isPassword: true,
                    validator: ReuseValidator.validatePassword,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            AuthModel user = AuthModel(
                              username: usernameController.text,
                              password: passwordController.text,
                            );
                            bool loggedIn = await _apiService.login(user);
                            if (loggedIn) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const HomeScreen()),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text(StringConst.signInFail)),
                              );
                            }
                          }
                        },
                        child: const Text(
                          StringConst.logIn,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        StringConst.noAccount,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SignupScreen()),
                          );
                        },
                        child: const Text(
                          StringConst.createAccount,
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
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
