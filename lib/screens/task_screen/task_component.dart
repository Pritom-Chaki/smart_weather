import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/local_task_model.dart';
import 'task_details_page.dart';

class TaskComponent extends StatelessWidget {
final  LocalTaskModel task;
  const TaskComponent({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  TaskDetailsPage(task: task,)),
        );
      },
      child: Container(
        margin:
        const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        padding:
        const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  task.task,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(DateFormat("dd MMM").format( task.date)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 20,
                ),
                Text(
                  task.location,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
