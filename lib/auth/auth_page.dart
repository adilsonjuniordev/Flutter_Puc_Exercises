import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';
import './auth_controller.dart';

class AuthPage extends GetView<AuthController> {
  AuthPage({required this.titulo, Key? key}) : super(key: key);

  final String titulo;
  final _emailEC = TextEditingController();
  final _senhaEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blue.withAlpha(60),
                    Colors.blue.withAlpha(120),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Icon(Icons.logo_dev, size: 140, color: Colors.red),
                      const SizedBox(height: 30),
                      TextFormField(
                        validator: Validatorless.multiple([
                          Validatorless.required("Email obrigatório"),
                          Validatorless.email("Email inválido"),
                        ]),
                        controller: _emailEC,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          isDense: true,
                          labelText: "Email",
                          prefixIcon: const Icon(Icons.email),
                          prefixIconColor: Colors.black,
                          labelStyle: const TextStyle(fontSize: 15, color: Colors.black),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        validator: Validatorless.multiple([
                          Validatorless.required("Senha obrigatória"),
                        ]),
                        controller: _senhaEC,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        onChanged: (value) => controller.strongPassCalc(value),
                        decoration: InputDecoration(
                          isDense: true,
                          labelText: "Senha",
                          prefixIcon: const Icon(Icons.password),
                          prefixIconColor: Colors.black,
                          labelStyle: const TextStyle(fontSize: 15, color: Colors.black),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Obx(() => Text(
                            controller.strongPass.value,
                            style: TextStyle(
                              color: controller.color.value,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: ElevatedButton(
                          onPressed: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            if (_formKey.currentState!.validate()) {
                              controller.login(_emailEC.text, _senhaEC.text);
                            }
                          },
                          child: const Padding(padding: EdgeInsets.all(4), child: Text("Login", style: TextStyle(fontSize: 18))),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Divider(thickness: 2),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: ElevatedButton(
                          onPressed: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            if (_formKey.currentState!.validate()) {
                              Get.snackbar(
                                "Sucesso",
                                "Cadastro clicado! :)",
                                backgroundColor: Colors.green,
                                snackStyle: SnackStyle.FLOATING,
                                snackPosition: SnackPosition.BOTTOM,
                                margin: const EdgeInsets.all(20),
                              );
                            }
                          },
                          child: const Padding(padding: EdgeInsets.all(4), child: Text("Cadastre-se", style: TextStyle(fontSize: 18))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
