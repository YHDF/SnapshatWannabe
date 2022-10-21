import 'package:flutter/material.dart';
import 'package:soup_chat/src/presentation/shared/utils/device_dimensions.dart';

class ContactCard extends StatefulWidget{

  final String contact;

  const ContactCard(this.contact);
  @override
  State<StatefulWidget> createState() => ContactCardState(contact);
}

class ContactCardState extends State<ContactCard> {

  ContactCardState(String contact);

  double? width;
  double? height;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = DeviceDimension(context).devWidth;
    height = DeviceDimension(context).devHeight;
    return SizedBox(
      height: height! / 8,
      child: Row(
        children: [
          const VerticalDivider(width: 10, color: Colors.transparent),
          Image.network("https://cdn3.iconfinder.com/data/icons/popular-services-brands/512/snapchat-2-512.png",
              width: width! / 5,
              fit: BoxFit.cover),
          VerticalDivider(width: width! / 10, color: Colors.transparent),
          Column(
            children: [
              Container(
                width: 3 * width! / 5 ,
                height: height! / 8,
                child: Align(
                    alignment: Alignment(-1, 0),
                  child: Text(widget.contact),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
