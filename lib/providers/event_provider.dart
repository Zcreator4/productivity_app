// import 'package:flutter/cupertino.dart';
// import 'package:productivity_app/event.dart';

// class EventProvider extends ChangeNotifier {
//   final List<Event> _events = [];

//   List<Event> get events => _events;

//   DateTime _selectedDate = DateTime.now();

//   DateTime get selectedDate => _selectedDate;

//   void setDate(DateTime date) => _selectedDate = date;

//   List<Event> get eventsOfSelectedDate => _events;

//   void addEvent(Event event) {
//     _events.add(event);

//     notifyListeners();
//   }

//   void deleteEvent(Event event) {
//     _events.remove(event);

//     notifyListeners();
//   }

//   void editEvent(Event newEvent, Event oldEvent) {
//     final index = _events.indexOf(oldEvent);
//     _events[index] = newEvent;

//     notifyListeners();
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:productivity_app/models/event.dart';
import 'package:productivity_app/utils.dart';

class EventProvider extends ChangeNotifier {
  final List<Event> _events = [];

  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void setDate(DateTime date) => _selectedDate = date;

  List<Event> get eventsOfSelectedDate => _events.where(
        (event) {
          final selected = Utils.removeTime(_selectedDate);
          final from = Utils.removeTime(event.from);
          final to = Utils.removeTime(event.to);

          return from.isAtSameMomentAs(selectedDate) ||
              to.isAtSameMomentAs(selectedDate) ||
              (selected.isAfter(from) && selected.isBefore(to));
        },
      ).toList();

  List<Event> get events => _events;

  void addEvent(Event event) {
    _events.add(event);

    notifyListeners();
  }

  void deleteEvent(Event event) {
    _events.remove(event);

    notifyListeners();
  }

  void editEvent(Event newEvent, Event oldEvent) {
    final index = _events.indexOf(oldEvent);
    _events[index] = newEvent;

    notifyListeners();
  }
}
