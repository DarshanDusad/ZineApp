import 'package:flutter/material.dart';

class TeamScreen extends StatelessWidget {
  static const route = "/team";
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Team",
            style: TextStyle(
              fontFamily: "OpenSans",
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text(
                  "2ND YEAR",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "3RD YEAR",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "4TH YEAR",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                  ),
                ),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView(children: [
              Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/rajesh_sir.jpg"),
                    radius: 50,
                  ),
                  title: Text(
                    "Rajesh Sir",
                    style: TextStyle(
                      fontFamily: "OpenSans",
                      fontSize: 24,
                    ),
                  ),
                ),
              )
            ]),
            ListView(children: []),
            ListView(children: []),
          ],
        ),
      ),
    );
  }
}
