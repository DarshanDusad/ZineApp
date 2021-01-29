import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class AchievementPage extends StatelessWidget {
  static const route = "/achieve";
  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        title: Text(
          "Achievements",
          style: TextStyle(
            fontFamily: "OpenSans",
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(25),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[200],
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              children: [
                TimelineTile(
                  isFirst: true,
                  startChild: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "IEEE Research paper",
                          style: TextStyle(
                              fontFamily: "OpenSans",
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "A research paper on Shortest Path Evaluation with Enhanced Linear Graph and Dijkstra Algorithm was presented at 59th Annual Conference of SICE.",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  endChild: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "November 2020",
                      style: TextStyle(
                        fontFamily: "Lobster",
                        fontSize: 16,
                      ),
                    ),
                  ),
                  afterLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  beforeLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  alignment: TimelineAlign.center,
                  indicatorStyle: IndicatorStyle(
                    iconStyle: IconStyle(
                      iconData: Icons.assignment,
                      fontSize: 30,
                    ),
                    width: 50,
                    color: Colors.red[700],
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                  ),
                ),
                TimelineTile(
                  endChild: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    child: Column(
                      children: [
                        Text(
                          "CSAW Hack3D Hackathon 2020",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "2nd Place in a global virtual hackathon event",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                          ),
                        ),
                        SizedBox(
                          height: orientation == Orientation.portrait ? 30 : 70,
                        ),
                      ],
                    ),
                  ),
                  startChild: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "November 2020",
                        style: TextStyle(
                          fontFamily: "Lobster",
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  afterLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  beforeLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  alignment: TimelineAlign.center,
                  indicatorStyle: IndicatorStyle(
                    iconStyle: IconStyle(
                      iconData: Icons.laptop_chromebook,
                      fontSize: 30,
                    ),
                    width: 50,
                    color: Colors.cyan,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                  ),
                ),
                TimelineTile(
                  startChild: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    child: Column(
                      children: [
                        Text(
                          "Indian Drone Racing League StayAtHome Season 2",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "1st Place in Virtual Drone Race conducted on Velocidrone simulator",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  endChild: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "October 2020",
                      style: TextStyle(
                        fontFamily: "Lobster",
                        fontSize: 16,
                      ),
                    ),
                  ),
                  afterLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  beforeLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  alignment: TimelineAlign.center,
                  indicatorStyle: IndicatorStyle(
                    iconStyle: IconStyle(
                      iconData: const IconData(
                        0xe800,
                        fontFamily: "Trophy",
                        fontPackage: null,
                      ),
                      fontSize: 30,
                    ),
                    width: 50,
                    color: Colors.green[400],
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 15,
                    ),
                  ),
                ),
                TimelineTile(
                  endChild: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    child: Column(
                      children: [
                        Text(
                          "HackJaipur Virtual Hackathon 2020",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "1st Place among 2200+ participants and 360+ teams",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  startChild: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "August 2020",
                        style: TextStyle(
                          fontFamily: "Lobster",
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  afterLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  beforeLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  alignment: TimelineAlign.center,
                  indicatorStyle: IndicatorStyle(
                    iconStyle: IconStyle(
                      iconData: Icons.laptop_chromebook,
                      fontSize: 30,
                    ),
                    width: 50,
                    color: Colors.cyan,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                  ),
                ),
                TimelineTile(
                  startChild: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    child: Column(
                      children: [
                        Text(
                          "Indian Drone Racing League 28, NIT Goa",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "2nd Place in Pro Class Race",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  endChild: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "March 2020",
                      style: TextStyle(
                        fontFamily: "Lobster",
                        fontSize: 16,
                      ),
                    ),
                  ),
                  afterLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  beforeLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  alignment: TimelineAlign.center,
                  indicatorStyle: IndicatorStyle(
                    iconStyle: IconStyle(
                      iconData: const IconData(
                        0xe800,
                        fontFamily: "Trophy",
                        fontPackage: null,
                      ),
                      fontSize: 30,
                    ),
                    width: 50,
                    color: Colors.green[400],
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 15,
                    ),
                  ),
                ),
                TimelineTile(
                  endChild: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    child: Column(
                      children: [
                        Text(
                          "India Drone Festival 2.0, ITDA, Dehradun",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "2nd Place in Tie the Knot",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  startChild: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "March 2020",
                        style: TextStyle(
                          fontFamily: "Lobster",
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  afterLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  beforeLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  alignment: TimelineAlign.center,
                  indicatorStyle: IndicatorStyle(
                    iconStyle: IconStyle(
                      iconData: const IconData(
                        0xe800,
                        fontFamily: "Trophy",
                        fontPackage: null,
                      ),
                      fontSize: 30,
                    ),
                    width: 50,
                    color: Colors.green[400],
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 15,
                    ),
                  ),
                ),
                TimelineTile(
                  startChild: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    child: Column(
                      children: [
                        Text(
                          "Indian Drone Racing League 27, ITDA, Dehradun",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "1st Place in Pro Class Race",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  endChild: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "March 2020",
                      style: TextStyle(
                        fontFamily: "Lobster",
                        fontSize: 16,
                      ),
                    ),
                  ),
                  afterLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  beforeLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  alignment: TimelineAlign.center,
                  indicatorStyle: IndicatorStyle(
                    iconStyle: IconStyle(
                      iconData: const IconData(
                        0xe800,
                        fontFamily: "Trophy",
                        fontPackage: null,
                      ),
                      fontSize: 30,
                    ),
                    width: 50,
                    color: Colors.green[400],
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 15,
                    ),
                  ),
                ),
                TimelineTile(
                  endChild: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    child: Column(
                      children: [
                        Text(
                          "Indian Drone Racing League 26, BITS PIlani Goa",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "2nd Place in Pro Class Race",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  startChild: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "February 2020",
                        style: TextStyle(
                          fontFamily: "Lobster",
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  afterLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  beforeLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  alignment: TimelineAlign.center,
                  indicatorStyle: IndicatorStyle(
                    iconStyle: IconStyle(
                      iconData: const IconData(
                        0xe800,
                        fontFamily: "Trophy",
                        fontPackage: null,
                      ),
                      fontSize: 30,
                    ),
                    width: 50,
                    color: Colors.green[400],
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 15,
                    ),
                  ),
                ),
                TimelineTile(
                  startChild: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    child: Column(
                      children: [
                        Text(
                          "Kshitij 2020, IIT Kharagpur",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "2nd Place in Tesseract (autonomous event)",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  endChild: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "January 2020",
                      style: TextStyle(
                        fontFamily: "Lobster",
                        fontSize: 16,
                      ),
                    ),
                  ),
                  afterLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  beforeLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  alignment: TimelineAlign.center,
                  indicatorStyle: IndicatorStyle(
                    iconStyle: IconStyle(
                      iconData: const IconData(
                        0xf544,
                        fontFamily: "Robot",
                        fontPackage: null,
                      ),
                      fontSize: 25,
                    ),
                    width: 50,
                    color: Colors.yellow[600],
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 15,
                    ),
                  ),
                ),
                TimelineTile(
                  endChild: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    child: Column(
                      children: [
                        Text(
                          "Indian Drone Racing League 24, VJTI, Mumbai",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "1st Place in Pro Class Race",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  startChild: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "December 2019",
                        style: TextStyle(
                          fontFamily: "Lobster",
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  afterLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  beforeLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  alignment: TimelineAlign.center,
                  indicatorStyle: IndicatorStyle(
                    iconStyle: IconStyle(
                      iconData: const IconData(
                        0xe800,
                        fontFamily: "Trophy",
                        fontPackage: null,
                      ),
                      fontSize: 30,
                    ),
                    width: 50,
                    color: Colors.green[400],
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 15,
                    ),
                  ),
                ),
                TimelineTile(
                  startChild: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    child: Column(
                      children: [
                        Text(
                          "Research Paper",
                          style: TextStyle(
                              fontFamily: "OpenSans",
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "A research paper on A novel mobile based hybrid skin tone classification algorithm for Cancer detection was presented at REDSET 19 Conference held at GD Goenka.",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  endChild: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "December 2019",
                      style: TextStyle(
                        fontFamily: "Lobster",
                        fontSize: 16,
                      ),
                    ),
                  ),
                  afterLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  beforeLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  alignment: TimelineAlign.center,
                  indicatorStyle: IndicatorStyle(
                    iconStyle: IconStyle(
                      iconData: Icons.assignment,
                      fontSize: 30,
                    ),
                    width: 50,
                    color: Colors.red[700],
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                  ),
                ),
                TimelineTile(
                  endChild: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    child: Column(
                      children: [
                        Text(
                          "Indian Drone Racing League 23, PDPU, Gandhinagar",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "1st Place and 3rd Place in Pro Class Race",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  startChild: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "November 2019",
                        style: TextStyle(
                          fontFamily: "Lobster",
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  afterLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  beforeLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  alignment: TimelineAlign.center,
                  indicatorStyle: IndicatorStyle(
                    iconStyle: IconStyle(
                      iconData: const IconData(
                        0xe800,
                        fontFamily: "Trophy",
                        fontPackage: null,
                      ),
                      fontSize: 30,
                    ),
                    width: 50,
                    color: Colors.green[400],
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 15,
                    ),
                  ),
                ),
                TimelineTile(
                  startChild: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    child: Column(
                      children: [
                        Text(
                          "Sphinx 2019, MNIT Jaipur",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "1st Place in Robotryst.1st Place and 3rd Place in Drone Rush",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  endChild: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "November 2019",
                        style: TextStyle(
                          fontFamily: "Lobster",
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  afterLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  beforeLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  alignment: TimelineAlign.center,
                  indicatorStyle: IndicatorStyle(
                    iconStyle: IconStyle(
                      iconData: const IconData(
                        0xf544,
                        fontFamily: "Robot",
                        fontPackage: null,
                      ),
                      fontSize: 25,
                    ),
                    width: 50,
                    color: Colors.yellow[600],
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 15,
                    ),
                  ),
                ),
                TimelineTile(
                  endChild: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    child: Column(
                      children: [
                        Text(
                          "Asia Drone League, Malaysia",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Qualified into Top 32, 18th Overall amongst the top 70 pilots in Asia",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  startChild: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "October 2019",
                        style: TextStyle(
                          fontFamily: "Lobster",
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  afterLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  beforeLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  alignment: TimelineAlign.center,
                  indicatorStyle: IndicatorStyle(
                    iconStyle: IconStyle(
                      iconData: const IconData(
                        0xe800,
                        fontFamily: "Trophy",
                        fontPackage: null,
                      ),
                      fontSize: 30,
                    ),
                    width: 50,
                    color: Colors.green[400],
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 15,
                    ),
                  ),
                ),
                TimelineTile(
                  startChild: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    child: Column(
                      children: [
                        Text(
                          "Indian Drone Racing League 22, IIT Gandhinagar",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "1st Place in Pro Class Race",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  endChild: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      child: Text(
                        "October 2019",
                        style: TextStyle(
                          fontFamily: "Lobster",
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  afterLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  beforeLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  alignment: TimelineAlign.center,
                  indicatorStyle: IndicatorStyle(
                    iconStyle: IconStyle(
                      iconData: const IconData(
                        0xe800,
                        fontFamily: "Trophy",
                        fontPackage: null,
                      ),
                      fontSize: 30,
                    ),
                    width: 50,
                    color: Colors.green[400],
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 15,
                    ),
                  ),
                ),
                TimelineTile(
                  endChild: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    child: Column(
                      children: [
                        Text(
                          "Indian Drone Racing League 21, VIT Vellore",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "2nd Place in Pro Class Race",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  startChild: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "October 2019",
                        style: TextStyle(
                          fontFamily: "Lobster",
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  afterLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  beforeLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  alignment: TimelineAlign.center,
                  indicatorStyle: IndicatorStyle(
                    iconStyle: IconStyle(
                      iconData: const IconData(
                        0xe800,
                        fontFamily: "Trophy",
                        fontPackage: null,
                      ),
                      fontSize: 30,
                    ),
                    width: 50,
                    color: Colors.green[400],
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 15,
                    ),
                  ),
                ),
                TimelineTile(
                  startChild: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    child: Column(
                      children: [
                        Text(
                          "Indian Drone Racing League 20, GEU Dehradun",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "2nd Place in Pro Class Race",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  endChild: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      child: Text(
                        "June 2019",
                        style: TextStyle(
                          fontFamily: "Lobster",
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  afterLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  beforeLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  alignment: TimelineAlign.center,
                  indicatorStyle: IndicatorStyle(
                    iconStyle: IconStyle(
                      iconData: const IconData(
                        0xe800,
                        fontFamily: "Trophy",
                        fontPackage: null,
                      ),
                      fontSize: 30,
                    ),
                    width: 50,
                    color: Colors.green[400],
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 15,
                    ),
                  ),
                ),
                TimelineTile(
                  endChild: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    child: Column(
                      children: [
                        Text(
                          "Drone Race, Techidate 2019, Manipal University Jaipur",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "1st Place",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  startChild: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "March 2019",
                        style: TextStyle(
                          fontFamily: "Lobster",
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  afterLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  beforeLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  alignment: TimelineAlign.center,
                  indicatorStyle: IndicatorStyle(
                    iconStyle: IconStyle(
                      iconData: const IconData(
                        0xe800,
                        fontFamily: "Trophy",
                        fontPackage: null,
                      ),
                      fontSize: 30,
                    ),
                    width: 50,
                    color: Colors.green[400],
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 15,
                    ),
                  ),
                ),
                TimelineTile(
                  startChild: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    child: Column(
                      children: [
                        Text(
                          "Game of Drones, JECRC College, Jaipur",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "1st Place and 3rd Place",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  endChild: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      child: Text(
                        "March 2019",
                        style: TextStyle(
                          fontFamily: "Lobster",
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  afterLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  beforeLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  alignment: TimelineAlign.center,
                  indicatorStyle: IndicatorStyle(
                    iconStyle: IconStyle(
                      iconData: const IconData(
                        0xe800,
                        fontFamily: "Trophy",
                        fontPackage: null,
                      ),
                      fontSize: 30,
                    ),
                    width: 50,
                    color: Colors.green[400],
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 15,
                    ),
                  ),
                ),
                TimelineTile(
                  endChild: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    child: Column(
                      children: [
                        Text(
                          "Drone TechX , JECRC University, Jaipur",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "2nd Place and 3rd Place",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  startChild: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "March 2019",
                        style: TextStyle(
                          fontFamily: "Lobster",
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  afterLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  beforeLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  alignment: TimelineAlign.center,
                  indicatorStyle: IndicatorStyle(
                    iconStyle: IconStyle(
                      iconData: const IconData(
                        0xe800,
                        fontFamily: "Trophy",
                        fontPackage: null,
                      ),
                      fontSize: 30,
                    ),
                    width: 50,
                    color: Colors.green[400],
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 15,
                    ),
                  ),
                ),
                TimelineTile(
                  startChild: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    child: Column(
                      children: [
                        Text(
                          "Indian Drone Racing League 19, IIT Delhi",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "2nd Place in Pro Class Race",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  endChild: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      child: Text(
                        "March 2019",
                        style: TextStyle(
                          fontFamily: "Lobster",
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  afterLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  beforeLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  alignment: TimelineAlign.center,
                  indicatorStyle: IndicatorStyle(
                    iconStyle: IconStyle(
                      iconData: const IconData(
                        0xe800,
                        fontFamily: "Trophy",
                        fontPackage: null,
                      ),
                      fontSize: 30,
                    ),
                    width: 50,
                    color: Colors.green[400],
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 15,
                    ),
                  ),
                ),
                TimelineTile(
                  endChild: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    child: Column(
                      children: [
                        Text(
                          "Aerial Drones, BML Munjal, Delhi NCR",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "1st Place and 2nd Place",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  startChild: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "February 2019",
                        style: TextStyle(
                          fontFamily: "Lobster",
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  afterLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  beforeLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  alignment: TimelineAlign.center,
                  indicatorStyle: IndicatorStyle(
                    iconStyle: IconStyle(
                      iconData: const IconData(
                        0xe800,
                        fontFamily: "Trophy",
                        fontPackage: null,
                      ),
                      fontSize: 30,
                    ),
                    width: 50,
                    color: Colors.green[400],
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 15,
                    ),
                  ),
                ),
                TimelineTile(
                  startChild: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    child: Column(
                      children: [
                        Text(
                          "Indian Drone Racing League 17, BITS Pilani, Goa Campus",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "3rd Place in Pro Class Race",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  endChild: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      child: Text(
                        "February 2019",
                        style: TextStyle(
                          fontFamily: "Lobster",
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  afterLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  beforeLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  alignment: TimelineAlign.center,
                  indicatorStyle: IndicatorStyle(
                    iconStyle: IconStyle(
                      iconData: const IconData(
                        0xe800,
                        fontFamily: "Trophy",
                        fontPackage: null,
                      ),
                      fontSize: 30,
                    ),
                    width: 50,
                    color: Colors.green[400],
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 15,
                    ),
                  ),
                ),
                TimelineTile(
                  endChild: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    child: Column(
                      children: [
                        Text(
                          "Kshitij 2019, IIT-Kharagpur",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "1st Place in Zenith (manual event)",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  startChild: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "January 2019",
                        style: TextStyle(
                          fontFamily: "Lobster",
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  afterLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  beforeLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  alignment: TimelineAlign.center,
                  indicatorStyle: IndicatorStyle(
                    iconStyle: IconStyle(
                      iconData: const IconData(
                        0xf544,
                        fontFamily: "Robot",
                        fontPackage: null,
                      ),
                      fontSize: 25,
                    ),
                    width: 50,
                    color: Colors.yellow[600],
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 15,
                    ),
                  ),
                ),
                TimelineTile(
                  isLast: true,
                  startChild: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    child: Column(
                      children: [
                        Text(
                          "Plinth 2019, LNMIIT, Jaipur",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "1st Place and 3rd Place in Drone Obstruction",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  endChild: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      child: Text(
                        "January 2019",
                        style: TextStyle(
                          fontFamily: "Lobster",
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  afterLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  beforeLineStyle: LineStyle(
                    color: Colors.grey[400],
                  ),
                  alignment: TimelineAlign.center,
                  indicatorStyle: IndicatorStyle(
                    iconStyle: IconStyle(
                      iconData: const IconData(
                        0xe800,
                        fontFamily: "Trophy",
                        fontPackage: null,
                      ),
                      fontSize: 30,
                    ),
                    width: 50,
                    color: Colors.green[400],
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
