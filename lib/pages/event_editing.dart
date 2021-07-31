import 'package:flutter/material.dart';
import 'package:productivity_app/models/event.dart';
import 'package:productivity_app/models/myAppUser.dart';
import 'package:productivity_app/providers/event_provider.dart';
import 'package:productivity_app/services/database.dart';
import 'package:productivity_app/utils.dart';
import 'package:provider/provider.dart';

class EventEditingPage extends StatefulWidget {
  final AppEvent? event;
  MyAppUser currentUser;

  EventEditingPage({
    Key? key,
    this.event,
    required this.currentUser,
  }) : super(key: key);

  @override
  _EventEditingPageState createState() => _EventEditingPageState();
}

class _EventEditingPageState extends State<EventEditingPage> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final user1Controller = TextEditingController();
  final user2Controller = TextEditingController();
  late DateTime fromDate;
  late DateTime toDate;
  bool isAllDay = false;

  @override
  void initState() {
    super.initState();

    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now().add(Duration(hours: 2));
    } else {
      final event = widget.event!;

      titleController.text = event.title;
      descriptionController.text = event.description;
      fromDate = event.from;
      toDate = event.to;
      isAllDay = event.isAllDay;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF76D5FC),
          leading: CloseButton(),
          actions: buildEditingActions(widget.currentUser),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                buildTitle(),
                SizedBox(height: 12),
                buildDateTimePickers(),
                SizedBox(height: 12),
                buildDescription(),
                buildUser1(),
                buildUser2(),
              ],
            ),
          ),
        ),
      );

  List<Widget> buildEditingActions(currentUser) => [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          onPressed: () async {
            final isValid = _formKey.currentState!.validate();

            if (isValid) {
              final event = AppEvent(
                title: titleController.text,
                description: descriptionController.text,
                from: fromDate,
                to: isAllDay ? fromDate : toDate,
                isAllDay: isAllDay,
                eventUsers: [
                  user1Controller.text,
                  user2Controller.text,
                  currentUser.uid
                ],
              );
              await DataService().saveEvents(event);
              final isEditing = widget.event != null;
              final provider =
                  Provider.of<EventProvider>(context, listen: false);

              if (isEditing) {
                provider.editEvent(event, widget.event!);

                Navigator.of(context).pop();
              } else {
                provider.addEvent(event);
              }

              Navigator.of(context).pop();
            }
          },
          icon: Icon(Icons.done),
          label: Text('SAVE'),
        ),
      ];

  Widget buildTitle() => TextFormField(
        style: TextStyle(fontSize: 24),
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          hintText: 'Add Title',
        ),
        validator: (title) =>
            title != null && title.isEmpty ? 'Title cannot be empty' : null,
        controller: titleController,
      );

  Widget buildDescription() => TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Add Details',
        ),
        textInputAction: TextInputAction.newline,
        maxLines: 5,
        controller: descriptionController,
      );

  Widget buildUser1() => TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'User 1 uid',
        ),
        textInputAction: TextInputAction.newline,
        maxLines: 1,
        controller: user1Controller,
      );

  Widget buildUser2() => TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'User 2 uid',
        ),
        textInputAction: TextInputAction.newline,
        maxLines: 1,
        controller: user2Controller,
      );

  Widget buildDateTimePickers() => Column(
        children: [
          buildFrom(),
          if (!isAllDay) buildTo(),
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            title: Text('All Day Event'),
            value: isAllDay,
            activeColor: Theme.of(context).primaryColor,
            onChanged: (value) => setState(() => isAllDay = value!),
          )
        ],
      );

  Widget buildFrom() => buildHeader(
        header: 'FROM',
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: buildDropdownField(
                text: Utils.toDate(fromDate),
                onClicked: () => pickFromDateTime(pickDate: true),
              ),
            ),
            if (!isAllDay)
              Expanded(
                child: buildDropdownField(
                  text: Utils.toTime(fromDate),
                  onClicked: () => pickFromDateTime(pickDate: false),
                ),
              ),
          ],
        ),
      );

  Widget buildTo() => buildHeader(
        header: 'TO',
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: buildDropdownField(
                text: Utils.toDate(toDate),
                onClicked: () => pickToDateTime(pickDate: true),
              ),
            ),
            Expanded(
              child: buildDropdownField(
                text: Utils.toTime(toDate),
                onClicked: () => pickToDateTime(pickDate: false),
              ),
            ),
          ],
        ),
      );

  Widget buildHeader({
    required String header,
    required Widget child,
  }) =>
      Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(header, style: TextStyle(fontWeight: FontWeight.bold)),
            child,
          ],
        ),
      );

  Widget buildDropdownField({
    required String text,
    required VoidCallback onClicked,
  }) =>
      ListTile(
        title: Text(text),
        trailing: Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );

  Future pickFromDateTime({required bool pickDate}) async {
    final date = await pickDateTime(fromDate, pickDate: pickDate);
    if (date == null) return;

    if (date.isAfter(toDate)) {
      toDate =
          DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
    }

    setState(() => fromDate = date);
  }

  Future pickToDateTime({required bool pickDate}) async {
    final date = await pickDateTime(
      toDate,
      pickDate: pickDate,
      firstDate: pickDate ? fromDate : null,
    );
    if (date == null) return;

    setState(() => toDate = date);
  }

  Future<DateTime?> pickDateTime(
    DateTime initialDate, {
    required bool pickDate,
    DateTime? firstDate,
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate ?? DateTime(2015, 8),
        lastDate: DateTime(2101),
      );

      if (date == null) return null;

      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);

      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );

      if (timeOfDay == null) return null;

      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);

      return date.add(time);
    }
  }

//   Future saveForm(currentUser) async {
//     final isValid = _formKey.currentState!.validate();

//     if (isValid) {
//       final event = AppEvent(
//         title: titleController.text,
//         description: descriptionController.text,
//         from: fromDate,
//         to: isAllDay ? fromDate : toDate,
//         isAllDay: isAllDay,
//         eventUsers: [
//           user1Controller.text,
//           user2Controller.text,
//           currentUser.uid
//         ],
//       );
//       await DataService().saveEvents(event);
//       final isEditing = widget.event != null;
//       final provider = Provider.of<EventProvider>(context, listen: false);

//       if (isEditing) {
//         provider.editEvent(event, widget.event!);

//         Navigator.of(context).pop();
//       } else {
//         provider.addEvent(event);
//       }

//       Navigator.of(context).pop();
//     }
//   }
// }
}
