import 'package:flutter/material.dart';
import 'package:productivity_app/models/event_data_source.dart';
import 'package:productivity_app/providers/event_provider.dart';
import 'package:productivity_app/widgets/tasks_widget.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;

    return SfCalendar(
      view: CalendarView.month,
      monthViewSettings: MonthViewSettings(
        // numberOfWeeksInView: 4,
        agendaStyle: AgendaStyle(
          backgroundColor: Color(0xFFB3E5FC),
          appointmentTextStyle: TextStyle(
              fontSize: 14, fontStyle: FontStyle.italic, color: Colors.white),
          dateTextStyle: TextStyle(
              fontStyle: FontStyle.normal,
              fontSize: 12,
              fontWeight: FontWeight.w300,
              color: Colors.black),
          dayTextStyle: TextStyle(
              fontStyle: FontStyle.normal,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black),
        ),
        agendaItemHeight: 100,
        dayFormat: 'EEE',
        showAgenda: true,
        agendaViewHeight: 300,
        appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
        navigationDirection: MonthNavigationDirection.vertical,
        monthCellStyle: MonthCellStyle(
          backgroundColor: Color(0xFF5CCCFC),
          leadingDatesBackgroundColor: Color(0xFF9FE9FC),
          trailingDatesBackgroundColor: Color(0xFF9FE9FC),
          todayBackgroundColor: Color(0xFF048CFC),
          textStyle: TextStyle(fontSize: 12, fontFamily: 'Arial'),
          trailingDatesTextStyle: TextStyle(
              fontStyle: FontStyle.italic, fontSize: 12, fontFamily: 'Arial'),
          leadingDatesTextStyle: TextStyle(
              fontStyle: FontStyle.italic, fontSize: 12, fontFamily: 'Arial'),
        ),
      ),
      viewHeaderStyle: ViewHeaderStyle(
        backgroundColor: Color(0xFF6CC4FC),
      ),
      viewHeaderHeight: 75,
      headerStyle: CalendarHeaderStyle(
          textAlign: TextAlign.center,
          backgroundColor: Color(0xFF76D5FC),
          textStyle: TextStyle(
            fontSize: 25,
            fontStyle: FontStyle.normal,
            letterSpacing: 4,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          )),
      dataSource: EventDataSource(events),
      initialSelectedDate: DateTime.now(),
      onLongPress: (details) {
        final provider = Provider.of<EventProvider>(context, listen: false);

        provider.setDate(details.date!);
        showModalBottomSheet(
          context: context,
          builder: (context) => TasksWidget(),
        );
      },
    );
  }
}
