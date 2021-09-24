import 'package:flutter/material.dart';
import 'package:open_url/open_url.dart';

class QuickOpener extends StatefulWidget {
  const QuickOpener({Key? key}) : super(key: key);

  @override
  _QuickOpenerState createState() => _QuickOpenerState();
}

class _QuickOpenerState extends State<QuickOpener> {
  final includedList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quick Opener List"),
        centerTitle: true,
      ),
      body: ListView(
        children: toolsName.entries
            .map(
              (e) => CheckboxListTile(
                title: Text(e.value),
                value: QuickOpenSettingsData.tools[e.key],
                onChanged: (b) {
                  setState(() {});
                  QuickOpenSettingsData.tools[e.key] = b ?? false;
                },
              ),
            )
            .toList(),
        // [
        //   CheckboxListTile(
        //     title: Text("Assia"),
        //     value: QuickOpenSettingsData.tools[Tools.assia],
        //     onChanged: (b) {
        //       QuickOpenSettingsData.tools[Tools.assia] = b;
        //     },
        //   ),
        // ]
      ),
    );
  }
}

enum Tools { matrix, bss, nst, assia, tts, cst360 }

Map<Tools, String> toolsName = {
  Tools.tts: "tts",
  Tools.matrix: "matrix",
  Tools.nst: "nst",
  Tools.assia: "assia",
  Tools.bss: "bss",
  Tools.cst360: "cst360",
};

String toolsToString(Tools tool) => toolsName[tool] ?? "noName tool";

class QuickOpenSettingsData {
  static Map<Tools, bool> tools = {
    Tools.matrix: true,
    Tools.nst: true,
    Tools.assia: true,
    Tools.bss: true,
    Tools.tts: true,
    Tools.cst360: true,
  };

  static void openTools(String dslNumber) {
    tools.forEach((key, value) {
      if (value) {
        switch (key) {
          case Tools.assia:
            return assia(dslNumber);
          case Tools.matrix:
            return assia(dslNumber);

          case Tools.bss:
            return bss(dslNumber);

          case Tools.nst:
            return nst();

          case Tools.tts:
            return tts();

          case Tools.cst360:
            return cst360(dslNumber);
        }
      }
    });
  }

  static void matrix(String dslNumber) {
    dslNumber = dslNumber[0] == "0" ? dslNumber.substring(1) : dslNumber;
    final code;
    final number;
    if (dslNumber[0] == "2" || dslNumber[0] == "3") {
      code = dslNumber[1];
      number = dslNumber.substring(1);
    } else {
      code = dslNumber.substring(0, 2);
      number = dslNumber.substring(2);
    }

    openUrl(
        "http://matrix/cc_caption_code.php?citycode=${code}&txtphone=${number}&button");
  }

  static void bss(String dslNumber) {
    dslNumber = dslNumber[0] == "0" ? dslNumber.substring(1) : dslNumber;
    openUrl(
        "https://bss.te.eg:12900/oc/resource.root/bes/ad/person/telecomm/overseascustview/bes-ad-agent-overseascustview.html?custId=&beId=101&custCode=&serviceNum=$dslNumber");
  }

  static void assia(String dslNumber) {
    dslNumber = dslNumber[0] == "0" ? dslNumber.substring(1) : dslNumber;
    openUrl(
        "https://10.42.187.100:8080/expresse/clearview?lineId=$dslNumber&andor=And&search");
  }

  static void cst360(String dslNumber) {
    dslNumber = dslNumber[0] == "0" ? dslNumber.substring(1) : dslNumber;
    openUrl("http://10.13.120.90/Customers/$dslNumber");
  }

  static void tts() {
    openUrl("http://tts/new/index.php/static_pages/Search_tickets");
  }

  static void nst() {
    openUrl("http://matrix/cc_searchbycustomerno.php");
  }
}
