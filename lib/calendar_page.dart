import 'package:flutter/material.dart';
import 'package:productivity_app/calendar_widget.dart';
import 'package:productivity_app/event_editing.dart';
import 'package:productivity_app/event_provider.dart';
import 'package:provider/provider.dart';

class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => EventProvider(),
        child: Scaffold(
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
        ),
      );
}
