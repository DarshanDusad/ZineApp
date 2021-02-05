import 'package:flutter/material.dart';

class TeamScreen extends StatelessWidget {
  static const route = "/team";
  String getEmail(String text) {
    String firstPart = text;
    String secondPart;
    if (text.contains(" ")) {
      firstPart = text.substring(0, text.indexOf(" "));
      secondPart = text.substring(text.indexOf(" ") + 1, text.length);
      return firstPart.toLowerCase() + "@zine.co.in";
    }
    if (firstPart.length < 2) {
      firstPart += firstPart;
    }
    return firstPart.toLowerCase() + "@zine.co.in";
  }

  @override
  Widget build(BuildContext context) {
    var names = [
      "Apoorva Raj",
      "Aryaman Singh",
      "Chirayu Rankawat",
      "Darshan Dusad",
      "Devansh Garg",
      "Harshit Garg",
      "Ishika Panwar",
      "Pavnesh Chaturvedi",
      "Puneet Singh",
      "Rahul Raj",
      "Rushil Makkar",
      "Bhanu Mohindra",
      "Brijraj",
      "Charu",
      "Dhruv Goyal",
      "Harsh Chaudhary",
      "Muskan Garg",
      "Nikita Rautela",
      "Pravesh Singh",
      "Rajat Agarwal",
      "Sneha Yadav",
      "Keshav",
      "Paarth Bir",
      "Pranav Kulshestra",
      "Sumit Soni",
      "Tanishk Dudi",
      "Tanmay Agarwal",
      "Vibhor Rawal",
      "Vishal Kothari"
    ];
    var branches = [
      "Mechanical",
      "Electrical",
      "Mechanical",
      "Computer Science",
      "Mechanical",
      "Mechanical",
      "Computer Science",
      "Electronics",
      "Electronics",
      "Mechanical",
      "Electronics",
      "Mechanical",
      "Mechanical",
      "Chemical",
      "Computer Science",
      "Mechanical",
      "Civil",
      "Mechanical",
      "Computer Science",
      "Electrical",
      "Electrical",
      "Electronics",
      "Electronics",
      "Electrical",
      "Computer Science",
      "Mechanical",
      "Electronics",
      "Computer Science",
      "Electronics"
    ];
    var ids = [
      "2019UME1219@mnit.ac.in",
      "2019UEE1722@mnit.ac.in",
      "2019UME1357@mnit.ac.in",
      "2019UCP1416@mnit.ac.in",
      "2019UME1883@mnit.ac.in",
      "2019UME1205@mnit.ac.in",
      "2019UCP1661@mnit.ac.in",
      "2019KUEC2037@iitkota.ac.in",
      "2019UEC1355@mnit.ac.in",
      "2019UME1141@mnit.ac.in",
      "2019UEC1713@mnit.ac.in",
      "2018UME1145@mnit.ac.in",
      "2018UME1267@mnit.ac.in",
      "2018UCH1772@mnit.ac.in",
      "2018UCP1460@mnit.ac.in",
      "2018UME1704@mnit.ac.in",
      "2018UCE1332@mnit.ac.in",
      "2018UME1753@mnit.ac.in",
      "2018KUCP1007@iiitkota.ac.in",
      "2018UEE1316@mnit.ac.in",
      "2018UEE1231@mnit.ac.in",
      "2017UEC1341@mnit.ac.in",
      "2017UEC1096@mnit.ac.in",
      "2017UEE1091@mnit.ac.in",
      "2017UCP1323@mnit.ac.in",
      "2017UME1366@mnit.ac.in",
      "2017UEC1547@mnit.ac.in",
      "2017KUCP100@iiitkota.ac.in",
      "2017UEC1683@mnit.ac.in"
    ];

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.blue[600],
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
            ListView.builder(
              itemBuilder: (context, i) {
                return Card(
                  elevation: 15,
                  margin: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage("assets/images/team${i + 1}.jpg"),
                        ),
                        Container(
                          width: 180,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FittedBox(
                                  child: Text(
                                    names[i],
                                    style: TextStyle(
                                      fontFamily: "OpenSans",
                                      color: Colors.grey,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                FittedBox(
                                  child: Text(
                                    branches[i],
                                    style: TextStyle(
                                      fontFamily: "OpenSans",
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                FittedBox(
                                  child: Text(
                                    getEmail(names[i]),
                                    style: TextStyle(
                                        fontFamily: "OpenSans",
                                        color: Colors.grey,
                                        fontSize: 13),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: 11,
            ),
            ListView.builder(
              itemBuilder: (context, i) {
                return Card(
                  elevation: 15,
                  margin: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage("assets/images/team${i + 12}.jpg"),
                        ),
                        Container(
                          width: 180,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FittedBox(
                                  child: Text(
                                    names[i + 11],
                                    style: TextStyle(
                                        fontFamily: "OpenSans",
                                        color: Colors.grey,
                                        fontSize: 18),
                                  ),
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                FittedBox(
                                  child: Text(
                                    branches[i + 11],
                                    style: TextStyle(
                                      fontFamily: "OpenSans",
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                FittedBox(
                                  child: Text(
                                    getEmail(names[i + 11]),
                                    style: TextStyle(
                                        fontFamily: "OpenSans",
                                        color: Colors.grey,
                                        fontSize: 13),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: 10,
            ),
            ListView.builder(
              itemBuilder: (context, i) {
                return Card(
                  elevation: 15,
                  margin: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage("assets/images/team${i + 22}.jpg"),
                        ),
                        Container(
                          width: 180,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FittedBox(
                                  child: Text(
                                    names[i + 21],
                                    style: TextStyle(
                                        fontFamily: "OpenSans",
                                        color: Colors.grey,
                                        fontSize: 18),
                                  ),
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                FittedBox(
                                  child: Text(
                                    branches[i + 21],
                                    style: TextStyle(
                                      fontFamily: "OpenSans",
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                FittedBox(
                                  child: Text(
                                    getEmail(names[i + 21]),
                                    style: TextStyle(
                                        fontFamily: "OpenSans",
                                        color: Colors.grey,
                                        fontSize: 13),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: 8,
            ),
          ],
        ),
      ),
    );
  }
}
