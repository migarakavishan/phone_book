import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: const Text(
          "Phone Book",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.grey.shade300,
              child: const ListTile(
                title: Text(
                  "Nimal Bandara",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle: Text("123456789"),
                leading: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Text(
                    "N",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: const Text("Add New Contact"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Card(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Contact Name"),
                        ),
                      ),
                    ),
                    const Card(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Contact Number"),
                        ),
                      ),
                    ),
                    FilledButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.green)),
                        onPressed: () {},
                        child: const Text("Save Contact"))
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
