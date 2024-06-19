import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'contact.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreen();
}

class _ContactsScreen extends State<ContactsScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  PhoneNumber number = PhoneNumber(isoCode: 'PY');

  List<Contact> contacts = [];
  late String phone;

  bool isPhoneValid = false;
  bool isNameValid = false;

  int? indexEdit;

  @override
  void initState() {
    super.initState();
    loadContacts();
  }

  Future<void> loadContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final String? contactsJson = prefs.getString('contacts');
    if (contactsJson != null) {
      setState(() {
        contacts = (jsonDecode(contactsJson) as List)
            .map((data) => Contact.fromJson(data as Map<String, dynamic>))
            .toList();
      });
    }
  }

  Future<void> saveContacts() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('contacts',
        jsonEncode(contacts.map((contact) => contact.toJson()).toList()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Contacts"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              onChanged: (value) {
                setState(() {
                  isNameValid = value.trim().isNotEmpty;
                });
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person),
                hintText: 'Nombre del contacto',
                filled: true,
                fillColor: Colors.grey[200],
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) {
                phone = number.phoneNumber!;
              },
              onInputValidated: (bool value) {
                setState(() {
                  isPhoneValid = value;
                });
              },
              selectorConfig: const SelectorConfig(
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
              ),
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.disabled,
              selectorTextStyle: const TextStyle(color: Colors.black),
              initialValue: number,
              textFieldController: phoneController,
              formatInput: true,
              inputDecoration: InputDecoration(
                hintText: 'Número del contacto',
                filled: true,
                fillColor: Colors.grey[200],
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              ),
              keyboardType: const TextInputType.numberWithOptions(
                signed: true,
                decimal: true,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FilledButton(
                  onPressed: isPhoneValid && isNameValid
                      ? () {
                          final String name = nameController.text;

                          setState(() {
                            if (indexEdit == null) {
                              contacts.add(Contact(name: name, phone: phone));
                            } else {
                              contacts[indexEdit!] =
                                  Contact(name: name, phone: phone);
                            }
                            saveContacts();

                            nameController.clear();
                            phoneController.clear();
                            isPhoneValid = false;
                            isNameValid = false;
                            indexEdit = null;
                          });
                        }
                      : null,
                  child: const Text('Guardar / Actualizar'),
                ),
                FilledButton.tonal(
                  onPressed: () {
                    setState(() {
                      nameController.clear();
                      phoneController.clear();
                      isPhoneValid = false;
                      isNameValid = false;
                      indexEdit = null;
                    });
                  },
                  child: const Text('Cancelar'),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Expanded(
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  return myListTile(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget myListTile(int index) {
    final contact = contacts[index];
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              Colors.primaries[contact.name.length % Colors.primaries.length],
          child: Text(contact.name[0].toUpperCase()),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(contact.name),
            Text(contact.phone, style: TextStyle(color: Colors.grey[700]))
          ],
        ),
        trailing: SizedBox(
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () async {
                  nameController.text = contact.name;
                  phoneController.text = contact.phone;

                  indexEdit = index;

                  number = await PhoneNumber.getRegionInfoFromPhoneNumber(
                      contact.phone);
                  setState(() {});
                },
                child: const Icon(Icons.edit),
              ),
              InkWell(
                  onTap: () {
                    setState(() {
                      contacts.removeAt(index);
                      saveContacts();
                    });
                  },
                  child: const Icon(Icons.remove_circle_outline_outlined))
            ],
          ),
        ),
      ),
    );
  }
}
