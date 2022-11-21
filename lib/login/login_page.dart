import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';
import './login_controller.dart';

class LoginPage extends GetView<LoginController> {
  LoginPage({required this.titulo, Key? key}) : super(key: key);

  final String titulo;
  final _emailEC = TextEditingController();
  final _senhaEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primarySwatch: Colors.orange),
      child: Scaffold(
        appBar: AppBar(
          title: Text(titulo),
          centerTitle: true,
          actions: [IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.home))],
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.grey,
                    Colors.white,
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Image.network("https://www.pucminas.br/pos/letras/noticias/PublishingImages/Paginas/COMUNICADO/Brasao%20PUC%20Minas%20aplicacao_cinza.png",
                          width: MediaQuery.of(context).size.width * 0.3),
                      const SizedBox(height: 10),
                      const Text("Login", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, decoration: TextDecoration.underline)),
                      const SizedBox(height: 20),
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
                          Validatorless.min(8, "Mínimo 8 caracteres."),
                        ]),
                        controller: _senhaEC,
                        keyboardType: TextInputType.text,
                        obscureText: true,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          InkWell(
                              child: Text(
                            "Esqueci minha senha",
                            style: TextStyle(decoration: TextDecoration.underline),
                          ))
                        ],
                      ),
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: controller.keepConnected.value,
                              onChanged: (val) => controller.keepConnected.value = val!,
                            ),
                            const Text("Manter conectado"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: ElevatedButton(
                          onPressed: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            if (_formKey.currentState!.validate()) {
                              var result = await controller.login(email: _emailEC.text.removeAllWhitespace, senha: _senhaEC.text);

                              if (result) {
                                Get.snackbar(
                                  "Sucesso",
                                  "Login encontrado no banco! :)",
                                  backgroundColor: Colors.green,
                                  snackStyle: SnackStyle.FLOATING,
                                  snackPosition: SnackPosition.BOTTOM,
                                  margin: const EdgeInsets.all(20),
                                );
                              } else {
                                Get.snackbar(
                                  "Ops",
                                  "Login não encontrado no banco! :(",
                                  backgroundColor: Colors.red,
                                  snackStyle: SnackStyle.FLOATING,
                                  snackPosition: SnackPosition.BOTTOM,
                                  margin: const EdgeInsets.all(20),
                                );
                              }
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
                            Get.snackbar(
                              "Atenção",
                              "Vá para a tela de cadastro",
                              backgroundColor: Colors.grey,
                              snackStyle: SnackStyle.FLOATING,
                              snackPosition: SnackPosition.BOTTOM,
                              margin: const EdgeInsets.all(20),
                            );
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
