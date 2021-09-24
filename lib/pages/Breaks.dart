import 'package:flutter/material.dart';

class BreakSide extends StatefulWidget {
  const BreakSide({Key? key}) : super(key: key);

  @override
  _BreakSideState createState() => _BreakSideState();
}

enum durationType { breaks, work, nothing }

class Block {
  final durationType type;
  int flex = 0;

  Block(this.type, String variance) {
    List<DateTime> zzz = variance.split("–").map(
      (e) {
        return DateTime(
          DateTime.now().year,
          9,
          7,
          e.contains("PM") && int.parse(e.split(":")[0].trim()) < 12
              ? int.parse(e.split(":")[0].trim()) + 12
              : int.parse(e.split(":")[0].trim()),
          int.parse(
              e.replaceAll("AM", "").replaceAll("PM", "").split(":")[1].trim()),
        );
      },
    ).toList();

    var zzzx = zzz[1].difference(zzz[0]);
    flex = zzzx.inMinutes ~/ 15;
  }

  @override
  String toString() => 'Block(type: $type, flex: $flex)';
}

void playWithTime() {
  var x = DateTime(2021, 9, 7, 6, 15);
}

Iterable<Block> breakBrackes({double startTime = 6.15}) {
  var firstData = ('''
Phone
11:00 AM – 12:00 PM
Break12:00 PM – 12:15 PM
Phone
12:15 PM – 2:00 PM
Break 22:00 PM – 2:15 PM
Phone
2:15 PM – 3:15 PM
Break 23:15 PM – 3:45 PM
Phone
3:45 PM – 6:45 PM
Break 26:45 PM – 7:00 PM
Phone
7:00 PM – 8:00 PM
'''
      .replaceAll("Phone\n", "p=")
      .replaceAll("Break 2", "B=")
      .replaceAll("Break", "B=")
      .replaceAll("\n", ";")
      .split(";")
        ..remove(""));

  print(firstData);

  var date = firstData.map((e) => Block(
      e.split("=")[0] == "B" ? durationType.breaks : durationType.work,
      e.split("=")[1]));

  // var zz = Map.fromIterable(date,
  //     key: (k) => k.split("=")[0], value: (v) => v.split("=")[1]);

  // Map<double, double> list = {
  //   6.15:,
  //   2,
  //   7.15: 7.30,
  //   9.15: 9.30,
  //   11.30: 12,
  //   1.15: 1.30,
  // };

  // 36

  // var z = [];

  print(date);
  return date;
}

class _BreakSideState extends State<BreakSide> {
  @override
  Widget build(BuildContext context) {
    breakBrackes();
    return Container(
      width: 20,
      color: Colors.white,
      child: Column(
        children: breakBrackes()
            .map(
              (e) => Expanded(
                flex: e.flex,
                child: Container(
                  color: e.type == durationType.breaks
                      ? Colors.green
                      : Colors.black87,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
