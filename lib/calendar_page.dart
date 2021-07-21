import 'package:flutter/material.dart';
import 'package:productivity_app/calendar_widget.dart';
import 'package:productivity_app/event_editing.dart';

class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Calendar'),
          centerTitle: true,
        ),
        body: CalendarWidget(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: Colors.green,
          onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => EventEditingPage())),
        ),
      );
}
