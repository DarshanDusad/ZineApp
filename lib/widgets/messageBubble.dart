import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import '../providers/data.dart';

class MessageBubble extends StatelessWidget {
  final String text;
  final String name;
  final DateTime dateTime;
  final bool me;
  MessageBubble({
    this.text,
    this.name,
    this.dateTime,
    this.me,
  });

  String getInitials(String text) {
    String firstPart = text;
    String secondPart;
    if (text.contains(" ")) {
      firstPart = text.substring(0, text.indexOf(" "));
      secondPart = text.substring(text.indexOf(" ") + 1, text.length);

      if (secondPart.isEmpty) {
        secondPart = "A";
      }
      return firstPart[0].toUpperCase() + secondPart[0].toUpperCase();
    }
    if (firstPart.length < 2) {
      firstPart += firstPart;
    }
    return firstPart[0].toUpperCase() + firstPart[1].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<Data>(context);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    padding: EdgeInsets.all(5),
                    child: Text(
                      name == null ? "NULLLL" : name,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: "Opensans",
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    padding: EdgeInsets.all(5),
                    child: Text(
                      DateFormat("E , d MMM").add_jm().format(
                          dateTime.add(Duration(hours: 5, minutes: 30))),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: "Opensans",
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: me ? Colors.blue[200] : Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: double.infinity,
                  child: Linkify(
                    onOpen: (link) async {
                      if (await canLaunch(link.url)) {
                        await launch(link.url);
                      } else {
                        throw 'Could not launch $link';
                      }
                    },
                    linkStyle: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                    text: text == null ? " " : text,
                    style: TextStyle(
                      fontFamily: "Opensans",
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ],
          ),
          Positioned(
            right: 5,
            top: 30,
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.grey[300],
              child: Text(
                getInitials(name == null ? "NULLLL" : name),
                style: TextStyle(
                  fontFamily: "Opensans",
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
