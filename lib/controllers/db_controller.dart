import 'package:path/path.dart';
import 'package:phone_book/models/contact_model.dart';
import 'package:sqflite/sqflite.dart';

class DBController {
  static Future<Database> initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "contacts.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE Contacts(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        number TEXT)''');
      },
    );
  }

  static Future<void> addContact(String name, String number) async {
    final db = await initDB();
    await db.insert('Contacts', {'name': name, 'number': number});
  }

  static Future<List<Contact>> getContacts() async {
    final db = await initDB();
    final contactsData = await db.query("Contacts");
    List<Contact> contacts =
        contactsData.map((e) => Contact.fromMap(e)).toList();
    return contacts;
  }

  static Future<void> updateContact(Contact contact) async {
    final db = await initDB();
    db.update("Contacts", contact.toMap(),
        where: 'id = ?', whereArgs: [contact.id]);
  }

  static Future<void> deleteContact(int id) async {
    final db = await initDB();
    db.delete("Contacts", where: 'id = ?', whereArgs: [id]);
  }
}
