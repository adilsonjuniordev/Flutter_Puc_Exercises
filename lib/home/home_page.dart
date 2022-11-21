import 'package:completo/my_button.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          title: const Text('Adriana Torres', style: TextStyle(fontWeight: FontWeight.bold)),
          actions: const [CircleAvatar(radius: 32, backgroundImage: NetworkImage("https://wl-incrivel.cf.tsp.li/resize/728x/jpg/0ec/140/d189845022bb6eddb88bb5279a.jpg")), SizedBox(width: 20)],
          toolbarHeight: 100,
          elevation: 12,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.blueGrey.withAlpha(110)),
        child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(30),
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          crossAxisCount: 2,
          children: const <Widget>[
            MyButton(route: "/imc", text: "Atividade 1"),
            MyButton(route: "/temp", text: "Atividade 2"),
            MyButton(route: "/cadastro", text: "Atividade 3"),
            MyButton(route: "/login", text: "Atividade 4"),
          ],
        ),
      ),
    );
  }
}
