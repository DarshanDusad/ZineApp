import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';

const mainUrl = "18.207.115.53:3000";
const testUrl = "10.0.2.2";
const url = "18.207.115.53:3000";

class Message {
  DateTime dateTime;
  Member sender;
  String text;
  Message({
    this.dateTime,
    this.sender,
    this.text,
  });
}

class Member {
  String name;
  String uid;
  Color color;
  Member({
    this.name,
    this.uid,
    this.color,
  });
}

class Room {
  String id;
  String name;
  List<Member> members;
  List<Message> messages;
  Color color;
  Room({this.id, this.name, this.members, this.messages, this.color});
}

class Data with ChangeNotifier {
  bool isAnonymous = false;
  bool initDone = false;
  int number = -1;
  bool networkError = false;
  var colors = [
    Colors.green,
    Colors.pink,
    Colors.deepOrange,
    Colors.purple,
    Colors.amber[700],
    Colors.teal,
    Colors.blue[800],
    Colors.red[800]
  ];
  String token;
  String name;
  String email;
  String domain = "DUMMY";
  String uid;
  SocketIO socketIO;
  int currentRoom = 0;

  List<Room> rooms = [];

  void addData(String token, String name, String email, String uid) {
    this.token = token;
    this.name = name;
    this.email = email;
    this.uid = uid;
    notifyListeners();
  }

  void clear() {
    this.token = null;
    this.name = null;
    this.email = null;
    this.socketIO.unSubscribesAll();
    this.socketIO.disconnect();
    this.socketIO = null;
    this.number = -1;
    this.initDone = false;
    this.currentRoom = 0;
    this.rooms = [];
    notifyListeners();
  }

  Future<void> fetchRooms() async {
    http.Response response;
    try {
      print("uid:" + uid);
      print("token:" + token);
      response = await http.post(
        "http://$url/api/rooms",
        headers: {
          "authorization": "Bearer $token",
          "content-type": "application/json",
        },
        body: json.encode(
          {
            "userId": uid,
          },
        ),
      );
      var body = json.decode(response.body);
      print(body);
      if (body != null) {
        List fetchedRooms = body["chats"];
        number = fetchedRooms.length;
        print("rooms: $number");
        notifyListeners();
        fetchedRooms.forEach((element) async {
          var roomId = element["_id"];
          String roomName = element["conversationName"];
          List members = element["participants"];

          List<Member> participants = [];
          members.forEach((data) async {
            var info = data["info"];

            // http.Response info = await http.get(
            //   "http://$url/api/user?userId=$id",
            //   headers: {
            //     "authorization": "Bearer $token",
            //     "content-type": "application/json",
            //   },
            // );

            if (info != null) {
              var index = Random().nextInt(6);
              var color = colors[index];
              var id = info["id"];
              var name = info["name"];
              if (!participants.any((element) => element.name == name)) {
                participants.add(
                  Member(
                    name: name,
                    uid: id,
                    color: color,
                  ),
                );
              }
            }
          });

          // List<Message> chats = [];
          // http.Response messages = await http.post(
          //   "http://$url/api/messages",
          //   headers: {
          //     "authorization": "Bearer $token",
          //     "content-type": "application/json",
          //   },
          //   body: json.encode(
          //     {
          //       "roomId": roomId,
          //     },
          //   ),
          // );
          // if (json.decode(messages.body) != null) {
          //   List messageBody = json.decode(messages.body)["messages"];
          //   if (messageBody != null) {
          //     messageBody.forEach((element) {
          //       String text = element["content"];
          //       String name = element["senderName"];
          //       String id = element["senderId"];
          //       Member member;

          //       if (name != null) {
          //         member = participants.firstWhere(
          //           (element) => element.name == name,
          //           orElse: () {
          //             return Member(
          //               name: name,
          //               uid: id,
          //               color: Colors.green,
          //             );
          //           },
          //         );
          //         DateTime date = DateTime.parse(element["createdAt"]);

          //         chats.add(Message(
          //           text: text,
          //           sender: member,
          //           dateTime: date,
          //         ));
          //       }
          //     });
          //   }
          // }

          if (roomName == "undefined,undefined" ||
              !rooms.any((element) => element.name == roomName)) {
            print("Added room : $roomName ");
            var index = Random().nextInt(8);
            if (roomName.contains(name)) {
              int i = roomName.indexOf(",");
              var firstName = roomName.substring(0, i);
              var secondName = roomName.substring(i + 1, roomName.length);
              roomName = firstName == name ? secondName : firstName;
            }
            if (roomName == "undefined,undefined" && participants.length == 2) {
              roomName = participants[0].name == name
                  ? participants[1].name
                  : participants[0].name;
            }
            if (participants.isEmpty) {
              participants.add(
                Member(
                  color: Colors.red,
                  uid: "0000",
                  name: "Invalid Room",
                ),
              );
            }
            rooms.add(
              Room(
                  id: roomId,
                  name: roomName,
                  members: participants,
                  messages: [],
                  color: colors[index]),
            );

            notifyListeners();
          }
        });
      }
    } catch (error) {
      print("ERROR");
      networkError = true;
      notifyListeners();
    }
    sort();
  }

