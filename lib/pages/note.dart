import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class Note extends StatelessWidget {
  Note({super.key});
  final List<CardData> cards = [
    CardData("Card 1 Title", "Description", DateTime.now()),
    CardData("Card 2 Title", "Description", DateTime.now().subtract(const Duration(days: 1))),
    CardData("Card 3 Title", "Description", DateTime.now()),
    CardData("Card 4 Title", "Description", DateTime.now().subtract(const Duration(days: 2))),
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
  Row buildCard(CardData cardData) {
    return Row(
      children: [
        Expanded(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cardData.title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Text(cardData.description),
                  const SizedBox(height: 8.0),
                  Text(
                    DateFormat.yMd().format(cardData.date),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 2,),
        Expanded(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cardData.title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Text(cardData.description),
                  const SizedBox(height: 8.0),
                  Text(
                    DateFormat.yMd().format(cardData.date),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CardData {
  final String title;
  final String description;
  final DateTime date;

  const CardData(this.title, this.description, this.date);
}