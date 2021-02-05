import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/data.dart';

class CustomDrawer extends StatelessWidget {
  final index;
  final onTap;
  final chats;
  CustomDrawer(this.index, this.onTap, this.chats);

  String getInitials(String text) {
    String firstPart = text;
    String secondPart;
    if (text.contains(" ")) {
      firstPart = text.substring(0, text.indexOf(" "));
      secondPart = text.substring(text.indexOf(" ") + 1, text.length);

      if (secondPart.isEmpty) {
        secondPart = "A";
      }
      if (secondPart[0] == "(") {
        secondPart = "Zine";
      }
      return firstPart[0].toUpperCase() + secondPart[0].toUpperCase();
    }
    if (firstPart.length < 2) {
      firstPart += firstPart;
    }
    return firstPart[0].toUpperCase() + firstPart[1].toUpperCase();
  }

  List<Widget> getMembers(int i, List<Room> rooms, BuildContext context) {
    if (!chats) {
      return [Container()];
    }
    //print("Length: ${rooms[i].members.length}");
    return List.generate(
      rooms[i].members.length,
      (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListTile(
            contentPadding: EdgeInsets.all(5),
            onTap: () async {
              Member member = rooms[i].members[index];
              if (member.name ==
                  Provider.of<Data>(context, listen: false).name) {
                return;
              }
              int exists =
                  rooms.indexWhere((element) => element.name == member.name);
              if (exists != -1) {
                onTap(exists);
                Navigator.of(context).pop();
              } else {
                await showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: Text(
                        "Do you want to start a private conversation with ${member.name} ?",
                        style: TextStyle(
                          fontFamily: "OpenSans",
                          fontSize: 14,
                        ),
                      ),
                      actions: [
                        FlatButton(
                          child: Text(
                            "YES",
                            style: TextStyle(
                                fontFamily: "OpenSans", color: Colors.blue),
                          ),
                          onPressed: () async {
                            await Provider.of<Data>(context, listen: false)
                                .getDMroom(member);
                            int i = rooms.indexWhere(
                                (element) => element.name == member.name);
                            onTap(i);
                            Navigator.of(context).pop();
                          },
                        ),
                        FlatButton(
                          child: Text(
                            "NO",
                            style: TextStyle(
                                fontFamily: "OpenSans", color: Colors.blue),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
                Navigator.of(context).pop();
              }
            },
            leading: CircleAvatar(
              radius: 22,
              backgroundColor: rooms[i].members[index].color,
              child: Text(
                getInitials(rooms[i].members[index].name),
                style: TextStyle(
                  fontFamily: "OpenSans",
                  color: Colors.white,
                ),
              ),
            ),
            title: Text(
              rooms[i].members[index].name,
              style: TextStyle(
                fontFamily: "OpenSans",
                fontSize: 16,
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> getRooms(List<Room> rooms, context) {
    var colors = {
      "Algo Pseudo": Colors.green,
      "BME": Colors.pink,
      "IC MCU and Sensors": Colors.blue,
      "BEE": Colors.purple,
      "Aeromodelling": Colors.amber[700],
      "Workshop 2020": Colors.brown,
      "Help": Colors.red[400],
      "Admin Only": Colors.teal,
    };
    print("No of rooms:" + rooms.length.toString());

    return List.generate(rooms.length, (i) {
      //print(i.toString() + " : " + rooms[i].id);
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: ListTile(
          onTap: () {
            onTap(i);
            Navigator.of(context).pop();
          },
          contentPadding: EdgeInsets.all(5),
          leading: CircleAvatar(
            radius: 22,
            backgroundColor: rooms[i].color,
            child: Text(
              getInitials(rooms[i].name),
              style: TextStyle(
                fontFamily: "OpenSans",
                color: Colors.white,
              ),
            ),
          ),
          title: Text(
            rooms[i].name,
            style: TextStyle(
              fontFamily: "OpenSans",
              fontSize: 16,
            ),
          ),
        ),
      );
    }, growable: true);
  }

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    var provider = Provider.of<Data>(context, listen: false);
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 5),
            height: 40,
            alignment: Alignment.center,
            child: FittedBox(
              child: Text(
                "Rooms",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: "OpenSans",
                  color: Colors.white,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue[400],
            ),
          ),
          ...getRooms(provider.rooms, context),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            height: 40,
            alignment: Alignment.center,
            child: FittedBox(
              child: Text(
                "Members",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: "OpenSans",
                  color: Colors.white,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue[400],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ...getMembers(index, provider.rooms, context),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
