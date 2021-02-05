import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import '../widgets/messageBubble.dart';
import '../widgets/drawer.dart';
import '../providers/data.dart';

class ChatScreen extends StatefulWidget {
  static const route = "/chat";

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var controller = ScrollController(keepScrollOffset: true);
  var roomIndex = 0;
  var focusNode = FocusNode();
  var textController = TextEditingController();
  var chats = false;
  var loading = false;
  @override
  void initState() {
    super.initState();
    var provider = Provider.of<Data>(context, listen: false);
    provider.sort();
  }

  void onTap(int index) {
    setState(() {
      roomIndex = index;
      chats = true;
      loading = true;
    });
    Provider.of<Data>(context, listen: false).changeRoom(index).then((value) {
      setState(() {
        loading = false;
      });
    });
    if (!chats) {
      return;
    }
  }

  List<Widget> getMessages(int index, List<Room> rooms, String name) {
    if (rooms[index].messages.isEmpty) {
      return [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Image.asset("assets/images/Splash.gif"),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            "It's empty here. Start chatting !",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "OpenSans",
              fontSize: 18,
            ),
          ),
        ),
      ];
    }
    return List.from(
      List.generate(rooms[index].messages.length, (i) {
        var message = rooms[index].messages[i];
        return MessageBubble(
          text: message.text,
          name: message.sender.name,
          dateTime: message.dateTime,
          me: message.sender.name == name,
          color: message.sender.color,
        );
      }).reversed,
    );
  }

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    var size = MediaQuery.of(context).size;
    var media = MediaQuery.of(context);
    var provider = Provider.of<Data>(context);

    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: CustomDrawer(roomIndex, onTap, chats),
        ),
        body: Stack(
          children: [
            TopBar(
              focusNode: focusNode,
              title: !chats ? "Chats" : provider.rooms[roomIndex].name,
              onTap: onTap,
            ),
            Positioned(
              top: 130,
              child: Container(
                padding: EdgeInsets.only(bottom: 230),
                height: size.height - media.viewInsets.bottom,
                width: size.width,
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(80),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                      ),
                      if (loading)
                        SizedBox(
                          height: 200,
                        ),
                      if (loading) Center(child: CircularProgressIndicator()),
                      if (!chats && !loading) ...[
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Image.asset("assets/images/Splash.gif"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "Welcome to Zine Communication Channel ! Click a room on the left to chat.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "OpenSans",
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                      if (chats && !loading)
                        Expanded(
                          child: ListView(
                            reverse: true,
                            controller: controller,
                            shrinkWrap: true,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              ...getMessages(
                                roomIndex,
                                provider.rooms,
                                provider.name,
                              ),
                              SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            if (chats && !loading)
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  width: size.width,
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          minLines: 1,
                          maxLines: 3,
                          keyboardType: TextInputType.multiline,
                          onFieldSubmitted: (_) {
                            focusNode.unfocus();
                          },
                          controller: textController,
                          focusNode: focusNode,
                          style: TextStyle(
                              fontFamily: "OpenSans",
                              fontSize: 14,
                              color: Colors.black.withOpacity(.65)),
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 4.0),
                              hintText: "What's on your mind....",
                              hintStyle: TextStyle(
                                  fontFamily: "OpenSans",
                                  color: Colors.grey[700],
                                  fontSize: 15),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 1.5,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Icon(
                                Icons.message,
                                size: 25,
                              )),
                        ),
                      ),
                      if (chats && !loading)
                        IconButton(
                          icon: Icon(
                            Icons.send,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            focusNode.unfocus();
                            textController.text = textController.text.trim();
                            if (textController.text == "" ||
                                textController.text.isEmpty ||
                                !provider.initDone) {
                              return;
                            }
                            provider.socketIO.sendMessage(
                                'message',
                                json.encode({
                                  'senderId': provider.uid,
                                  'content': textController.text,
                                  'createdAt': DateTime.now().toIso8601String(),
                                  'senderName': provider.name
                                }), () {
                              print("Sent!!");
                            });
                            textController.text = "";
                          },
                        )
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  final FocusNode focusNode;
  final String title;
  final Function onTap;
  const TopBar({Key key, this.focusNode, this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 15, bottom: 10),
                child: IconButton(
                  icon: Icon(
                    Icons.menu,
                    size: 25,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    focusNode.unfocus();
                    FocusScope.of(context).unfocus();
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
              Spacer(),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "BACK",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: title != "Chats" ? 100.0 : 60.0, right: 40),
                child: FittedBox(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: title == "Chats" ? 30 : 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: "OpenSans",
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              if (title != "Chats")
                IconButton(
                  icon: Icon(
                    Icons.refresh,
                    size: 20,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    int index =
                        Provider.of<Data>(context, listen: false).currentRoom;
                    onTap(index);
                  },
                ),
            ],
          ),
        ],
      ),
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue[900],
            Colors.blue[800],
            if (orientation != Orientation.portrait) Colors.blue[800],
            if (orientation != Orientation.portrait) Colors.blue[800],
            if (orientation != Orientation.portrait) Colors.blue[800],
            if (orientation != Orientation.portrait) Colors.blue[800],
            Colors.blue,
            Colors.blue,
            Colors.blue,
            Colors.blue[200],
            Colors.blue[200],
            Colors.blue[50],
          ],
        ),
      ),
    );
  }
}
