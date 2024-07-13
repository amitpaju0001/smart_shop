import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_shop/provider/api_product_provider.dart';
import 'package:smart_shop/provider/auth_api_provider.dart';
import 'package:smart_shop/screen/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return ApiProductProvider();
        },),
        ChangeNotifierProvider(create: (context) {
          return AuthApiProvider();
        },)
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:  const SignupScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

