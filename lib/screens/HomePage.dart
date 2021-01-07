import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../screens/InfoScreen.dart';
import '../screens/TeamScreen.dart';
import '../screens/AchievementPage.dart';
import '../screens/ProjectScreen.dart';
import '../screens/AuthScreen.dart';
import '../providers/data.dart';

const instaUrl = "https://www.instagram.com/zine.robotics/";
const facebookUrl = "https://www.facebook.com/ROBOTICS.ZINE";
const siteUrl = "http://zine.co.in/";

class HomePage extends StatefulWidget {
  static const route = "/home";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 2;
  ScrollController controller;
  void _selectedTab(int index) {
    setState(() {
      currentIndex = index;
      print(currentIndex);
    });
  }

  Widget buildFAB(double topSize, Orientation orientation) {
    final double defaultTopMargin = topSize;
    //pixels from top where scaling should start
    final double scaleStart = 96.0;
    //pixels from top where scaling should end
    final double scaleEnd = scaleStart / 2;

    double top = defaultTopMargin;
    double scale = 1.0;
    if (controller.hasClients) {
      double offset = controller.offset;
      top -= offset;
      if (offset < defaultTopMargin - scaleStart) {
        //offset small => don't scale down
        scale = 1.0;
      } else if (offset < defaultTopMargin - scaleEnd) {
        //offset between scaleStart and scaleEnd => scale down
        scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
      } else {
        //offset passed scaleEnd => hide fab
        scale = 0.0;
      }
    }
    if (orientation == Orientation.portrait) {
      return new Positioned(
        top: top,
        right: 20.0,
        child: new Transform(
          transform: new Matrix4.identity()..scale(scale),
          alignment: Alignment.center,
          child: Container(
            child: new FloatingActionButton(
              heroTag: "ABCD",
              child: Icon(
                Icons.info,
                size: 36,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(InfoScreen.route);
              },
            ),
          ),
        ),
      );
    }
    return new Positioned(
      top: top,
      right: 20.0,
      child: new Transform(
        transform: Matrix4.identity()..scale(scale),
        alignment: Alignment.center,
        child: Container(
          height: 100,
          width: 100,
          child: new FloatingActionButton(
            heroTag: "A",
            child: Icon(
              Icons.info,
              size: orientation == Orientation.portrait ? 36 : 50,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(InfoScreen.route);
            },
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    controller = new ScrollController();
    controller.addListener(() => setState(() {}));
    SharedPreferences.getInstance().then(
      (ref) {
        Provider.of<Data>(context, listen: false).addData(
          ref.getString("token"),
          ref.getString("name"),
          ref.getString("email"),
          ref.getString("domain"),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.removeListener(() => setState(() {}));
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Data>(context);
    var size = MediaQuery.of(context).size;
    var orientation = MediaQuery.of(context).orientation;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        floatingActionButton: FloatingActionButton(
          heroTag: "B",
          child: Icon(
            Icons.home,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            setState(() {
              currentIndex = 4;
            });

            print(4);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: FABBottomAppBar(
          onTabSelected: _selectedTab,
          items: [
            FABBottomAppBarItem(
                icon: Icon(
                  Icons.person,
                  color: Colors.grey,
                  size: 30,
                ),
                text: 'Profile'),
            FABBottomAppBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.question,
                  color: Colors.grey,
                  size: 30,
                ),
                text: 'FAQs'),
            FABBottomAppBarItem(
                icon: Icon(
                  Icons.phone,
                  color: Colors.grey,
                  size: 30,
                ),
                text: 'Contact Us'),
            FABBottomAppBarItem(
                icon: Icon(
                  Icons.question_answer,
                  color: Colors.grey,
                  size: 30,
                ),
                text: 'Channel'),
          ],
        ),
        body: Stack(
          children: [
            CustomScrollView(
              controller: controller,
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.blue[600],
                  actions: [
                    IconButton(
                      icon: Icon(
                        EvaIcons.facebook,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () async {
                        var ref = await SharedPreferences.getInstance();
                        ref.clear();
                        Provider.of<Data>(context, listen: false).clear();
                        Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(builder: (ctx) {
                          return FutureBuilder(
                              future: SharedPreferences.getInstance().then(
                                (value) => value.getString("token"),
                              ),
                              builder: (ctx, snap) {
                                if (snap.connectionState ==
                                    ConnectionState.waiting) {
                                  return Scaffold(
                                    body: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                                if (snap.hasData) {
                                  return HomePage();
                                }
                                return AuthScreen();
                              });
                        }));
                        // if (await canLaunch(facebookUrl)) {
                        //   await launch(
                        //     facebookUrl,
                        //     forceWebView: false,
                        //   );
                        // }
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        IconData(
                          0xf16d,
                          fontFamily: "Insta",
                          fontPackage: null,
                        ),
                        size: 30,
                      ),
                      color: Colors.white,
                      onPressed: () async {
                        if (await canLaunch(instaUrl)) {
                          await launch(
                            instaUrl,
                            forceWebView: false,
                          );
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        EvaIcons.globeOutline,
                        size: 30,
                      ),
                      color: Colors.white,
                      onPressed: () async {
                        if (await canLaunch(siteUrl)) {
                          await launch(
                            siteUrl,
                            forceWebView: false,
                          );
                        }
                      },
                    ),
                  ],
                  automaticallyImplyLeading: false,
                  pinned: true,
                  expandedHeight: size.height * 0.25,
                  flexibleSpace: LayoutBuilder(builder: (context, constraints) {
                    var top = constraints.biggest.height;
                    return FlexibleSpaceBar(
                      titlePadding: EdgeInsets.only(
                        left: 40,
                        bottom: 10,
                      ),
                      title: Container(
                        padding: top > 80.0
                            ? EdgeInsets.only(bottom: 30, top: 10)
                            : EdgeInsets.only(top: 5),
                        child: Hero(
                          tag: "h",
                          child: Text(
                            "ZINE",
                            style: TextStyle(
                              fontSize:
                                  orientation == Orientation.portrait ? 30 : 20,
                              fontFamily: "Megatron",
                            ),
                          ),
                        ),
                      ),
                      background: Container(
                          decoration: BoxDecoration(
                              gradient: RadialGradient(
                                  focal: Alignment.topLeft,
                                  center: Alignment.topLeft,
                                  radius: orientation == Orientation.portrait
                                      ? 3.5
                                      : 13,
                                  colors: [
                                Colors.blue[900],
                                Colors.blue[900],
                                Colors.blue[800],
                                Colors.blue,
                                Colors.blue[200],
                                Colors.blue[200],
                                Colors.blue[50],
                              ])),
                          padding: EdgeInsets.all(20),
                          alignment: Alignment.bottomLeft,
                          child: FittedBox(
                            child: Text(
                              "Robotics and Research Group",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white60,
                                fontFamily: "OpenSans",
                              ),
                            ),
                          )),
                    );
                  }),
                ),
                if (currentIndex != 0)
                  SliverGrid(
                    delegate: SliverChildListDelegate([
                      Container(
                        margin: EdgeInsets.only(top: 20, left: 20),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 15,
                          child: InkWell(
                            splashColor: Colors.blue[200],
                            onTap: () {
                              Navigator.of(context).pushNamed(TeamScreen.route);
                            },
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    EvaIcons.people,
                                    color: Colors.grey,
                                    size: orientation == Orientation.portrait
                                        ? 60
                                        : 100,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  FittedBox(
                                    child: Text(
                                      "Team",
                                      style: TextStyle(
                                          fontFamily: "Opensans",
                                          color: Colors.grey[700],
                                          fontSize: orientation ==
                                                  Orientation.portrait
                                              ? 20
                                              : 36),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20, right: 20),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 15,
                          child: InkWell(
                            splashColor: Colors.blue[200],
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(AchievementPage.route);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.trophy,
                                  color: Colors.grey,
                                  size: orientation == Orientation.portrait
                                      ? 60
                                      : 100,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                FittedBox(
                                  child: Text(
                                    "Achievements",
                                    style: TextStyle(
                                        fontFamily: "Opensans",
                                        color: Colors.grey[700],
                                        fontSize:
                                            orientation == Orientation.portrait
                                                ? 20
                                                : 36),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20, left: 20),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 15,
                          child: Container(
                            child: InkWell(
                              splashColor: Colors.blue[200],
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(ProjectScreen.route);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.assignment,
                                    color: Colors.grey,
                                    size: orientation == Orientation.portrait
                                        ? 60
                                        : 100,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  FittedBox(
                                    child: Text(
                                      "Projects",
                                      style: TextStyle(
                                          fontFamily: "Opensans",
                                          color: Colors.grey[700],
                                          fontSize: orientation ==
                                                  Orientation.portrait
                                              ? 20
                                              : 36),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20, right: 20),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 15,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.pen,
                                color: Colors.grey,
                                size: orientation == Orientation.portrait
                                    ? 60
                                    : 100,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              FittedBox(
                                child: Text(
                                  "Blogs",
                                  style: TextStyle(
                                      fontFamily: "Opensans",
                                      color: Colors.grey[700],
                                      fontSize:
                                          orientation == Orientation.portrait
                                              ? 20
                                              : 36),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ]),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.9,
                      crossAxisSpacing: 10,
                    ),
                  ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    if (currentIndex == 0)
                      SizedBox(
                        height: 100,
                      ),
                    if (currentIndex == 0)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 20),
                        child: TextFormField(
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontSize: 16,
                            // fontWeight: FontWeight.bold,
                          ),
                          enabled: false,
                          decoration: InputDecoration(
                              labelText: "USERNAME",
                              labelStyle: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: 16,
                                  color: Colors.grey[700]),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 0,
                                ),
                              ),
                              fillColor: Color.alphaBlend(
                                Theme.of(context).primaryColor.withOpacity(.07),
                                Colors.grey.withOpacity(.04),
                              ),
                              filled: true,
                              prefixIcon: Icon(
                                Icons.person,
                                size: 30,
                                color: Colors.black,
                              )),
                          initialValue: provider.name,
                        ),
                      ),
                    if (currentIndex == 0)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 20),
                        child: TextFormField(
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontSize: 16,
                            //fontWeight: FontWeight.bold,
                          ),
                          enabled: false,
                          decoration: InputDecoration(
                              labelText: "EMAIL",
                              labelStyle: TextStyle(
                                fontFamily: "OpenSans",
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 0.0,
                                ),
                              ),
                              fillColor: Color.alphaBlend(
                                Theme.of(context).primaryColor.withOpacity(.07),
                                Colors.grey.withOpacity(.04),
                              ),
                              filled: true,
                              prefixIcon: Icon(
                                Icons.email,
                                size: 30,
                                color: Colors.black,
                              )),
                          initialValue: provider.email,
                        ),
                      ),
                    if (currentIndex == 0)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 25),
                        child: TextFormField(
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontSize: 16,
                            //fontWeight: FontWeight.bold,
                          ),
                          enabled: false,
                          decoration: InputDecoration(
                              labelText: "DOMAINS OF INTEREST",
                              labelStyle: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: 16,
                                  color: Colors.grey[700]),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 0.0,
                                ),
                              ),
                              fillColor: Color.alphaBlend(
                                Theme.of(context).primaryColor.withOpacity(.07),
                                Colors.grey.withOpacity(.04),
                              ),
                              filled: true,
                              prefixIcon: Icon(
                                Icons.assessment,
                                size: 30,
                                color: Colors.black,
                              )),
                          initialValue: provider.domain,
                        ),
                      ),
                    SizedBox(
                      height: 250,
                    )
                  ]),
                )
              ],
            ),
            buildFAB(size.height * 0.2, orientation)
          ],
        ),
      ),
    );
  }
}

