import 'package:firebase_database/firebase_database.dart';

class DataService {
  final String uid;
  final String events;
  DataService(this.uid, this.events);
  final database = FirebaseDatabase.instance;

  Future? saveUser(user) {
    try {
      final userRef = database.reference().child('users').child(uid!);
      userRef.set({
        'uid': user.uid,
        'email': user.email,
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future? saveEvents(user) {
    try {
      final userRef = database.reference().child('users').child(events!);
      userRef.set({
        'uid': user.uid,
        'email': user.email,
        'events': user.events,
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
