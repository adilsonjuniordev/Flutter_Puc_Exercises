import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';
import './imc_controller.dart';

class ImcPage extends GetView<ImcController> {
  ImcPage({required this.titulo, Key? key}) : super(key: key);

  final String titulo;
  final _alturaEC = TextEditingController();
  final _pesoEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primarySwatch: Colors.green),
      child: Scaffold(
        appBar: AppBar(
          title: Text(titulo),
          centerTitle: true,
          actions: [IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.home))],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: Validatorless.multiple([
                        Validatorless.required("Campo obrigatório"),
                        Validatorless.number("Somente números"),
                      ]),
                      controller: _alturaEC,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        _alturaEC.text = value.replaceAll(",", ".");
                        _alturaEC.selection = TextSelection.fromPosition(TextPosition(offset: _alturaEC.text.length));
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: "Altura (mts)",
                        prefixIcon: const Icon(Icons.balance),
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
                        Validatorless.required("Campo obrigatório"),
                        Validatorless.number("Somente números"),
                      ]),
                      controller: _pesoEC,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        _pesoEC.text = value.replaceAll(",", ".");
                        _pesoEC.selection = TextSelection.fromPosition(TextPosition(offset: _pesoEC.text.length));
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: "Peso (kg)",
                        prefixIcon: const Icon(Icons.balance),
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
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          controller.imcCalc(double.parse(_alturaEC.text), double.parse(_pesoEC.text));
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text("Calcular", style: TextStyle(fontSize: 24)),
                      ),
                    ),
                    const SizedBox(height: 15),
                    InkWell(
                      child: const Text("Ver histórico", style: TextStyle(color: Colors.blue, fontSize: 18, decoration: TextDecoration.underline)),
                      onTap: () async {
                        var lista = await controller.getImcHistory();
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Histórico'),
                                content: modalTemp(lista: lista, context: context),
                              );
                            });
                      },
                    ),
                    const SizedBox(height: 80),
                    Obx(() => Text(controller.resultado.value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget modalTemp({required List lista, required BuildContext context}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: lista.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: lista.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text("${lista[index]['peso'].toString()}Kg | ${lista[index]['altura']} mts = ${lista[index]['imc']}"),
                );
              },
            )
          : const Text("Nenhum histórico para este usuário"),
    );
  }
}
