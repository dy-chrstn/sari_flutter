import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Note extends StatelessWidget {
  Note({super.key});
  final List<CardData> cards = [
    CardData(
        "Card 1 Title",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec enim metus, ultrices ac odio nec, commodo pulvinar quam. Etiam sed odio ultrices, viverra ex id, lobortis ligula. Vivamus sit amet volutpat lorem, ac egestas nibh. Suspendisse ac accumsan odio, sit amet facilisis mauris.",
        DateTime.now()),
    CardData(
        "Card 2 Title",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec enim metus, ultrices ac odio nec, commodo pulvinar quam. Etiam sed odio ultrices, viverra ex id, lobortis ligula. Vivamus sit amet volutpat lorem, ac egestas nibh. Suspendisse ac accumsan odio, sit amet facilisis mauris.",
        DateTime.now().subtract(const Duration(days: 1))),
    CardData(
        "Card 3 Title",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec enim metus, ultrices ac odio nec, commodo pulvinar quam. Etiam sed odio ultrices, viverra ex id, lobortis ligula. Vivamus sit amet volutpat lorem, ac egestas nibh. Suspendisse ac accumsan odio, sit amet facilisis mauris.",
        DateTime.now()),
    CardData(
        "Card 4 Title",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec enim metus, ultrices ac odio nec, commodo pulvinar quam. Etiam sed odio ultrices, viverra ex id, lobortis ligula. Vivamus sit amet volutpat lorem, ac egestas nibh. Suspendisse ac accumsan odio, sit amet facilisis mauris.",
        DateTime.now().subtract(const Duration(days: 2))),
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Container(
          color: const Color(0xFFB3CDE4),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: cards.length,
              itemBuilder: (context, index) => buildCard(cards[index]),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox buildCard(CardData cardData) {
    return SizedBox(
      width: 250,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.white,
        child: Row(
          children: [
            const SizedBox(
              width: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cardData.title,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1D3F58)),
                  ),
                  SizedBox(
                    width: 240,
                    child: Text(
                      cardData.description,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 41, 81, 110)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 6),
                   Row(
                    children: [
                      Text(
                        DateFormat.yMd().format(cardData.date),
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(width: 120,),
                      const Text(
                        'Last edited by: Christian',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardData {
  final String title;
  final String description;
  final DateTime date;

  const CardData(this.title, this.description, this.date);
}
