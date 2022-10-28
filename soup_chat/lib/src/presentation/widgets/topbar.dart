import 'package:flutter/material.dart';

class TopBar extends StatefulWidget implements PreferredSizeWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TopBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(400, 60);
}

class TopBarState extends State<TopBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: null,
      backgroundColor: Colors.transparent,
      flexibleSpace: Row(
        children: [
          const VerticalDivider(width: 10, color: Colors.transparent),
          SizedBox(
            width: 60,
            child: Column(
              children: [
                const Divider(height: 10, color: Colors.transparent),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ],
            ),
          ),
          const VerticalDivider(width: 15, color: Colors.transparent),
          Column(
            children: const [
               Divider(height: 15, color: Colors.transparent),
               Icon(IconData(0xe3c7, fontFamily: 'MaterialIcons'), size: 40,),
            ],
          ),
        ],
      ),
    );
  }
}
