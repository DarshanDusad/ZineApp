import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../providers/data.dart';

const style = TextStyle(
  fontFamily: "Opensans",
  fontSize: 16,
  color: Colors.white,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.bold,
);

class MessageBubble extends StatelessWidget {
  final String text;
  final String name;
  final DateTime dateTime;
  final bool me;
  final Color color;
  MessageBubble({this.text, this.name, this.dateTime, this.me, this.color});
  var bold = false;
  var italic = false;
  var size = 16.0;
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

  // String getText(String text) {
  //   if (text.startsWith("##")) {
  //     text = text.substring(2, text.length);
  //     size = 24.0;
  //   } else if (text.startsWith("#")) {
  //     text = text.substring(1, text.length);
  //     size = 20.0;
  //   }
  //   text = text.trim();
  //   if (text.startsWith("**") && text.endsWith("**")) {
  //     text = text.substring(2, text.length - 2);
  //     bold = true;
  //   } else if (text.startsWith("*") & text.endsWith("*")) {
  //     text = text.substring(1, text.length - 1);
  //     italic = true;
  //   }
  //   text = text.trim();
  //   return text;
  // }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<Data>(context);

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Stack(
        overflow: Overflow.visible,
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
                    child: FittedBox(
                      child: Text(
                        DateFormat("E , d MMM").add_jm().format(dateTime),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: "Opensans",
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: me ? Colors.blue[300] : Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                child: MarkdownBody(
                  onTapLink: (text, href, title) async {
                    if (await canLaunch(href)) {
                      await launch(href);
                    }
                  },
                  styleSheetTheme: MarkdownStyleSheetBaseTheme.material,
                  styleSheet: MarkdownStyleSheet(
                      h1: style.copyWith(
                        fontSize: 20,
                      ),
                      code: style.copyWith(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                      listBullet: style,
                      h2: style.copyWith(
                        fontSize: 24,
                      ),
                      h3: style.copyWith(
                        fontSize: 28,
                      ),
                      p: style,
                      a: style.copyWith(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.italic,
                      ),
                      strong: style.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                      em: style.copyWith(
                        fontStyle: FontStyle.italic,
                      )),
                  data: text ?? "\n",
                  selectable: true,
                ),
              ),
            ],
          ),
          Positioned(
            right: 5,
            top: 30,
            child: CircleAvatar(
              radius: 18,
              backgroundColor: color,
              child: Text(
                getInitials(name == null ? "NULLLL" : name),
                style: TextStyle(
                  fontFamily: "Opensans",
                  fontSize: 12,
                  color: Colors.white,
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
