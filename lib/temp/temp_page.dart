import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';
import './temp_controller.dart';

class TempPage extends GetView<TempController> {
  TempPage({required this.titulo, Key? key}) : super(key: key);

  final String titulo;
  final _tempEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primarySwatch: Colors.red),
      child: Scaffold(
        appBar: AppBar(
          title: Text(titulo),
          centerTitle: true,
          actions: [IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.home))],
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: SingleChildScrollView(
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
                        controller: _tempEC,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          _tempEC.text = value.replaceAll(",", ".");
                          controller.medidaFinal.value = "";
                          _tempEC.selection = TextSelection.fromPosition(TextPosition(offset: _tempEC.text.length));
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          labelText: "Temperatura (Celsius)",
                          prefixIcon: const Icon(Icons.thermostat),
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: ElevatedButton(
                          onPressed: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            return _formKey.currentState!.validate() ? controller.tempCalc(double.parse(_tempEC.text), "kelvin") : null;
                          },
                          child: const Padding(padding: EdgeInsets.all(4), child: Text("Kelvin", style: TextStyle(fontSize: 18))),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: ElevatedButton(
                          onPressed: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            return _formKey.currentState!.validate() ? controller.tempCalc(double.parse(_tempEC.text), "fahrenheit") : null;
                          },
                          child: const Padding(padding: EdgeInsets.all(4), child: Text("Fahrenheit", style: TextStyle(fontSize: 18))),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: ElevatedButton(
                          onPressed: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            return _formKey.currentState!.validate() ? controller.tempCalc(double.parse(_tempEC.text), "rankine") : null;
                          },
                          child: const Padding(padding: EdgeInsets.all(4), child: Text("Rankine", style: TextStyle(fontSize: 18))),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: ElevatedButton(
                          onPressed: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            return _formKey.currentState!.validate() ? controller.tempCalc(double.parse(_tempEC.text), "reaumur") : null;
                          },
                          child: const Padding(padding: EdgeInsets.all(4), child: Text("Reaumur", style: TextStyle(fontSize: 18))),
                        ),
                      ),
                      const SizedBox(height: 15),
                      InkWell(
                        child: const Text("Ver histórico", style: TextStyle(color: Colors.blue, fontSize: 18, decoration: TextDecoration.underline)),
                        onTap: () async {
                          var lista = await controller.getTempHistory();
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
                      const SizedBox(height: 30),
                      Obx(() {
                        return (controller.medidaFinal.value != "")
                            ? Column(
                                children: [
                                  Text("O resultado em ${controller.medidaFinal.value} é:", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.all(Radius.circular(30)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Text(
                                        "${controller.tempFinal.value}",
                                        style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox();
                      }),
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

  Widget modalTemp({required List lista, required BuildContext context}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: lista.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: lista.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text("${lista[index]['celsius'].toString()} Celsius = ${lista[index]['valor']} ${lista[index]['tipo'].toString().capitalizeFirst}"),
                );
              },
            )
          : const Text("Nenhum histórico para este usuário"),
    );
  }
}
