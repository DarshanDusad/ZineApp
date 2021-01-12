import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

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
  var colors = [
    Colors.green,
    Colors.pink,
    Colors.blue,
    Colors.purple,
    Colors.amber
  ];
  String token;
  String name;
  String email;
  String domain = "DUMMY";
  String uid;
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
  }

  Future<void> fetchRooms() async {
    http.Response response;
    try {
      print("uid:" + uid);
      print("token:" + token);
      response = await http.post(
        "http://10.0.2.2:3000/api/rooms",
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
      print("hello");
      print(body);
      if (body != null) {
        print("rooms:");
        // print(body);
        List fetchedRooms = body["chats"];
        fetchedRooms.forEach((element) async {
          var roomId = element["_id"];
          var roomName = element["conversationName"];
          List members = element["participants"];

          List<Member> participants = [];
          members.forEach((data) async {
            var id = data["id"];

            http.Response info = await http.get(
              "http://10.0.2.2:3000/api/user?userId=$id",
              headers: {
                "authorization": "Bearer $token",
                "content-type": "application/json",
              },
            );
            if (json.decode(info.body) != null) {
              var index = Random().nextInt(5);
              var color = colors[index];
              var name = json.decode(info.body)["user"]["fullName"];
              //print(name);
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
          });
          List<Message> chats = [];
          http.Response messages = await http.post(
            "http://10.0.2.2:3000/api/messages",
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
            rooms.add(
              Room(
                  id: roomId,
                  name: roomName,
                  members: participants,
                  messages: chats),
            );
          }
        });
      }
    } catch (error) {
      print(error.toString());
    }
    notifyListeners();
  }

  void sort() {
    rooms.sort((room1, room2) =>
        room1.name.toLowerCase().compareTo(room2.name.toLowerCase()));
    rooms.forEach((element) {
      element.members.sort(
          (m1, m2) => m1.name.toLowerCase().compareTo(m2.name.toLowerCase()));
    });
    notifyListeners();
  }

  void init() {
    print("In init");
    IO.Socket socket = IO.io(
      'http://10.0.2.2:3000/',
      <String, dynamic>{
        'transports': ['websocket', 'polling'],
      },
    );
    socket.onConnectError(
      (_) {
        print('connect');
      },
    );
    socket.connect();
    print(socket.connected);
  }
}
