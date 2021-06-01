import 'package:ecommerce_admin_tut/helpers/app_colors.dart';
import 'package:ecommerce_admin_tut/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationTabletDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.grey[200], offset: Offset(3, 5), blurRadius: 17)
      ]),
      height: 50,
      child: Row(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {},
              ),
              SizedBox(
                width: 20,
              ),
              SizedBox(
                width: 20,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundImage: AssetImage('images/profile.jpg'),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  CustomText(
                    text: 'Admin',
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget myPopMenu() {
    return PopupMenuButton(
        onSelected: (value) {},
        itemBuilder: (context) => [
              PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                        child: Icon(Icons.print),
                      ),
                      Text('Print')
                    ],
                  )),
              PopupMenuItem(
                  value: 2,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                        child: Icon(Icons.share),
                      ),
                      Text('Share')
                    ],
                  )),
              PopupMenuItem(
                  value: 3,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                        child: Icon(Icons.add_circle),
                      ),
                      Text('Add')
                    ],
                  )),
            ]);
  }
}
