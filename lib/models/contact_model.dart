class Contact {
  int id;
  String name;
  String number;

  Contact({required this.id, required this.name, required this.number});

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(id: map['id'], name: map['name'], number: map['number']);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'number': number};
  }
}
