import 'package:completo/auth/auth_bindings.dart';
import 'package:completo/auth/auth_page.dart';
import 'package:completo/cadastro/cadastro_bindings.dart';
import 'package:completo/cadastro/cadastro_page.dart';
import 'package:completo/home/home_bindings.dart';
import 'package:completo/home/home_page.dart';
import 'package:completo/imc/imc_bindings.dart';
import 'package:completo/imc/imc_page.dart';
import 'package:completo/login/login_bindings.dart';
import 'package:completo/login/login_page.dart';
import 'package:completo/temp/temp_bindings.dart';
import 'package:completo/temp/temp_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Trabalho Final',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      getPages: [
        GetPage(name: "/", page: () => AuthPage(titulo: "Autenticar"), binding: AuthBindings(), children: [
          GetPage(name: "/login", page: () => LoginPage(titulo: "Login"), binding: LoginBindings()),
          GetPage(name: "/home", page: () => const HomePage(), binding: HomeBindings()),
          GetPage(name: "/cadastro", page: () => CadastroPage(titulo: "Cadastro"), binding: CadastroBindings()),
          GetPage(name: "/login", page: () => LoginPage(titulo: "Login"), binding: LoginBindings()),
          GetPage(name: "/temp", page: () => TempPage(titulo: "Conversor Temperatura"), binding: TempBindings()),
          GetPage(name: "/imc", page: () => ImcPage(titulo: "Calculadora IMC"), binding: ImcBindings()),
        ]),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
