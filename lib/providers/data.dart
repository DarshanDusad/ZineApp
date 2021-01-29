import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';

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
  Room({
    this.id,
    this.name,
    this.members,
    this.messages,
  });
}

class Data with ChangeNotifier {
  bool isAnonymous = false;
  bool initDone = false;
  int number = -1;
  var colors = [
    Colors.green,
    Colors.pink,
    Colors.deepOrange,
    Colors.purple,
    Colors.amber[700],
    Colors.teal
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
  }

  Future<void> fetchRooms() async {
    http.Response response;
    try {
      print("uid:" + uid);
      print("token:" + token);
      response = await http.post(
        "http://18.207.115.53:3000/api/rooms",
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

      //print(body);
      if (body != null) {
        //print("rooms:");
        // print(body);
        List fetchedRooms = body["chats"];
        number = fetchedRooms.length;
        notifyListeners();
        fetchedRooms.forEach((element) async {
          var roomId = element["_id"];
          var roomName = element["conversationName"];
          List members = element["participants"];

          List<Member> participants = [];
          members.forEach((data) async {
            var id = data["id"];

            http.Response info = await http.get(
              "http://18.207.115.53:3000/api/user?userId=$id",
              headers: {
                "authorization": "Bearer $token",
                "content-type": "application/json",
              },
            );
            if (json.decode(info.body) != null) {
              var index = Random().nextInt(6);
              var color = colors[index];
              // if (json.decode(info.body)["user"] == null) {
              //   print("Room" + roomName + " has ghosts!");
              // }
              //print("Members of room name : " + roomName);
              if (json.decode(info.body)["user"] != null) {
                var name = json.decode(info.body)["user"]["fullName"];
                if (!participants.any((element) => element.name == name)) {
                  if (name == null) {
                    name = "NULL";
                  }
                  participants.add(
                    Member(
                      name: name,
                      uid: id,
                      color: color,
                    ),
                  );
                }
                //print(name);

              }
            }
          });
          List<Message> chats = [];
          http.Response messages = await http.post(
            "http://18.207.115.53:3000/api/messages",
            headers: {
              "authorization": "Bearer $token",
              "content-type": "application/json",
            },
            body: json.encode(
              {
                "roomId": roomId,
              },
            ),
          );
          if (json.decode(messages.body) != null) {
            // print("messages:");
            // print(json.decode(messages.body));
            List messageBody = json.decode(messages.body)["messages"];
            if (messageBody != null) {
              messageBody.forEach((element) {
                String text = element["content"];
                String name = element["senderName"];
                String id = element["senderId"];
                Member member;

                if (name != null) {
                  member = participants.firstWhere(
                    (element) => element.name == name,
                    orElse: () {
                      return Member(name: name, uid: id, color: Colors.green);
                    },
                  );
                  DateTime date = DateTime.parse(element["createdAt"]);

                  chats.add(Message(
                    text: text,
                    sender: member,
                    dateTime: date,
                  ));
                }
              });
            }
          }
          // print(messages);
          if (!rooms.any((element) => element.name == roomName)) {
            print("Added room!");
            rooms.add(
              Room(
                  id: roomId,
                  name: roomName,
                  members: participants,
                  messages: chats),
            );

            notifyListeners();
          }
        });
      }
    } catch (error) {
      print(error.toString());
    }
    sort();

    notifyListeners();
  }

  void sort() {
    rooms.sort((room1, room2) =>
        room1.name.toLowerCase().compareTo(room2.name.toLowerCase()));
    rooms.forEach((element) {
      element.members.sort(
          (m1, m2) => m1.name.toLowerCase().compareTo(m2.name.toLowerCase()));
    });
  }

  Future<void> init() async {
    try {
      print("init");
      socketIO =
          SocketIOManager().createSocketIO('http://18.207.115.53:3000', "/");
      socketIO.init();
      print("After init");
      socketIO.connect();
      socketIO.subscribe('message', (jsonData) {
        print("Message receivedkkkk");
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
                  dateTime: DateTime.parse(data["createdAt"]),
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
    notifyListeners();
  }
}
