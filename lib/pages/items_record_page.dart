import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/item_panel.dart';
import '../models.dart';
import '../providers.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    List<Item> itemList = List.generate(
        25,
        (index) => Item(
            name: "السلام عليكم $index",
            id: 2000,
            broughtPrice: 120,
            sellingPrice: 200,
            quantity: 1,
            photoPath: "assets/images/8.PNG"));

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[350],
        // appBar: AppBar(
        //   title: Text("Record"),
        //   backgroundColor: Colors.blueGrey[200],
        // ),
        body: Column(
          children: [
            const RecordHeader(),
            Expanded(child: RecordPanelList(itemList: itemList)),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class RecordHeader extends ConsumerWidget {
  const RecordHeader({super.key});
  @override
  Widget build(BuildContext context, ref) {
    final selectedLang = ref.watch(selectedLanguageProvider);

    String title = selectedLang == SelectedLanguage.arabic ? "سجل" : "Record";

    return AbsorbPointer(
      absorbing: false,
      child: Container(
        // duration: Duration(seconds: 1),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.blueGrey[200],
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios),
              ),
              Text(
                title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              //this is a temporary solution
              IconButton(
                onPressed: () => "",
                icon: const Icon(null),
              ),
            ]),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}

class RecordPanelList extends StatelessWidget {
  const RecordPanelList({
    super.key,
    required this.itemList,
  });

  final List<Item> itemList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: (itemList.length / 2).round(),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0) +
              const EdgeInsets.symmetric(vertical: 5),
          child: SizedBox(
            height: 270,
            child: Row(children: [
              Expanded(
                child: ItemPanel(
                  item: itemList[(index * 2)],
                  displayQuantity: false,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: itemList.asMap().containsKey((index * 2) + 1)
                    ? ItemPanel(
                        item: itemList[(index * 2) + 1],
                        displayQuantity: false,
                      )
                    : Container(),
              )
            ]),
          ),
        );
      },
    );
  }
}