class FABBottomAppBarItem {
  FABBottomAppBarItem({this.icon, this.text});
  Widget icon;
  String text;
}

class FABBottomAppBar extends StatefulWidget {
  FABBottomAppBar({
    this.items,
    this.height: 60.0,
    this.iconSize: 24.0,
    this.color,
    this.selectedColor = Colors.black,
    this.onTabSelected,
  }) {
    assert(this.items.length == 2 || this.items.length == 4);
  }
  final List<FABBottomAppBarItem> items;
  final String centerItemText = "Home";
  final double height;
  final double iconSize;
  final Color backgroundColor = Colors.white;
  final Color color;
  final Color selectedColor;
  final NotchedShape notchedShape = CircularNotchedRectangle();
  final ValueChanged<int> onTabSelected;

  @override
  State<StatefulWidget> createState() => FABBottomAppBarState();
}

class FABBottomAppBarState extends State<FABBottomAppBar> {
  int _selectedIndex = 0;

  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });
    items.insert(items.length >> 1, _buildMiddleTabItem());

    return BottomAppBar(
      shape: widget.notchedShape,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
      color: widget.backgroundColor,
    );
  }

  Widget _buildMiddleTabItem() {
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: widget.iconSize),
            Text(
              widget.centerItemText ?? '',
              style: TextStyle(color: widget.color),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    FABBottomAppBarItem item,
    int index,
    ValueChanged<int> onPressed,
  }) {
    Color color = _selectedIndex == index ? widget.selectedColor : widget.color;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                item.icon,
                FittedBox(
                  child: Text(
                    item.text,
                    style: TextStyle(color: color),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