  void sort() {
    rooms.forEach((element) {
      element.members.sort(
          (m1, m2) => m1.name.toLowerCase().compareTo(m2.name.toLowerCase()));
    });
    rooms.sort((room1, room2) =>
        room1.name.toLowerCase().compareTo(room2.name.toLowerCase()));
  }

  Future<void> init() async {
    try {
      socketIO = SocketIOManager().createSocketIO('http://$url', "/");
      socketIO.init();
      socketIO.connect();
      socketIO.subscribe('message', (jsonData) {
        print(jsonData);
        var data = json.decode(jsonData);
        var id = data["senderId"];
        var name = data["senderName"];
        print("halo");
        var member = rooms[currentRoom].members.firstWhere((element) {
          print("ay");
          return element.uid == id;
        }, orElse: () {
          print("ey");
          return Member(
            name: name,
            uid: id,
            color: Colors.pink,
          );
        });
        rooms[currentRoom].messages.add(
              Message(
                  dateTime: DateTime.now(),
                  sender: member,
                  text: data["content"]),
            );
        notifyListeners();
      });
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> changeRoom(int index) async {
    currentRoom = index;
    socketIO.sendMessage(
      'leave-room',
      json.encode(
        {"userId": uid, "name": name, "roomId": rooms[currentRoom].id},
      ),
    );
    socketIO.sendMessage(
      'join-room',
      json.encode(
        {
          "userId": uid,
          "name": name,
          "roomId": rooms[index].id,
        },
      ),
    );
    List<Message> chats = [];
    http.Response messages = await http.post(
      "http://$url/api/messages",
      headers: {
        "authorization": "Bearer $token",
        "content-type": "application/json",
      },
      body: json.encode(
        {
          "roomId": rooms[currentRoom].id,
        },
      ),
    );
    if (json.decode(messages.body) != null) {
      List messageBody = json.decode(messages.body)["messages"];
      if (messageBody != null) {
        messageBody.forEach((element) {
          String text = element["content"];
          String name = element["senderName"];
          String id = element["senderId"];
          Member member;

          if (name != null) {
            member = rooms[currentRoom].members.firstWhere(
              (element) => element.name == name,
              orElse: () {
                return Member(
                  name: name,
                  uid: id,
                  color: Colors.green,
                );
              },
            );
            DateTime date = DateTime.parse(element["createdAt"]);

            chats.add(Message(
              text: text,
              sender: member,
              dateTime: date.add(
                Duration(hours: 5, minutes: 30),
              ),
            ));
          }
        });
      }
      rooms[currentRoom].messages = chats;
    }

    notifyListeners();
  }

  Future<void> getDMroom(Member member) async {
    http.Response request = await http.get(
      "http://$url/api/checkroom?userId=${member.uid}&firstUserName=${member.name}&secondUserName=${this.name}",
      headers: {
        "authorization": "Bearer $token",
        "content-type": "application/json",
      },
    );
    var body = json.decode(request.body);
    var name = member.name;
    var id = body["room"]["_id"];
    List<Member> participants = [];
    var index = Random().nextInt(8);
    var color = colors[index];
    participants.add(
      Member(
        uid: member.uid,
        color: member.color,
        name: member.name,
      ),
    );
    participants.add(
      Member(
        uid: this.uid,
        name: this.name,
        color: color,
      ),
    );
    participants.sort(
        (m1, m2) => m1.name.toLowerCase().compareTo(m2.name.toLowerCase()));

    if (!rooms.any((element) => element.name == name)) {
      rooms.add(
        Room(
          id: id,
          name: name,
          members: participants,
          messages: [],
        ),
      );
      rooms.sort((room1, room2) =>
          room1.name.toLowerCase().compareTo(room2.name.toLowerCase()));
      notifyListeners();
    }
    number++;
    notifyListeners();
  }
}
