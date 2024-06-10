import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:phone_book/controllers/call_service.dart';
import 'package:phone_book/providers/contact_provider.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Color> colors = [
    Colors.orange,
    Colors.green,
    Colors.brown,
    Colors.red,
    Colors.blue,
    Colors.purple,
    Colors.cyan,
    Colors.pink,
    Colors.black,
    Colors.lime
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<ContactProvider>(builder: (context, value, child) {
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
          child: FutureBuilder(
              future: value.fetchContacts(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Something went wrong"),
                  );
                }
                if (snapshot.hasData) {
                  final contacts = snapshot.data;
                  return ListView.builder(
                    itemCount: contacts!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.grey.shade300,
                        child: ListTile(
                          title: Text(
                            contacts[index].name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(contacts[index].number),
                          leading: CircleAvatar(
                            backgroundColor:
                                colors[int.parse(index.toString()[0])],
                            child: Text(
                              contacts[index].name[0],
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    CallService()
                                        .startCall(contacts[index].number);
                                  },
                                  icon: const Icon(Icons.call)),
                              IconButton(
                                  onPressed: () {
                                    value.setTextFields(contacts[index]);
                                    showContactDetails(context, value,
                                        id: contacts[index].id, isUpdate: true);
                                  },
                                  icon: const Icon(Icons.edit)),
                              IconButton(
                                  onPressed: () {
                                    value.deleteContact(contacts[index].id);
                                  },
                                  icon: const Icon(Icons.delete)),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                return const SizedBox();
              }),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            showContactDetails(context, value);
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      );
    });
  }
}

Future<dynamic> showContactDetails(BuildContext context, ContactProvider value,
    {bool isUpdate = false, int? id}) {
  return showDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text(!isUpdate ? "Add New Contact" : "Update Contact"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: TextField(
                  controller: value.name,
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: "Contact Name"),
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: TextField(
                  controller: value.number,
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: "Contact Number"),
                ),
              ),
            ),
            FilledButton(
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.green)),
                onPressed: () {
                  if (value.name.text.isNotEmpty &&
                      value.number.text.isNotEmpty) {
                    if (isUpdate) {
                      value.startUpdate(id!).then((value) {
                        Navigator.pop(context);
                      });
                    } else {
                      value.addNewContact().then((value) {
                        Navigator.pop(context);
                      });
                    }
                  } else {
                    Logger().e("Please insert contact details");
                  }
                },
                child: Text(!isUpdate ? "Save Contact" : "Update"))
          ],
        ),
      );
    },
  );
}
