import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:manage_calendar_events/manage_calendar_events.dart';
import '../../models/local_task_model.dart';
import '../../utils/constant_data.dart';
import 'event_list.dart';

class EventListScreen extends StatefulWidget {
  const EventListScreen({Key? key}) : super(key: key);

  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  List<LocalTaskModel> tasks = [];
  final CalendarPlugin _myPlugin = CalendarPlugin();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget _futureBuilder = FutureBuilder<List<Calendar>?>(
      future: _fetchCalendars(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        List<Calendar> calendars = snapshot.data!;
        return ListView.builder(
            shrinkWrap: true,
            // physics: const NeverScrollableScrollPhysics(),
            itemCount: calendars.length,
            itemBuilder: (context, index) {
              Calendar calendar = calendars[index];
              return ListTile(
                title: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8.0),
                    color: Colors.white30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Text(
                          calendar.name!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.w500),
                        )),
                        const Icon(Icons.arrow_forward),
                      ],
                    )),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return EventList(calendarId: calendar.id!);
                      },
                    ),
                  );
                },
              );
            });
      },
    );

    return Scaffold(
      // appBar: AppBar(
      //   title:Text(
      //     'Event Group List',
      //     style: Theme.of(context)
      //         .textTheme
      //         .titleLarge!
      //         .copyWith(fontWeight: FontWeight.w500),
      //   ),
      // ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(AppConstant.onBackImg2))),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Event Group List',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Expanded(child: _futureBuilder),
          ],
        ),
      ),
    );
  }

  Future<List<Calendar>?> _fetchCalendars() async {
    _myPlugin.hasPermissions().then((value) {
      if (!value!) {
        _myPlugin.requestPermissions();
      }
    });

    return _myPlugin.getCalendars();
  }
}
