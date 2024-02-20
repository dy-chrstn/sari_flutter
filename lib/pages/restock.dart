import 'package:flutter/material.dart';
import 'package:group_list_view/group_list_view.dart';

class Restock extends StatelessWidget {
  const Restock({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, List> elements = {
      'February': ['Supermarket', 'Sampol', 'Daily'],
      'January': ['Puregold', 'O!Save'],
    };

    return Scaffold(
      body: Container(
        color: const Color(0xFFB3CDE4),
        child: Column(
          children: [
            const SizedBox(height: 5),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10, bottom: 6),
                child: GroupListView(
                  sectionsCount: elements.keys.toList().length,
                  //sectionsCount: _elements.keys.toList().length,
                  countOfItemInSection: (int section) {
                    return elements.values.toList()[section].length;
                  },
                  itemBuilder: (BuildContext context, IndexPath index) {
                    return SizedBox(
                      height: 74,
                      width: double.infinity,
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Row(children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  elements.values.toList()[index.section]
                                      [index.index],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: Color(0xFF1D3F58)),
                                ),
                                const Text(
                                  '01/29/24',
                                  style: TextStyle(color: Color(0xFF1D3F58)),
                                )
                              ],
                            ),
                            const Spacer(),
                            const Text(
                              '₱495.00',
                              style: TextStyle(color: Color(0xFF1D3F58)),
                            ),
                          ]),
                        ),
                      ),
                    );
                  },
                  groupHeaderBuilder: (BuildContext context, int section) {
                    return SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        child: Text(
                          elements.keys.toList()[section],
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Color(0xFF1D3F58)),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 3),
                  sectionSeparatorBuilder: (context, section) =>
                      const SizedBox(height: 0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
