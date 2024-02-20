import 'package:flutter/material.dart';
import 'restock_add.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'note.dart';
import 'restock.dart';
import 'note_add.dart';

class Record extends StatefulWidget {
  const Record({super.key});

  @override
  State<Record> createState() => _RecordState();
}

class _RecordState extends State<Record> with TickerProviderStateMixin {
  late TabController _tabController;
  String titleBar = 'Record';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
              _tabController.index == 0 ? 'Restock' : 'Note'), // Dynamic title
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: const Color(0xFF001B2E),
            tabs: [
              Tab(icon: SvgPicture.asset('lib/assets/restock.svg')),
              Tab(icon: SvgPicture.asset('lib/assets/note.svg')),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [const Restock(), Note()],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 24.0, right: 8.0),
          child: FloatingActionButton(
            onPressed: () {
              if (_tabController.index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RestockAdd(
                      initialPriceList: const [],
                      onChanged: (bool) {},
                    ),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NoteAdd()
                  ),
                );
              }
            },
            backgroundColor: const Color(0xFF1D3F58),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
