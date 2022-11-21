import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';
import './cadastro_controller.dart';

class CadastroPage extends GetView<CadastroController> {
  CadastroPage({required this.titulo, Key? key}) : super(key: key);

  final String titulo;
  final _nomeEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _senhaEC = TextEditingController();
  final _confirmaSenhaEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primarySwatch: Colors.blue),
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
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.blue.withAlpha(130),
                    Colors.white,
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: Form(
                  key: _formKey,
                  child: Obx(
                    () => Column(
                      children: [
                        Image.network("https://www.pucminas.br/pos/letras/noticias/PublishingImages/Paginas/COMUNICADO/Brasao%20PUC%20Minas%20aplicacao_cinza.png",
                            width: MediaQuery.of(context).size.width * 0.3),
                        const SizedBox(height: 10),
                        const Text("Cadastro", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, decoration: TextDecoration.underline)),
                        const SizedBox(height: 20),
                        TextFormField(
                          validator: Validatorless.required("Nome obrigatório"),
                          controller: _nomeEC,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            isDense: true,
                            labelText: "Nome Completo",
                            prefixIcon: const Icon(Icons.person),
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
                          obscureText: !controller.showPassword.value,
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
                        const SizedBox(height: 20),
                        TextFormField(
                          validator: Validatorless.multiple([
                            Validatorless.required("Senha obrigatória"),
                            Validatorless.min(8, "Mínimo 8 caracteres."),
                            Validatorless.compare(_senhaEC, "Senhas não correspondem."),
                          ]),
                          controller: _confirmaSenhaEC,
                          keyboardType: TextInputType.text,
                          obscureText: !controller.showPassword.value,
                          decoration: InputDecoration(
                            isDense: true,
                            labelText: "Confirma Senha",
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: controller.showPassword.value,
                              onChanged: (val) => controller.showPassword.value = val!,
                            ),
                            const Text("Mostrar senha"),
                          ],
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: ElevatedButton(
                            onPressed: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              if (_formKey.currentState!.validate()) {
                                try {
                                  var result = await controller.cadastro(nome: _nomeEC.text, email: _emailEC.text, senha: _senhaEC.text);
                                  if (result) {
                                    Get.back();
                                    Get.snackbar(
                                      "Sucesso",
                                      "Cadastro salvo no banco! :)",
                                      backgroundColor: Colors.green,
                                      snackStyle: SnackStyle.FLOATING,
                                      snackPosition: SnackPosition.BOTTOM,
                                      margin: const EdgeInsets.all(20),
                                    );
                                  }
                                } catch (e) {
                                  Get.snackbar(
                                    "Erro",
                                    "Houve um erro ao cadastrar no banco! :(",
                                    backgroundColor: Colors.red,
                                    snackStyle: SnackStyle.FLOATING,
                                    snackPosition: SnackPosition.BOTTOM,
                                    margin: const EdgeInsets.all(20),
                                  );
                                }
                              }
                            },
                            child: const Padding(padding: EdgeInsets.all(4), child: Text("Criar Conta", style: TextStyle(fontSize: 18))),
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
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
