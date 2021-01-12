import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
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
  @override
  void initState() {
    super.initState();
    Provider.of<Data>(context, listen: false).sort();
    Provider.of<Data>(context, listen: false).init();
    // print("HII:" +
    //     Provider.of<Data>(context, listen: false).rooms.length.toString());
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  void onTap(int index) {
    setState(() {
      roomIndex = index;
    });
    controller.animateTo(
      0,
      duration: Duration(milliseconds: 100),
      curve: Curves.linear,
    );
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
          child: CustomDrawer(roomIndex, onTap),
        ),
        body: Stack(
          children: [
            TopBar(
              focusNode: focusNode,
              title: provider.rooms[roomIndex].name,
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
                        focusNode: focusNode,
                        onSaved: (input) {},
                        style: TextStyle(
                            fontFamily: "OpenSans",
                            fontSize: 14,
                            color: Colors.black.withOpacity(.65)),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 4.0),
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
                    IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        focusNode.unfocus();
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
  const TopBar({
    Key key,
    this.focusNode,
    this.title,
  }) : super(key: key);

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
                padding: const EdgeInsets.only(left: 25, top: 20, bottom: 10),
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
          Padding(
            padding: const EdgeInsets.only(left: 80.0, right: 40),
            child: FittedBox(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: "OpenSans",
                  color: Colors.white,
                ),
              ),
            ),
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
