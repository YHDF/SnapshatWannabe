import 'package:flutter/material.dart';
import 'package:soup_chat/src/presentation/widgets/contactcard.dart';

class ChatContact extends StatefulWidget{
  const ChatContact({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ChatContactState();
}


class ChatContactState extends State<ChatContact> {
  @override
  void initState() {
    super.initState();
    //TODO remove after adding code to loadContacts()
    populateContacts();
  }

  List<String> contacts = <String>["d"];

  List<String> loadContacts() {
    //TODO supply contacts info from datastore
    /** code **/
    return contacts;
  }

  void populateContacts() {
     contacts = List.filled(4, "name");
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(
          height: 10,
          color: Colors.transparent,

        ),
        //itemCount: contacts.length ?? 0,
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return ContactCard(contacts[0]);
        });
  }
}
