import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  static const String route = "/info";
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "About",
            style: TextStyle(
              fontFamily: "OpenSans",
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text(
                  "ZINE",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "MENTOR",
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
              Padding(
                padding: EdgeInsets.only(
                  top: 30,
                  right: 30,
                  left: 30,
                  bottom: 5,
                ),
                child: Image.asset(
                  "assets/images/logo_without_shadow.png",
                  width: 150,
                  height: 300,
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Welcome to Zine!",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 30,
                  right: 30,
                  left: 30,
                  bottom: 30,
                ),
                child: Text(
                  "Zine is the robotics and research group of Malaviya National Institute of Technology, Jaipur with a motive to foster undergraduate students and provide them with a platform to learn, explore and bring their imaginations to life. Under the guidance of our mentor  Dr. Rajesh Kumar, HoD, Electrical engineering department, the group is motivated to improve and apply the technical skills of individuals to solve contemporary problems and foster the growth of the society and hence the nation in the field of technology. It has been one of the most active robotics and research group of MNIT since 2006. Since then our alumni have been our mentors and have provided constant support, irrespective of the fact that they are currently working in different firms and research projects in different parts of world. Zine has always added to its glory by participating and achieving in various national and international events, doing core research works and publishing research articles in reputed publications like IEEE journals etc.",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    color: Colors.black,
                  ),
                ),
              )
            ]),
            ListView(children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Image.asset(
                  "assets/images/rajesh_sir.jpg",
                  width: 150,
                  height: 300,
                ),
              ),
              Container(
                margin: EdgeInsets.all(30),
                child: Text(
                  "Dr. Rajesh Kumar received the Bachelor of Technology in Engineering degree with honors in Electrical Engineering, National Institute of Technology, Kurukshetra, India  1994, Master of Engineering with honors in Power Engineering from the Department of Electrical Engineering, Malaviya National Institute of Technology, Jaipur. India in 1997 and Ph.D. degree in Intelligent Systems from the University of Rajasthan, India in 2005. He is currently HOD of Electrical Department at Malaviya National Institute of Technology, Jaipur, India. He has been Research Fellow (A) at the Department of Electrical Engineering at National University of Singapore from 2009-2011. He has been Reader from 2005-2009, Senior Lecturer from 2000-2005 and Lecturer from 1995-2000 at Department of Electrical Engineering, Malaviya National National Institute of Technology. He is the founder of ZINE student innovative group. His background is in the fields of Computational Intelligence, Artificial Intelligence, Power Engineering, Energy Harvesting and Management, Control Theory, Robotics, Automation, Bioinformatics.",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    color: Colors.black,
                  ),
                ),
              )
            ])
          ],
        ),
      ),
    );
  }
}
