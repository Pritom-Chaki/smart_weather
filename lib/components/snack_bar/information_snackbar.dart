import 'package:flutter/material.dart';

class InformationSnackBar {
  final BuildContext? context;
  final String? message;
  final bool? isSuccess;

  InformationSnackBar({
    this.context,
    this.message,
    this.isSuccess,
  });

  show() {
    ScaffoldMessenger.of(context!)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        duration: const Duration(seconds: 2),
       // behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.white,
       // margin: const EdgeInsets.only(bottom: 100, left: 15, right: 15),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        dismissDirection: DismissDirection.horizontal,
        content: Container(
          height: 40,
          color: Colors.transparent,
          alignment: Alignment.centerLeft,

          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSuccess! ? Colors.green : Colors.red,
                ),
                child: Icon(
                  isSuccess! ? Icons.check_circle_outline : Icons.cancel,
                  size: 20,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              SizedBox(
                child: Text(message != null ? message! : "Something Went Wrong",
                    style: TextStyle(
                      fontSize: 14,
                      color: isSuccess! ? Colors.green : Colors.red,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
        ),
      ));
  }
}
