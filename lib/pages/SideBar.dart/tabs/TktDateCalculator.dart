// 14-09-2021, 11:11 AM

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';

class TktDateCalculator extends StatefulWidget {
  TktDateCalculator({Key? key}) : super(key: key);

  @override
  _TktDateCalculatorState createState() => _TktDateCalculatorState();
}

class _TktDateCalculatorState extends State<TktDateCalculator> {
  static const globalFormater = "dd-MM-yyyy, hh:mm a";
  final TextEditingController startController = TextEditingController();

  final TextEditingController endController = TextEditingController(
    text:
        new DateFormat("dd-MM-yyyy, hh:mm a").format(DateTime.now()).toString(),
  );

  String calculateDate = "0 days";

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${duration.inDays} days ${twoDigits(duration.inDays >= 0 ? (duration.inHours - duration.inDays * 24) : duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  void calculate(String? s) {
    if (dateFormateValidator(startController.text) != null &&
        dateFormateValidator(endController.text) != null) return null;

    if (startController.text.isNotEmpty && endController.text.isNotEmpty) {
      try {
        var d = (getDateFromString(endController.text)!
            .difference(getDateFromString(startController.text)!));

        setState(() {
          calculateDate = _printDuration(d);
        });
      } catch (e) {
        print(e);
      }
    }
  }

  DateTime? getDateFromString(String? date) {
    if (date == null) return null;

    var z = new DateFormat("MMMM dd, yyyy,h:mm:ss");

    DateTime? newDate;

    try {
      newDate = z.parse(date);

      return newDate;
    } catch (e) {
      try {
        z = new DateFormat("dd-MM-yyyy, hh:mm a");
        newDate = z.parse(date);

        return newDate;
      } catch (e) {
        print(e);
        return DateTime.tryParse(date);
      }
    }
  }

  String? dateFormateValidator(String? date) {
    return getDateFromString(date) != null ? null : "wrong date time format";
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        "Enter start and end date ",
      ),
      actions: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: CupertinoDialogAction(
            child: Text("Close"),
            isDefaultAction: true,
            isDestructiveAction: true,
            onPressed: Navigator.of(context).pop,
          ),
        )
      ],
      content: Material(
        color: Colors.transparent,
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: startController,
                decoration: InputDecoration(
                  labelText: "Start Date",
                  suffix: InkWell(
                    onTap: () async {
                      var z = await showDatePicker(
                        context: context,
                        initialDate: getDateFromString(startController.text) ??
                            DateTime.now(),
                        firstDate: DateTime(1970),
                        lastDate: DateTime.now(),
                      );
                      startController.text = z != null
                          ? DateFormat(globalFormater).format(z)
                          : startController.text;
                      calculate("");
                    },
                    child: Icon(Ionicons.md_calendar),
                  ),
                ),
                onChanged: calculate,
                validator: dateFormateValidator,
              ),
              TextFormField(
                controller: endController,
                decoration: InputDecoration(
                  labelText: "End Date",
                  suffix: InkWell(
                    onTap: () async {
                      var z = await showDatePicker(
                        context: context,
                        initialDate: getDateFromString(endController.text) ??
                            DateTime.now(),
                        firstDate: DateTime(1970),
                        lastDate: DateTime.now(),
                      );
                      endController.text = z != null
                          ? DateFormat(globalFormater).format(z)
                          : endController.text;
                      calculate("");
                    },
                    child: Icon(Ionicons.md_calendar),
                  ),
                ),
                onChanged: calculate,
                validator: dateFormateValidator,
              ),
              Container(
                alignment: Alignment.center,
                color: Colors.red,
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.only(top: 6.0),
                child: Text(
                  calculateDate,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
