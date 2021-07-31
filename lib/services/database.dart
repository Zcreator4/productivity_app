import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:productivity_app/models/event.dart';
import 'package:productivity_app/models/myAppUser.dart';
import 'package:uuid/uuid.dart';

class DataService {
  final database = FirebaseDatabase.instance;

  Future? saveUser(user) {
    try {
      final userRef = database.reference().child('users').child(user.uid!);
      userRef.set({
        'uid': user.uid,
        'email': user.email,
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future? saveEvents(AppEvent event) {
    String id = Uuid().v1();
    try {
      final eventRef = database.reference().child('events').child(id);
      eventRef.set({
        'uid': id,
        'title': event.title,
        'to': event.to.toString(),
        'from': event.from.toString(),
        'description': event.description,
        'isAllDay': event.isAllDay,
        'eventUsers': event.eventUsers
      });
      print('Hello');
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  List<AppEvent> getEvents(AsyncSnapshot snapshot, MyAppUser user) {
    final dataRef = FirebaseDatabase.instance.reference().child('events');
    List<AppEvent> list = [];
    if (snapshot.data.snapshot.value == null) {
      return list;
    }
    Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
    map.forEach(
      (key, value) {
        for (var eventUser in value['eventUsers']) {
          if (user.uid == eventUser) {
            DateTime from = DateTime.parse(value['from']);
            DateTime to = DateTime.parse(value['to']);
            list.add(AppEvent(
                title: value['title'],
                description: value['description'],
                from: from,
                to: to,
                eventUsers: value['eventUsers']));
          }
        }
      },
    );
    return list;
  }
}
