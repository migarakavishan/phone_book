import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:phone_book/controllers/db_controller.dart';
import 'package:phone_book/models/contact_model.dart';

class ContactProvider extends ChangeNotifier {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _number = TextEditingController();
  TextEditingController get name => _name;
  TextEditingController get number => _number;

  List<Contact> _contacts = [];
  List<Contact> get contacts => _contacts;

  Future<void> addNewContact() async {
    await DBController.addContact(_name.text, _number.text);
    notifyListeners();
  }

  Future<List<Contact>> fetchContacts() async {
    _contacts = await DBController.getContacts();
    Logger().f(_contacts.length);
    return _contacts;
  }
}
