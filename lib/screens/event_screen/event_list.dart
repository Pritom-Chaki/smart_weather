import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:manage_calendar_events/manage_calendar_events.dart';

import '../../components/snack_bar/information_snackbar.dart';
import '../../utils/constant_data.dart';
import '../event_screen/event_details.dart';
import 'event_component.dart';
import 'event_details_page.dart';

class EventList extends StatefulWidget {
  final String calendarId;

  const EventList({super.key, required this.calendarId});

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  final CalendarPlugin _myPlugin = CalendarPlugin();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(hours: 3));

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event List"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addEventDialog(context);
        },
        child: const Icon(
          Icons.add_task,
          color: Colors.blue,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(AppConstant.onBackImg2))),
        child: FutureBuilder<List<CalendarEvent>?>(
          future: _fetchEvents(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: Text('No Events found'));
            }
            List<CalendarEvent> events = snapshot.data!;
            return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                CalendarEvent event = events.elementAt(index);
                return Dismissible(
                    key: Key(event.eventId!),
                    confirmDismiss: (direction) async {
                      if (DismissDirection.startToEnd == direction) {
                        setState(() {
                          _deleteEvent(event.eventId!);
                        });

                        return true;
                      } else {
                        setState(() {
                          // _updateEvent(event);
                        });

                        return false;
                      }
                    },

                    // delete option
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 20.0),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    // update the event
                    secondaryBackground: Container(
                      color: Colors.blue,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20.0),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                    child: _eventComponent(event));
              },
            );
          },
        ),
      ),
    );
  }

  Widget _eventComponent(CalendarEvent event) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return EventDetailsPage(
                  activeEvent: event,
                  calendarPlugin: _myPlugin,
                );
              },
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          decoration: BoxDecoration(
              color: Colors.white54, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      event.title!,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  event.hasAlarm!
                      ? IconButton(
                          onPressed: () {
                            _deleteReminder(event.eventId!, event.title!);
                          },
                          icon: const Icon(
                            Icons.notification_important_outlined,
                            color: Colors.blue,
                          ))
                      : IconButton(
                          onPressed: () {
                            _addReminder(event.eventId!, -30, event.title!);
                          },
                          icon: const Icon(Icons.notifications_off_outlined))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  event.location!.isNotEmpty
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              size: 20,
                              color: Colors.red,
                            ),
                            Text(
                              event.location!,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        )
                      : const SizedBox(
                          height: 10.0,
                        ),
                  Text(DateFormat("dd MMM").format(event.startDate!)),
                ],
              ),
            ],
          ),
        ));
  }

  Future<List<CalendarEvent>?> _fetchEvents() async {
    return _myPlugin.getEvents(calendarId: widget.calendarId);
    // return _fetchEventsByDateRange();
    // return _myPlugin.getEventsByMonth(
    //     calendarId: this.widget.calendarId,
    //     findDate: DateTime(2020, DateTime.december, 15));
    // return _myPlugin.getEventsByWeek(
    //     calendarId: this.widget.calendarId,
    //     findDate: DateTime(2021, DateTime.june, 1));
  }

  // ignore: unused_element
  Future<List<CalendarEvent>?> _fetchEventsByDateRange() async {
    DateTime endDate =
        DateTime.now().toUtc().add(const Duration(hours: 23, minutes: 59));
    DateTime startDate = endDate.subtract(const Duration(days: 3));
    return _myPlugin.getEventsByDateRange(
      calendarId: widget.calendarId,
      startDate: startDate,
      endDate: endDate,
    );
  }

  void _addEvent() async {
    CalendarEvent _newEvent = CalendarEvent(
      title: _nameController.text.trim(),
      description: _detailsController.text.trim(),
      startDate: startDate,
      endDate: endDate,
      location: _locationController.text.trim(),
      url: 'https://www.google.com',
      attendees: Attendees(
        attendees: [
          // Attendee(emailAddress: 'test1@gmail.com', name: 'Test1'),
          // Attendee(emailAddress: 'test2@gmail.com', name: 'Test2'),
        ],
      ),
    );
    _myPlugin
        .createEvent(calendarId: widget.calendarId, event: _newEvent)
        .then((evenId) {
      setState(() {
        debugPrint('Event Id is: $evenId');
      });
    });
    _clear();
  }

  void _deleteEvent(String eventId) async {
    _myPlugin
        .deleteEvent(calendarId: widget.calendarId, eventId: eventId)
        .then((isDeleted) {
      debugPrint('Is Event deleted: $isDeleted');
    });
  }

  void _updateEvent(CalendarEvent event) async {
    event.title = 'Updated from Event';
    event.description = 'Test description is updated now';
    event.attendees = Attendees(
      attendees: [
        Attendee(emailAddress: 'updatetest@gmail.com', name: 'Update Test'),
      ],
    );
    _myPlugin
        .updateEvent(calendarId: widget.calendarId, event: event)
        .then((eventId) {
      debugPrint('${event.eventId} is updated to $eventId');
    });

    if (event.hasAlarm!) {
      _updateReminder(event.eventId!, 65);
    } else {
      _addReminder(event.eventId!, -30, event.title!);
    }
  }

  void _addReminder(String eventId, int minutes, String eventName) async {
    _myPlugin.addReminder(
        calendarId: widget.calendarId, eventId: eventId, minutes: minutes);
    InformationSnackBar(
            context: context,
            isSuccess: true,
            message: "Reminder add for $eventName")
        .show();

    setState(() {});
  }

  void _updateReminder(String eventId, int minutes) async {
    _myPlugin.updateReminder(
        calendarId: widget.calendarId, eventId: eventId, minutes: minutes);
  }

  void _deleteReminder(String eventId, String eventName) async {
    _myPlugin.deleteReminder(eventId: eventId);
    setState(() {});
    InformationSnackBar(
            context: context,
            isSuccess: false,
            message: "Reminder remove for $eventName")
        .show();
  }

  Future<void> _addEventDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          insetPadding: EdgeInsets.zero,
          title: const Center(child: Text("Add Your Event")),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 3.0, vertical: 3.0),
          content: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Field Can not be empty";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          labelText: "Event",
                          prefixIcon: Icon(Icons.task),
                          prefixIconColor: Colors.blue),
                    ),
                    TextFormField(
                      controller: _locationController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Field Can not be empty";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          labelText: "Location",
                          prefixIcon: Icon(Icons.location_on),
                          prefixIconColor: Colors.red),
                    ),
                    TextFormField(
                        controller: _startDateController,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Field Can not be empty";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            labelText: "Start Date",
                            prefixIcon: Icon(Icons.calendar_today),
                            prefixIconColor: Colors.deepPurpleAccent),
                        readOnly: true,
                        onTap: () async {
                          _datePicker(true);
                        }),
                    TextFormField(
                        controller: _endDateController,
                        validator: (val) {
                          return null;
                        },
                        decoration: const InputDecoration(
                            labelText: "End Date",
                            prefixIcon: Icon(Icons.calendar_today),
                            prefixIconColor: Colors.orange),
                        readOnly: true,
                        onTap: () async {
                          _datePicker(false);
                        }),
                    TextFormField(
                      controller: _detailsController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Field Can not be empty";
                        }
                        return null;
                      },
                      minLines: 3,
                      maxLines: 3,
                      decoration: const InputDecoration(
                          label: Text("Details"),
                          prefixIcon: Icon(Icons.details),
                          prefixIconColor: Colors.green),
                    ),
                  ],
                ),
              ),
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _clear();
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.red),
                )),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _addEvent();
                    Navigator.of(context).pop();
                  }
                },
                child:
                    const Text("Save", style: TextStyle(color: Colors.green))),
          ],
        );
      },
    );
  }

  _datePicker(bool isStart) async {
    DateTime? pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(), //get today's date
        firstDate: DateTime(
            2000), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));
    if (isStart) {
      startDate = pickerDate!;
      debugPrint(startDate.toString());
      String formattedDate = DateFormat('yyyy-MM-dd').format(startDate);
      debugPrint(formattedDate);
      setState(() {
        _startDateController.text = formattedDate;
      });
    } else {
      endDate = pickerDate!;
      debugPrint(endDate.toString());
      String formattedDate = DateFormat('yyyy-MM-dd').format(endDate);
      debugPrint("END DATE: $formattedDate");
      setState(() {
        _endDateController.text = formattedDate;
      });
    }
  }

  _clear() {
    _nameController.clear();
    _locationController.clear();
    _startDateController.clear();
    _endDateController.clear();
    _detailsController.clear();
  }
}
