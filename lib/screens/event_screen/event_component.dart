import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:manage_calendar_events/manage_calendar_events.dart';
import 'event_details.dart';

class EventComponent extends StatelessWidget {
  final CalendarEvent event;
  const EventComponent({Key? key, required this.event}) : super(key: key);
  // final CalendarPlugin _myPlugin = CalendarPlugin();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return EventDetails(
                activeEvent: event,
                calendarPlugin: CalendarPlugin(),
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
                Text(
                  event.title!,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(DateFormat("dd MMM").format(event.startDate!)),
              ],
            ),
            event.location!.isNotEmpty ?  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 20,
                ),
                Text(
                  event.location!,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ) : const SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
