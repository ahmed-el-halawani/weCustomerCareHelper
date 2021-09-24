import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:open_url/open_url.dart';

class MultiOpener extends StatefulWidget {
  const MultiOpener({Key? key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MultiOpener> {
  List<String> items = [];
  final TextEditingController generateController =
      TextEditingController(text: """http://matrix/cc_searchbycustomerno.php
http://matrix/subscriber_database_logs.php
https://bss.te.eg:12900/oc/bes/sm/login/login-egypt.html
http://tts/new/index.php/static_pages/Search_tickets
https://10.42.187.100:8080/expresse/clearview?lineId=61845287
http://customer360/Customers/0473640724
https://wiki/SiteAssets/WIKI%20Main%20Page/new_tech_page.html
https://wiki/SiteAssets/ADSL-New-Process/index.html
https://wiki/SiteAssets/dev_assets/bss_tree_menu_v3.html
https://wiki/SiteAssets/ADSL-New-Process/index.php/start/scenario/100e.html
https://10.99.105.177:8080/#/home/CpeConfigration""");
  bool loadingState = false;

  void exportToList() {
    setState(() {
      items = generateController.text.isEmpty
          ? []
          : generateController.text.split("\n");
    });
  }

  void clear() {
    generateController.text = "";
    exportToList();
  }

  void openAll() async {
    setState(() {
      loadingState = true;
    });
    exportToList();
    for (var i in items) {
      openUrl(i).then(
        (value) => setState(() {
          loadingState = false;
        }),
      );
    }
  }

  Widget labledButton(IconData icon, String title, void Function()? onPressed) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          IconButton(
            icon: Icon(icon),
            onPressed: onPressed,
          ),
          Text(title),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    return Scaffold(
      appBar: AppBar(
        title: Text("MultiOpener"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: colorScheme.primary.withOpacity(0.05),
                  child: TextFormField(
                    controller: generateController,
                    maxLines: 10,
                    style: TextStyle(fontSize: 12),
                    decoration: InputDecoration(
                      fillColor: Colors.white,

                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(fontSize: 12),
                      hintText:
                          "Input Link and press enter like\nhttp://matrix/cc_searchbycustomerno.php\nhttp://matrix/subscriber_database_logs.php",
                      // labelText: "Set Generate And Press Enter ⏎",
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    labledButton(Icons.delete, "Clear", clear),
                    labledButton(Icons.import_export, "Export Into a List",
                        exportToList),
                    labledButton(Icons.open_in_browser, "Open All", openAll),
                  ],
                ),
              ),
              Expanded(
                child: ReorderableListView(
                  children: <Widget>[
                    for (var i in items)
                      ListTile(
                        key: Key('$i'),
                        tileColor: items.indexOf(i).isOdd
                            ? oddItemColor
                            : evenItemColor,
                        title: Text(i),
                      ),
                  ],
                  onReorder: (int oldIndex, int newIndex) {
                    setState(() {
                      if (oldIndex < newIndex) {
                        newIndex -= 1;
                      }
                      final String item = items.removeAt(oldIndex);
                      items.insert(newIndex, item);
                      generateController.text = items
                          .reduce((value, element) => value + "\n" + element);
                    });
                  },
                ),
              ),
            ],
          ),
          loadingState
              ? Container(
                  color: Colors.black.withOpacity(.8),
                  child: Center(child: CircularProgressIndicator()),
                )
              : Container(),
        ],
      ),
    );
  }
}
